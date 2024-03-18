import Foundation
import Models
import PersistentModels
import struct StaticModels.Migration
import SHLogger

extension Storage {
    final class Persistent {
        var configuration: Configuration.Persistent.V2 { v2.configuration }
        
        var pins: Pins.Persistent.V2 {
            get { v2.pins }
            set { v2.pins = newValue }
        }
        
        var factories = [Factory]()
        var settings = Settings()
        
        private let v2 = V2()
        
        private let _logger = SHLogger(category: "Persistent")
        
        func load(staticStorage: Storage.Static) throws {
            _logger {
                $0.info("Loading 'Storage.Persistent'")
            }
            
            // Step 1: Check if persistent storage is empty
            _logger(scope: .trace) {
                $0.trace("Step 1: Check if persistent storage is empty")
            }
            let legacy = Legacy()
            guard try legacy.canBeLoaded() || v2.canBeLoaded() else {
                _logger(scope: .trace) {
                    $0.info("Persistent storage is empty, saving initial persistent storage")
                }
                try v2.saveInitial()
                return
            }
            
            // Step 2: Persistent storage is not empty, attemp to migrate to the final version if needed
            _logger(scope: .trace) {
                $0.trace("Step 2: Migrate storage versions if needed")
            }
            try migrateSchemaIfNeeded(legacy: legacy)
            
            // Setp 3: Convert 'persistent models' to 'models'
            _logger(scope: .trace) {
                $0.trace("Step 3: Converting 'persistent models' to 'models'")
            }
            factories = try v2.factories.map { factory in
                try Factory(id: factory.id, name: factory.name, productions: factory.productionIDs.compactMap { productionID in
                    guard let production = v2.productions.first(where: { $0.id == productionID }) else {
                        throw Error.productionNotFound(productionID, factoryID: factory.id)
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
            
            _logger(scope: .trace) {
                $0.trace("Step 4: Converting 'persistent settings' to 'settings'")
            }
            settings = Settings(
                itemViewStyle: try Settings.ItemViewStyle(fromID: v2.settings.itemViewStyleID),
                autoSelectSingleRecipe: v2.settings.autoSelectSingleRecipe,
                autoSelectSinglePinnedRecipe: v2.settings.autoSelectSinglePinnedRecipe
            )
            
            _logger {
                $0.info("'Storage.Persistent' loaded")
            }
        }
        
        func save() throws {
            try v2.save()
        }
        
        func migrateContent(migration: Migration) {
            _logger {
                $0.info("'Storage.Persistent' start content migration")
            }
            
            _logger(scope: .trace) {
                $0.trace("Migrating Parts")
            }
            for partID in pins.partIDs {
                guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID) else { continue }
                
                let newPartID = migration.partIDs[migrationIndex].newID
                pins.partIDs.replace(partID, to: newPartID)
                _logger(scope: .trace) {
                    $0.trace("Migrated '\(partID)' → '\(newPartID)'")
                }
            }
            
            _logger(scope: .trace) {
                $0.trace("Migrating Equipment")
            }
            for equipmentID in pins.equipmentIDs {
                guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
                
                let newEquipmentID = migration.equipmentIDs[migrationIndex].newID
                pins.equipmentIDs.replace(equipmentID, to: newEquipmentID)
                _logger(scope: .trace) {
                    $0.trace("Migrated '\(equipmentID)' → '\(newEquipmentID)'")
                }
            }
            
            _logger(scope: .trace) {
                $0.trace("Migrating Recipes")
            }
            for recipeID in pins.recipeIDs {
                guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
                
                let newRecipeID = migration.recipeIDs[migrationIndex].newID
                pins.recipeIDs.replace(recipeID, to: newRecipeID)
                _logger(scope: .trace) {
                    $0.trace("Migrated '\(recipeID)' → '\(newRecipeID)'")
                }
            }
            
            _logger {
                $0.info("'Storage.Persistent' finish content migration")
            }
        }
        
        private func migrateSchemaIfNeeded(legacy: Legacy) throws {
            _logger {
                $0.info("'Storage.Persistent' start schema migration")
            }
            
            // Handle each version separately
            if try legacy.canBeLoaded() {
                _logger(scope: .trace) {
                    $0.trace("Legacy persistent storage found, migrate persistent storage from 'legacy'")
                }
                try v2.migrate(from: legacy)
            }
            
            // Migrate next versions
            // if try v2.canBeLoaded() {
            //     ...
            // }
            
            _logger {
                $0.info("'Storage.Persistent' finished schema migration")
            }
        }
    }
}

private extension Set {
    mutating func replace(_ oldMember: Element, to newMember: Element) {
        remove(oldMember)
        insert(newMember)
    }
}

// MARK: - Subscripts

extension Storage.Persistent {
    subscript(factoryID id: UUID) -> Factory? {
        get {
            _logger(scope: .trace) {
                $0.trace("Fetching factory '\(id)'")
            }
            
            let factory = factories.first(id: id)
            
            if let factory {
                _logger(scope: .trace) {
                    $0.trace("Found factory '\(id)' - '\(factory.name)'")
                }
            } else {
                _logger(scope: .trace) {
                    $0.trace("Factory '\(id)' is not found")
                }
            }
            
            return factory
        }
        
        set {
            _logger(scope: .trace) {
                $0.trace("Updating factory '\(id)'")
            }
            
            let index = factories.firstIndex(id: id)
            
            guard newValue != nil || index != nil else {
                _logger(scope: .trace) {
                    $0.trace("Factory '\(id)' is not saved and new value is nil. Nothing to update")
                }
                return
            }
            
            if let index {
                let savedFactory = factories[index]
                _logger(scope: .trace) {
                    $0.trace("Found factory '\(id)' - '\(savedFactory.name)'")
                }
                
                if let newValue {
                    _logger(scope: .trace) {
                        $0.trace("Replacing factory '\(id)' - '\(savedFactory.name)'")
                    }
                    
                    factories[index] = newValue
                } else {
                    _logger(scope: .trace) {
                        $0.trace("New value is nil, removing saved factory '\(id)' - '\(savedFactory.name)'")
                    }
                    
                    factories.remove(at: index)
                }
            } else {
                _logger(scope: .trace) {
                    $0.trace("Factory '\(id)' is not saved")
                }
                
                if let newValue {
                    _logger(scope: .trace) {
                        $0.trace("Saving factory '\(id)' - '\(newValue.name)'")
                    }
                    
                    factories.append(newValue)
                }
            }
            
            _logger(scope: .trace) {
                $0.trace("Factory '\(id)' updated")
            }
        }
    }
    
    subscript(productionID id: UUID) -> Production? {
        _logger(scope: .trace) {
            $0.trace("Fetching production '\(id)'")
        }
        
        let (factory, production): (Factory?, Production?) = (nil, nil)
        
        if let factory, let production {
            _logger(scope: .trace) {
                $0.trace("Found production '\(production.id)' - '\(production.name)' in factory '\(factory.id)' - '\(factory.name)'")
            }
        } else {
            _logger(scope: .trace) {
                $0.trace("Production '\(id)' is not found in any factory")
            }
        }
        
        return production
    }
    
    subscript(factoryID factoryID: UUID, productionID productionID: UUID) -> Production? {
        get {
            _logger(scope: .trace) {
                $0.trace("Fetching production '\(productionID)' from factory '\(factoryID)'")
            }
            
            guard let factory = self[factoryID: factoryID] else { return nil }
            let production = factory.productions.first(id: productionID)
            
            if let production {
                _logger(scope: .trace) {
                    $0.trace("Found production '\(production.id)' - '\(production.name)' in factory '\(factory.id)' - '\(factory.name)'")
                }
            } else {
                _logger(scope: .trace) {
                    $0.trace("Production '\(productionID)' is not found in factory '\(factory.id)' - '\(factory.name)'")
                }
            }
            
            return production
        }
        
        set {
            _logger(scope: .trace) {
                $0.trace("Updating production '\(productionID)' in factory '\(factoryID)'")
            }
            
            guard let factoryIndex = factories.firstIndex(id: factoryID) else { return }
            let factory = factories[factoryIndex]
            
            let productionIndex = factory.productions.firstIndex(id: productionID)
            
            guard newValue != nil || productionIndex != nil else {
                _logger(scope: .trace) {
                    $0.trace(
                        """
                        Production '\(productionID)' is not saved inside factory '\(factory.id)' - '\(factory.name)' \
                        and new value is nil. Nothing to update
                        """
                    )
                }
                return
            }
            
            if let productionIndex {
                let savedProduction = factory.productions[productionIndex]
                _logger(scope: .trace) {
                    $0.trace(
                        """
                        Found production '\(savedProduction.id)' - '\(savedProduction.name)' \
                        inside factory '\(factory.id)' - '\(factory.name)'
                        """
                    )
                }
                
                if let newValue {
                    _logger(scope: .trace) {
                        $0.trace(
                            """
                            Replacing production '\(savedProduction.id)' - '\(savedProduction.name)' \
                            inside factory '\(factory.id)' - '\(factory.name)'
                            """
                        )
                    }
                    
                    factories[factoryIndex].productions[productionIndex] = newValue
                } else {
                    _logger(scope: .trace) {
                        $0.trace(
                            """
                            New value is nil, removing saved production '\(savedProduction.id)' - '\(savedProduction.name)' \
                            from factory '\(factory.id)' - '\(factory.name)'
                            """
                        )
                    }
                    
                    factories[factoryIndex].productions.remove(at: productionIndex)
                }
            } else {
                _logger(scope: .trace) {
                    $0.trace("Production '\(productionID)' is not saved inside factory '\(factory.id)' - '\(factory.name)'")
                }
                
                if let newValue {
                    _logger(scope: .trace) {
                        $0.trace(
                            """
                            Saving production '\(productionID)' \
                            inside factory '\(factory.id)' - '\(factory.name)'
                            """
                        )
                    }
                    
                    factories[factoryIndex].productions.append(newValue)
                }
            }
            
            _logger(scope: .trace) {
                $0.trace("Production '\(productionID)' in factory '\(factoryID)' updated")
            }
        }
    }
    
    subscript(isPartPinned partID: String) -> Bool {
        get {
            _logger(scope: .trace) {
                $0.trace("Fetching pin status for part '\(partID)'")
            }
            
            let isPinned = pins.partIDs.contains(partID)
            
            _logger(scope: .trace) {
                $0.trace("Part '\(partID)' \(isPinned ? "is" : "is not") pinned")
            }
            
            return isPinned
        }
        
        set {
            let wasPinned = self.pins.partIDs.contains(partID)
            _logger(scope: .trace) {
                $0.trace(
                    """
                    Changing pin status for part '\(partID)': \
                    '\(wasPinned ? "Pinned" : "Unpinned")' → \
                    '\(newValue ? "Pinned" : "Unpinned")'
                    """
                )
            }
            
            if newValue {
                pins.partIDs.insert(partID)
                _logger(scope: .trace) {
                    $0.trace("Part '\(partID)' is pinned")
                }
            } else {
                pins.partIDs.remove(partID)
                _logger(scope: .trace) {
                    $0.trace("Part '\(partID)' is not pinned")
                }
            }
        }
    }
    
    subscript(isEquipmentPinned equipmentID: String) -> Bool {
        get {
            _logger(scope: .trace) {
                $0.trace("Fetching pin status for equipment '\(equipmentID)'")
            }
            
            let isPinned = pins.equipmentIDs.contains(equipmentID)
            
            _logger(scope: .trace) {
                $0.trace("Equipment '\(equipmentID)' \(isPinned ? "is" : "is not") pinned")
            }
            
            return isPinned
        }
        
        set {
            let wasPinned = self.pins.equipmentIDs.contains(equipmentID)
            _logger(scope: .trace) {
                $0.trace(
                    """
                    Changing pin status for equipment '\(equipmentID)': \
                    '\(wasPinned ? "Pinned" : "Unpinned")' → \
                    '\(newValue ? "Pinned" : "Unpinned")'
                    """
                )
            }
            
            if newValue {
                pins.equipmentIDs.insert(equipmentID)
                _logger(scope: .trace) {
                    $0.trace("Equipment '\(equipmentID)' is pinned")
                }
            } else {
                pins.equipmentIDs.remove(equipmentID)
                _logger(scope: .trace) {
                    $0.trace("Equipment '\(equipmentID)' is not pinned")
                }
            }
        }
    }
    
    subscript(isRecipePinned recipeID: String) -> Bool {
        get {
            _logger(scope: .trace) {
                $0.trace("Fetching pin status for recipe '\(recipeID)'")
            }
            
            let isPinned = pins.recipeIDs.contains(recipeID)
            
            _logger(scope: .trace) {
                $0.trace("Recipe '\(recipeID)' \(isPinned ? "is" : "is not") pinned")
            }
            
            return isPinned
        }
        
        set {
            let wasPinned = self.pins.recipeIDs.contains(recipeID)
            _logger(scope: .trace) {
                $0.trace(
                    """
                    Changing pin status for recipe '\(recipeID)': \
                    '\(wasPinned ? "Pinned" : "Unpinned")' → \
                    '\(newValue ? "Pinned" : "Unpinned")'
                    """
                )
            }
            
            if newValue {
                pins.recipeIDs.insert(recipeID)
                _logger(scope: .trace) {
                    $0.trace("Recipe '\(recipeID)' is pinned")
                }
            } else {
                pins.recipeIDs.remove(recipeID)
                _logger(scope: .trace) {
                    $0.trace("Recipe '\(recipeID)' is not pinned")
                }
            }
        }
    }
    
    subscript(isPinned id: String) -> Bool {
        _logger(scope: .trace) {
            $0.trace("Fetching pin status for item '\(id)'")
        }
        
        let isPinned = self[isPartPinned: id] ||
        self[isEquipmentPinned: id] ||
        self[isRecipePinned: id]
        
        _logger(scope: .trace) {
            $0.trace("Item '\(id)' \(isPinned ? "is" : "is not") pinned")
        }
        
        return isPinned
    }
}

// MARK: - Errors

private extension Storage.Persistent {
    enum Error: Swift.Error {
        case productionNotFound(UUID, factoryID: UUID)
        
        var debugDescription: String {
            switch self {
            case let .productionNotFound(id, factoryID): "Factory '\(factoryID)' contains a production '\(id)' which cannot be found"
            }
        }
    }
}
