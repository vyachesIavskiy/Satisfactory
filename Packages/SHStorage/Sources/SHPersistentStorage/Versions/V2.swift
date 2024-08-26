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
    var productions = CurrentValueSubject<[Production.Persistent.V2], Never>([])
    var factories = CurrentValueSubject<[Factory.Persistent.V2], Never>([])
    
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
        productions.value = try persistence.loadMany(Production.Persistent.V2.self, fromDirectory: .productions)
        factories.value = try persistence.loadMany(Factory.Persistent.V2.self, fromDirectory: .factories)
        
        logger.info("V2: loaded.")
    }
    
    func save() throws {
        logger.info("V2: Saving.")
        
        try persistence.save(configuration, toFile: .configuration)
        try persistence.save(pins.value, toFile: .pins)
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
        
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
        
        try persistence.save(pins.value, toFile: .pins)
        logger.info("V2: Pins saved.")
    }
    
    func saveInitial() throws {
        logger.info("V2: Saving initial data.")
        
        configuration = Configuration.Persistent.V2(version: 1)
        
        try persistence.save(configuration, toFile: .configuration)
        try persistence.save(pins.value, toFile: .pins)
        
        logger.info("V2: Initial data saved.")
    }
    
    func saveFactory(_ factory: Factory.Persistent.V2) throws {
        if let index = factories.value.firstIndex(where: { $0.id == factory.id }) {
            factories.value[index] = factory
        } else {
            factories.value.append(factory)
        }
        
        try persistence.save(factories.value, toDirectory: .factories)
    }
    
    func saveProduction(_ production: Production.Persistent.V2, to factoryID: UUID) throws {
        if let index = productions.value.firstIndex(where: { $0.id == production.id }) {
            productions.value[index] = production
        } else {
            productions.value.append(production)
        }
        
        if
            let index = factories.value.firstIndex(where: { $0.id == factoryID }),
            !factories.value[index].productionIDs.contains(factoryID)
        {
            factories.value[index].productionIDs.append(production.id)
        } else if
            let index = factories.value.firstIndex(where: { $0.productionIDs.contains(production.id) })
        {
            factories.value[index].productionIDs.removeAll { $0 == production.id }
        }
        
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
    }
    
    func deleteFactory(_ factory: Factory.Persistent.V2) throws {
        guard let factoryIndex = factories.value.firstIndex(where: { $0.id == factory.id })
        else { return }
        
        let factory = factories.value[factoryIndex]
        factories.value.remove(at: factoryIndex)
        try persistence.delete(factory, fromDirectory: .factories)
        
        for productionID in factory.productionIDs {
            try deleteProduction(id: productionID)
        }
    }
    
    func deleteProduction(_ production: Production.Persistent.V2) throws {
        try deleteProduction(id: production.id)
    }
    
    func deleteProduction(id: UUID) throws {
        guard let productionIndex = productions.value.firstIndex(where: { $0.id == id })
        else { return }
        
        let production = productions.value[productionIndex]
        productions.value.remove(at: productionIndex)
        try persistence.delete(production, fromDirectory: .productions)
        
        guard let factoryIndex = factories.value.firstIndex(where: { $0.productionIDs.contains(production.id) })
        else { return }
        
        factories.value[factoryIndex].productionIDs.removeAll(where: { $0 == production.id })
        try persistence.save(factories.value, toDirectory: .factories)
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
        productions.value = legacyProductions.compactMap {
            guard let root = $0.root else { return nil }
            
            return .singleItem(
                SingleItemProduction.Persistent.V2(
                    id: $0.productionTreeRootID,
                    name: $0.name,
                    itemID: root.itemID,
                    amount: $0.amount,
                    inputItems: $0.productionChain.map {
                        SingleItemProduction.Persistent.V2.InputItem(
                            id: $0.id,
                            itemID: $0.itemID,
                            recipes: [
                                SingleItemProduction.Persistent.V2.InputItem.Recipe(
                                    id: $0.id,
                                    recipeID: $0.recipeID,
                                    proportion: .auto
                                )
                            ]
                        )
                    },
                    byproducts: []
                )
            )
        }
        
        if !productions.value.isEmpty {
            factories.value = [Factory.Persistent.V2(
                id: UUID(),
                name: "Legacy",
                asset: .legacy,
                productionIDs: productions.value.map(\.id)
            )]
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
        migratePinIDs(migration: migration)
        migrateProductionItemIDs(migration: migration)
        logger.info("V2: Content migrated.")
    }
    
    func migrateConfiguration(migration: Migration) {
        configuration.version = migration.version
    }
    
    func migratePinIDs(migration: Migration) {
        var migratedPins = pins.value
        
        for partID in migratedPins.partIDs {
            guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID) else { continue }
            
            let newPartID = migration.partIDs[migrationIndex].newID
            migratedPins.partIDs.replace(partID, to: newPartID)
            logger.debug("V2: '\(partID)' changed to '\(newPartID)'")
        }
        
        for equipmentID in migratedPins.equipmentIDs {
            guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
            
            let newEquipmentID = migration.equipmentIDs[migrationIndex].newID
            migratedPins.equipmentIDs.replace(equipmentID, to: newEquipmentID)
            logger.debug("V2: '\(equipmentID)' changed to '\(newEquipmentID)'")
        }
        
        for recipeID in migratedPins.recipeIDs {
            guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
            
            let newRecipeID = migration.recipeIDs[migrationIndex].newID
            migratedPins.recipeIDs.replace(recipeID, to: newRecipeID)
            logger.debug("V2: '\(recipeID)' changed to '\(newRecipeID)'")
        }
        
        if migratedPins != pins.value {
            pins.value = migratedPins
        }
    }
    
    func migrateProductionItemIDs(migration: Migration) {
        var migratedProductions = productions.value
        
        for productionIndex in migratedProductions.indices {
            migratedProductions[productionIndex].migrate(migration: migration)
        }
        
        if migratedProductions != productions.value {
            productions.value = migratedProductions
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
