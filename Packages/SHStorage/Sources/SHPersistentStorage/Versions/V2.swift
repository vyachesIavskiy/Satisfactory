import Foundation
import Combine
import SHPersistence
import SHModels
import SHPersistentModels
import SHStaticModels
import SHLogger

final class V2: VersionedStorage {
    let version = Version.v2
    
    var configuration = Configuration.Persistent.V2()
    var pins = CurrentValueSubject<Pins.Persistent.V2, Never>(Pins.Persistent.V2())
    var productions = [Production.Persistent.V2]()
    var factories = [Factory.Persistent.V2]()
    
    private let persistence = SHPersistence(homeDirectoryName: "Storage/V2")
    private let logger = SHLogger(subsystemName: "SHStorage", category: "Persistent.V2")
    
    func canBeLoaded() -> Bool {
        let result = persistence.canBeLoaded()
        logger.info("V2: \(result ? "Can" : "Cannot") be loaded.")
        return result
    }
    
    func load() throws {
        logger.info("V2: Loading.")
        
        configuration = try persistence.loadOne(Configuration.Persistent.V2.self, fromFile: .configuration)
        pins.value = try persistence.loadOne(Pins.Persistent.V2.self, fromFile: .pins)
        productions = try persistence.loadMany(Production.Persistent.V2.self, fromDirectory: .productions)
        factories = try persistence.loadMany(Factory.Persistent.V2.self, fromDirectory: .factories)
        
        logger.info("V2: loaded.")
    }
    
    func save() throws {
        logger.info("V2: Saving.")
        
        try persistence.createHomeDirectoryIfNeeded()
        
        try persistence.save(model: configuration, to: .configuration)
        try persistence.save(model: pins.value, to: .pins)
        try persistence.save(models: productions, to: .productions)
        try persistence.save(models: factories, to: .factories)
        
        logger.info("V2: Saved.")
    }
    
    func isPartPinned(_ partID: String) -> Bool {
        pins.value.partIDs.contains(partID)
    }
    
    func isEquipmentPinned(_ equipmentID: String) -> Bool {
        pins.value.equipmentIDs.contains(equipmentID)
    }
    
    func isRecipePinned(_ recipeID: String) -> Bool {
        pins.value.recipeIDs.contains(recipeID)
    }
    
    func changePartPinStatus(_ partID: String) throws {
        if isPartPinned(partID) {
            logger.debug("V2: Unpinning '\(partID)'.")
            pins.value.partIDs.remove(partID)
        } else {
            logger.debug("V2: Pinning '\(partID)'.")
            pins.value.partIDs.insert(partID)
        }
        
        try savePins()
    }
    
    func changeEquipmentPinStatus(_ equipmentID: String) throws {
        if isEquipmentPinned(equipmentID) {
            logger.debug("V2: Unpinning '\(equipmentID)'.")
            pins.value.equipmentIDs.remove(equipmentID)
        } else {
            logger.debug("V2: Pinning '\(equipmentID)'.")
            pins.value.equipmentIDs.insert(equipmentID)
        }
        
        try savePins()
    }
    
    func changeRecipePinStatus(_ recipeID: String) throws {
        if isRecipePinned(recipeID) {
            logger.debug("V2: Unpinning '\(recipeID)'.")
            pins.value.recipeIDs.remove(recipeID)
        } else {
            logger.debug("V2: Pinning '\(recipeID)'.")
            pins.value.recipeIDs.insert(recipeID)
        }
        
        try savePins()
    }
    
    func savePins() throws {
        logger.info("V2: Saving pins.")
        try persistence.createHomeDirectoryIfNeeded()
        
        try persistence.save(model: pins.value, to: .pins)
        logger.info("V2: Pins saved.")
    }
    
    func saveInitial() throws {
        logger.info("V2: Saving initial data.")
        
        configuration = Configuration.Persistent.V2(version: 1)
        
        try persistence.createHomeDirectoryIfNeeded()
        
        try persistence.save(model: configuration, to: .configuration)
        try persistence.save(model: pins.value, to: .pins)
        
        logger.info("V2: Initial data saved.")
    }
    
    func remove() throws {
        logger.info("V2: Removing.")
        
        try persistence.remove()
        
        logger.info("V2: Removed")
    }
    
    func migrate(legacy: Legacy, migration: Migration?) throws {
        logger.info("V2: Migrating from Legacy.")
        
        logger.debug("V2: Migrating pins.")
        let favoriteParts = legacy.parts.filter(\.isFavorite)
        let favoriteEquipment = legacy.equipment.filter(\.isFavorite)
        let favoriteRecipes = legacy.recipes.filter(\.isFavorite)
        
        pins.value = Pins.Persistent.V2(
            partIDs: Set(favoriteParts.map(\.id)),
            equipmentIDs: Set(favoriteEquipment.map(\.id)),
            recipeIDs: Set(favoriteRecipes.map(\.id))
        )
        
        logger.debug("V2: Migrating productions.")
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
        
        if let migration {
            migrateContent(migration: migration)
        }
        
        try save()
        
        logger.info("V2: Migration completed.")
    }
}

// MARK: - Private
private extension V2 {
    func migrateContent(migration: Migration) {
        logger.info("V2: Migrating content.")
        migrateConfiguration(migration: migration)
        let newPins = migratePinIDs(migration: migration)
        let newProductions = migrateProductionItemIDs(migration: migration)
        
        if newPins != pins.value {
            pins.value = newPins
        }
        
        if newProductions != productions {
            productions = newProductions
        }
        logger.info("V2: Content migrated.")
    }
    
    func migrateConfiguration(migration: Migration) {
        configuration.version = migration.version
    }
    
    func migratePinIDs(migration: Migration) -> Pins.Persistent.V2 {
        var pins = pins.value
        
        for partID in pins.partIDs {
            guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID) else { continue }
            
            let newPartID = migration.partIDs[migrationIndex].newID
            pins.partIDs.replace(partID, to: newPartID)
            logger.debug("V2: '\(partID)' changed to '\(newPartID)'")
        }
        
        for equipmentID in pins.equipmentIDs {
            guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
            
            let newEquipmentID = migration.equipmentIDs[migrationIndex].newID
            pins.equipmentIDs.replace(equipmentID, to: newEquipmentID)
            logger.debug("V2: '\(equipmentID)' changed to '\(newEquipmentID)'")
        }
        
        for recipeID in pins.recipeIDs {
            guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
            
            let newRecipeID = migration.recipeIDs[migrationIndex].newID
            pins.recipeIDs.replace(recipeID, to: newRecipeID)
            logger.debug("V2: '\(recipeID)' changed to '\(newRecipeID)'")
        }
        
        return pins
    }
    
    func migrateProductionItemIDs(migration: Migration) -> [Production.Persistent.V2] {
        var productions = productions
        
        for (index, production) in productions.enumerated() {
            if let partID = migration.partIDs.first(oldID: production.itemID) {
                productions[index].itemID = partID.newID
            } else if let equipmentID = migration.equipmentIDs.first(oldID: production.itemID) {
                productions[index].itemID = equipmentID.newID
            }
        }
        
        return productions
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
