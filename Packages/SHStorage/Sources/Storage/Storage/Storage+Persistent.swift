import Foundation
import Models
import PersistentModels
import struct StaticModels.Migration
import SHLogger

extension Storage {
    final class Persistent {
        var factories = [Factory]()
        var settings = Settings()
        
        private let v2 = V2()
        private let logger = SHLogger(category: "Persistent")
        
        var configuration: Configuration.Persistent.V2 {
            get { v2.configuration }
            set { v2.configuration = newValue }
        }
        
        var pins: Pins.Persistent.V2 {
            get { v2.pins }
            set { v2.pins = newValue }
        }
        
        func load(staticStorage: Storage.Static) throws {
            logger.info("Loading Persistent storage.")
            
            // Step 1
            let legacy = Legacy()
            guard try legacy.canBeLoaded() || v2.canBeLoaded() else {
                logger.info("Persistent storage is not detected, saving initial data.")
                try v2.saveInitial()
                return
            }
            
            // Step 2
            let migration = createContentMigration(staticStorage: staticStorage)
            try migrateIfNeeded(legacy: legacy, migration: migration)
            
            // Setp 3
            factories = try v2.factories.map { factory in
                try Factory(id: factory.id, name: factory.name, productions: factory.productionIDs.compactMap { productionID in
                    guard let production = v2.productions.first(where: { $0.id == productionID }) else {
                        let error = Error.productionNotFound(productionID, factoryID: factory.id)
                        logger.error(error)
                        throw error
                    }
                    
                    let item: any Item = try staticStorage[itemID: production.itemID]
                    
                    return Production(
                        id: productionID,
                        name: production.name,
                        item: item,
                        amount: production.amount
                    )
                })
            }
            
            settings = Settings(
                itemViewStyle: try Settings.ItemViewStyle(fromID: v2.settings.itemViewStyleID),
                autoSelectSingleRecipe: v2.settings.autoSelectSingleRecipe,
                autoSelectSinglePinnedRecipe: v2.settings.autoSelectSinglePinnedRecipe
            )
            
            logger.info("Persistent Storage is loaded.")
        }
        
        func save() throws {
            logger.info("Saving Persistent storage.")
            try v2.save()
            logger.info("Persistent storage is saved.")
        }
    }
}

private extension Storage.Persistent {
    func migrateIfNeeded(legacy: Legacy, migration: Migration?) throws {
        logger.info("Migrating Persistent storage.")
        
        // Handle each version separately
        if try legacy.canBeLoaded() {
            logger.debug("Legacy Persistent storage detected. Starting Legacy -> V2 migration.")
            
            try legacy.load()
            try v2.migrate(legacy: legacy, migration: migration)
            try legacy.remove()
        }
        
        // Migrate next versions
        // if try v2.canBeLoaded() {
        //     ...
        // }
    }
    
    func createContentMigration(staticStorage: Storage.Static) -> Migration? {
        logger.info("Creating migration.")
        
        let contentVersion = configuration.version
        
        let remainingMigrations = staticStorage.migrations
            .filter { $0.version > contentVersion }
            .sorted()
        
        guard !remainingMigrations.isEmpty else {
            // There is no new migration, exit
            logger.info("Content does not require migration, skipping.")
            return nil
        }
        
        var migrationPlan = remainingMigrations[0]
        if remainingMigrations.count > 1 {
            for migration in remainingMigrations.dropLast() {
                migrationPlan.version = max(migrationPlan.version, migration.version)
                
                for (mergedIndex, partID) in migrationPlan.partIDs.enumerated() {
                    guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID.newID)
                    else { continue }
                    
                    migrationPlan.partIDs[mergedIndex].newID = migration.partIDs[migrationIndex].newID
                }
                
                for (mergedIndex, equipmentID) in migrationPlan.equipmentIDs.enumerated() {
                    guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID.newID)
                    else { continue }
                    
                    migrationPlan.equipmentIDs[mergedIndex].newID = migration.equipmentIDs[migrationIndex].newID
                }
                
                for (mergedIndex, recipeID) in migrationPlan.recipeIDs.enumerated() {
                    guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID.newID)
                    else { continue }
                    
                    migrationPlan.recipeIDs[mergedIndex].newID = migration.recipeIDs[migrationIndex].newID
                }
            }
        }
        
        return migrationPlan
    }
}

// MARK: - Subscripts
extension Storage.Persistent {
    subscript(factoryID id: UUID) -> Factory? {
        get {
            logger.debug("Fetching factory '\(id)'")
            
            let factory = factories.first(id: id)
            
            if let factory {
                logger.debug("Found factory '\(id)' - '\(factory.name)'")
            } else {
                logger.debug("Factory '\(id)' is not found")
            }
            
            return factory
        }
        
        set {
            logger.debug("Updating factory '\(id)'")
            
            let index = factories.firstIndex(id: id)
            
            guard newValue != nil || index != nil else {
                logger.debug("Factory '\(id)' is not saved and new value is nil. Nothing to update")
                return
            }
            
            if let index {
                let savedFactory = factories[index]
                logger.debug("Found factory '\(id)' - '\(savedFactory.name)'")
                
                if let newValue {
                    logger.debug("Replacing factory '\(id)' - '\(savedFactory.name)'")
                    
                    factories[index] = newValue
                } else {
                    logger.debug("New value is nil, removing saved factory '\(id)' - '\(savedFactory.name)'")
                    
                    factories.remove(at: index)
                }
            } else {
                logger.debug("Factory '\(id)' is not saved")
                
                if let newValue {
                    logger.debug("Saving factory '\(id)' - '\(newValue.name)'")
                    
                    factories.append(newValue)
                }
            }
            
            logger.debug("Factory '\(id)' updated")
        }
    }
    
