import Foundation
import Models
import PersistentModels
import StaticModels
import Dependencies
import SHLogger

extension Storage.Persistent {
    final class V2: VersionedPersistentStorage {
        let version = Storage.Persistent.Version.v2
        
        var configuration = Configuration.Persistent.V2()
        var pins = Pins.Persistent.V2()
        var productions = [Production.Persistent.V2]()
        var factories = [Factory.Persistent.V2]()
        var settings = Settings.Persistent.V2()
        
        private let persistence = Persistence(homeDirectoryName: "Storage/V2")
        private let logger = SHLogger(category: "Persistent.V2")
        
        func canBeLoaded() throws -> Bool {
            let result = try persistence.canBeLoaded()
            logger.info("V2 Persistent storage \(result ? "can" : "cannot") be loaded.")
            return result
        }
        
        func load() throws {
            logger.info("Loading V2 Persistent storage.")
            
            configuration = try persistence.loadOne(Configuration.Persistent.V2.self, fromFile: .configuration)
            pins = try persistence.loadOne(Pins.Persistent.V2.self, fromFile: .pins)
            productions = try persistence.loadMany(Production.Persistent.V2.self, fromDirectory: .productions)
            factories = try persistence.loadMany(Factory.Persistent.V2.self, fromDirectory: .factories)
            settings = try persistence.loadOne(Settings.Persistent.V2.self, fromFile: .settings)
            
            logger.info("V2 Persistent storage is loaded.")
        }
        
        func save() throws {
            logger.info("Saving V2 Persistent storage.")
            
            try persistence.createHomeDirectoryIfNeeded()
            
            try persistence.save(model: configuration, to: .configuration)
            try persistence.save(model: pins, to: .pins)
            try persistence.save(models: productions, to: .productions)
            try persistence.save(models: factories, to: .factories)
            try persistence.save(model: settings, to: .settings)
            
            logger.info("V2 Persistent storage is saved.")
        }
        
        func saveInitial() throws {
            logger.info("Saving initial V2 Persistent storage.")
            
            try persistence.createHomeDirectoryIfNeeded()
            
            try persistence.save(model: Configuration.Persistent.V2(version: 1), to: .configuration)
            try persistence.save(model: Settings.Persistent.V2(), to: .settings)
            
            logger.info("Initial V2 Persistent storage is saved.")
        }
        
        func remove() throws {
            logger.info("Removing V2 Persistent storage.")
            
            try persistence.remove()
            
            logger.info("V2 Persistent storage is removed")
        }
        
        func migrate(legacy: Storage.Persistent.Legacy, migration: Migration?) throws {
            logger.info("Migrating Legacy -> V2.")
            
            logger.info("Migrating Legacy pins -> V2 pins.")
            
            let favoriteParts = legacy.parts.filter(\.isFavorite)
            let favoriteEquipment = legacy.equipment.filter(\.isFavorite)
            let favoriteRecipes = legacy.recipes.filter(\.isFavorite)
            
            pins = Pins.Persistent.V2(
                partIDs: Set(favoriteParts.map(\.id)),
                equipmentIDs: Set(favoriteEquipment.map(\.id)),
                recipeIDs: Set(favoriteRecipes.map(\.id))
            )
            
            logger.info("Migrating Legacy productions -> V2 productions.")
            let legacyProductions = legacy.productions
            productions = legacyProductions.compactMap {
                guard let root = $0.root else { return nil }
                
                return Production.Persistent.V2(
                    id: $0.productionTreeRootID,
                    name: $0.name,
                    itemID: root.itemID,
                    amount: $0.amount
                )
            }
            
            logger.info("Migrating Legacy settings -> V2 settings.")
            settings = Settings.Persistent.V2(itemViewStyleID: legacy.settings.itemViewStyle.id)
            
            if let migration {
                logger.info("Migrating content.")
                migrateContent(migration: migration)
            }
            
            if !productions.isEmpty {
                logger.debug("Detected Legacy productions. Creating a Legacy factory.")
                @Dependency(\.uuid) var uuid
                factories = [
                    Factory.Persistent.V2(
                        id: uuid(),
                        name: "Legacy",
                        image: .legacy,
                        productionIDs: productions.map(\.id)
                    )
                ]
            }
            
            try save()
            
            logger.info("Legacy -> V2 migration completed.")
        }
    }
}

// MARK: - Private
private extension Storage.Persistent.V2 {
    func migrateContent(migration: Migration) {
        migrateConfiguration(migration: migration)
        migratePinIDs(migration: migration)
        migrateProductionItemIDs(migration: migration)
    }
    
    func migrateConfiguration(migration: Migration) {
        logger.info("Migrating content configuration.")
        
        configuration.version = migration.version
    }
    
    func migratePinIDs(migration: Migration) {
        logger.info("Migrating pin IDs.")
        
        for partID in pins.partIDs {
            guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID) else { continue }
            
            let newPartID = migration.partIDs[migrationIndex].newID
            pins.partIDs.replace(partID, to: newPartID)
            logger.debug("'\(partID)' changed to '\(newPartID)'")
        }
        
        for equipmentID in pins.equipmentIDs {
            guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
            
            let newEquipmentID = migration.equipmentIDs[migrationIndex].newID
            pins.equipmentIDs.replace(equipmentID, to: newEquipmentID)
            logger.debug("'\(equipmentID)' changed to '\(newEquipmentID)'")
        }
        
        for recipeID in pins.recipeIDs {
            guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
            
            let newRecipeID = migration.recipeIDs[migrationIndex].newID
            pins.recipeIDs.replace(recipeID, to: newRecipeID)
            logger.debug("'\(recipeID)' changed to '\(newRecipeID)'")
        }
    }
    
    func migrateProductionItemIDs(migration: Migration) {
        logger.info("Migrating production item IDs.")
        
        for (index, production) in productions.enumerated() {
            if let partID = migration.partIDs.first(oldID: production.itemID) {
                productions[index].itemID = partID.newID
            } else if let equipmentID = migration.equipmentIDs.first(oldID: production.itemID) {
                productions[index].itemID = equipmentID.newID
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

// MARK: - File/Directory names
private extension String {
    static let configuration = "Configuration"
    static let pins = "Pins"
    static let productions = "Productions"
    static let factories = "Factories"
    static let settings = "Settings"
}