    subscript(productionID id: UUID) -> Production? {
        logger.debug("Fetching production '\(id)'")
        
        let (factory, production): (Factory?, Production?) = (nil, nil)
        
        if let factory, let production {
            logger.debug("Found production '\(production.id)' - '\(production.name)' in factory '\(factory.id)' - '\(factory.name)'")
        } else {
            logger.debug("Production '\(id)' is not found in any factory")
        }
        
        return production
    }
    
    subscript(factoryID factoryID: UUID, productionID productionID: UUID) -> Production? {
        get {
            logger.debug("Fetching production '\(productionID)' from factory '\(factoryID)'")
            
            guard let factory = self[factoryID: factoryID] else { return nil }
            let production = factory.productions.first(id: productionID)
            
            if let production {
                logger.debug("Found production '\(production.id)' - '\(production.name)' in factory '\(factory.id)' - '\(factory.name)'")
            } else {
                logger.debug("Production '\(productionID)' is not found in factory '\(factory.id)' - '\(factory.name)'")
            }
            
            return production
        }
        
        set {
            logger.debug("Updating production '\(productionID)' in factory '\(factoryID)'")
            
            guard let factoryIndex = factories.firstIndex(id: factoryID) else { return }
            let factory = factories[factoryIndex]
            
            let productionIndex = factory.productions.firstIndex(id: productionID)
            
            guard newValue != nil || productionIndex != nil else {
                logger.debug(
                    """
                    Production '\(productionID)' is not saved inside factory '\(factory.id)' - '\(factory.name)' \
                    and new value is nil. Nothing to update
                    """
                )
                return
            }
            
            if let productionIndex {
                let savedProduction = factory.productions[productionIndex]
                logger.debug(
                    """
                    Found production '\(savedProduction.id)' - '\(savedProduction.name)' \
                    inside factory '\(factory.id)' - '\(factory.name)'
                    """
                )
                
                if let newValue {
                    logger.debug(
                        """
                        Replacing production '\(savedProduction.id)' - '\(savedProduction.name)' \
                        inside factory '\(factory.id)' - '\(factory.name)'
                        """
                    )
                    
                    factories[factoryIndex].productions[productionIndex] = newValue
                } else {
                    logger.debug(
                        """
                        New value is nil, removing saved production '\(savedProduction.id)' - '\(savedProduction.name)' \
                        from factory '\(factory.id)' - '\(factory.name)'
                        """
                    )
                    
                    factories[factoryIndex].productions.remove(at: productionIndex)
                }
            } else {
                logger.debug("Production '\(productionID)' is not saved inside factory '\(factory.id)' - '\(factory.name)'")
                
                if let newValue {
                    logger.debug(
                        """
                        Saving production '\(productionID)' \
                        inside factory '\(factory.id)' - '\(factory.name)'
                        """
                    )
                    
                    factories[factoryIndex].productions.append(newValue)
                }
            }
            
            logger.debug("Production '\(productionID)' in factory '\(factoryID)' updated.")
        }
    }
    
    subscript(isPartPinned partID: String) -> Bool {
        get {
            let isPinned = pins.partIDs.contains(partID)
            
            logger.debug("Part '\(partID)' \(isPinned ? "is" : "is not") pinned.")
            
            return isPinned
        }
        
        set {
            let oldValue = self.pins.partIDs.contains(partID)
            guard newValue != oldValue else { return }
            
            logger.debug("Part pin change from '\(oldValue ? "Pinned" : "Unpinned")' to '\(newValue ? "Pinned" : "Unpinned")'.")
            
            if newValue {
                pins.partIDs.insert(partID)
            } else {
                pins.partIDs.remove(partID)
            }
        }
    }
    
    subscript(isEquipmentPinned equipmentID: String) -> Bool {
        get {
            let isPinned = pins.equipmentIDs.contains(equipmentID)
            
            logger.debug("Equipment '\(equipmentID)' \(isPinned ? "is" : "is not") pinned.")
            
            return isPinned
        }
        
        set {
            let oldValue = self.pins.equipmentIDs.contains(equipmentID)
            guard newValue != oldValue else { return }
            
            logger.debug("Equipment pin change from '\(oldValue ? "Pinned" : "Unpinned")' to '\(newValue ? "Pinned" : "Unpinned")'.")
            
            if newValue {
                pins.equipmentIDs.insert(equipmentID)
            } else {
                pins.equipmentIDs.remove(equipmentID)
            }
        }
    }
    
    subscript(isRecipePinned recipeID: String) -> Bool {
        get {
            let isPinned = pins.recipeIDs.contains(recipeID)
            
            logger.debug("Recipe '\(recipeID)' \(isPinned ? "is" : "is not") pinned.")
            
            return isPinned
        }
        
        set {
            let oldValue = self.pins.recipeIDs.contains(recipeID)
            guard newValue != oldValue else { return }
            
            logger.debug("Recipe pin change from '\(oldValue ? "Pinned" : "Unpinned")' to '\(newValue ? "Pinned" : "Unpinned")'.")
            
            if newValue {
                pins.recipeIDs.insert(recipeID)
            } else {
                pins.recipeIDs.remove(recipeID)
            }
        }
    }
}

// MARK: - Errors
private extension Storage.Persistent {
    enum Error: LocalizedError {
        case productionNotFound(UUID, factoryID: UUID)
        
        var errorDescription: String? {
            switch self {
            case .productionNotFound: "Production is not found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .productionNotFound(id, factoryID): 
                "Production '\(id)' cannot be found as a part of Factory '\(factoryID)'."
            }
        }
    }
}
