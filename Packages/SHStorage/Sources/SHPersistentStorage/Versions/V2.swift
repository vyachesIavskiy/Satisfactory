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
        configuration = try persistence.loadOne(Configuration.Persistent.V2.self, fromFile: .configuration)
        pins.value = try persistence.loadOne(Pins.Persistent.V2.self, fromFile: .pins)
        productions.value = try persistence.loadMany(Production.Persistent.V2.self, fromDirectory: .productions)
        factories.value = try persistence.loadMany(Factory.Persistent.V2.self, fromDirectory: .factories)
        
        logger.info("loaded.")
    }
    
    func save() throws {
        try persistence.save(configuration, toFile: .configuration)
        try persistence.save(pins.value, toFile: .pins)
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
        
        logger.info("Saved.")
    }
    
    func isPartPinned(_ partID: String, productionType: ProductionType) -> Bool {
        let pins = switch productionType {
        case .singleItem: pins.value.singleItemPartIDs
        case .fromResources: pins.value.fromResourcesPartIDs
        case .power: pins.value.powerPartIDs
        }
        
        return pins.contains(partID)
    }
    
    func isEquipmentPinned(_ equipmentID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem: return pins.value.singleItemEquipmentIDs.contains(equipmentID)
        case .fromResources: return pins.value.fromResourcesEquipmentIDs.contains(equipmentID)
        case .power:
            logger.error("Checking for pined equipment in Power production mode.")
            return false
            
        }
    }
    
    func isBuildingPinned(_ buildingID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem:
            logger.error("Checking for pined building in Single Item production mode.")
            return false
        
        case .fromResources:
            logger.error("Checking for pined building in From Resources production mode.")
            return false
        
        case .power:
            return pins.value.powerBuildingIDs.contains(buildingID)
        }
    }
    
    func isRecipePinned(_ recipeID: String) -> Bool {
        pins.value.recipeIDs.contains(recipeID)
    }
    
    func changePartPinStatus(_ partID: String, productionType: ProductionType) throws {
        let pinned = isPartPinned(partID, productionType: productionType)
        switch productionType {
        case .singleItem:
            if pinned {
                pins.value.singleItemPartIDs.remove(partID)
                logger.info("Unpinned '\(partID)' for Single Item production mode.")
            } else {
                pins.value.singleItemPartIDs.insert(partID)
                logger.info("Pinned '\(partID)' for Single Item production mode.")
            }
            
        case .fromResources:
            if pinned {
                pins.value.fromResourcesPartIDs.remove(partID)
                logger.info("Unpinned '\(partID)' for From Resources production mode.")
            } else {
                pins.value.fromResourcesPartIDs.insert(partID)
                logger.info("Pinned '\(partID)' for From Resources production mode.")
            }
            
        case .power:
            if pinned {
                pins.value.powerPartIDs.remove(partID)
                logger.info("Unpinned '\(partID)' for Power production mode.")
            } else {
                pins.value.powerPartIDs.insert(partID)
                logger.info("Pinned '\(partID)' for Power production mode.")
            }
        }
        
        try savePins()
    }
    
    func changeEquipmentPinStatus(_ equipmentID: String, productionType: ProductionType) throws {
        let pinned = isEquipmentPinned(equipmentID, productionType: productionType)
        switch productionType {
        case .singleItem:
            if pinned {
                pins.value.singleItemEquipmentIDs.remove(equipmentID)
                logger.info("Unpinned '\(equipmentID)' for Single Item production mode.")
            } else {
                pins.value.singleItemEquipmentIDs.insert(equipmentID)
                logger.info("Pinned '\(equipmentID)' for Single Item production mode.")
            }
            
        case .fromResources:
            if pinned {
                pins.value.fromResourcesEquipmentIDs.remove(equipmentID)
                logger.info("Unpinned '\(equipmentID)' for From Resources production mode.")
            } else {
                pins.value.fromResourcesEquipmentIDs.insert(equipmentID)
                logger.info("Pinned '\(equipmentID)' for From Resources production mode.")
            }
            
        case .power:
            logger.error("Tried to pin/unpin equipment in Power production mode.")
        }
        
        try savePins()
    }
    
    func changeBuildingPinStatus(_ buildingID: String, productionType: ProductionType) throws {
        let pinned = isBuildingPinned(buildingID, productionType: productionType)
        switch productionType {
        case .singleItem:
            logger.error("Tried to pin/unpin building in Single Item production mode.")
            
        case .fromResources:
            logger.error("Tried to pin/unpin building in From Resources production mode.")
            
        case .power:
            if pinned {
                pins.value.powerBuildingIDs.remove(buildingID)
                logger.info("Unpinned '\(buildingID)' for Power production mode.")
            } else {
                pins.value.powerBuildingIDs.insert(buildingID)
                logger.info("Pinned '\(buildingID)' for Power production mode.")
            }
        }
        
        try savePins()
    }
    
    func changeRecipePinStatus(_ recipeID: String) throws {
        if isRecipePinned(recipeID) {
            pins.value.recipeIDs.remove(recipeID)
            logger.info("Unpinned '\(recipeID)'.")
        } else {
            pins.value.recipeIDs.insert(recipeID)
            logger.info("Pinned '\(recipeID)'.")
        }
        
        try savePins()
    }
    
    func savePins() throws {
        try persistence.createHomeDirectoryIfNeeded()
        
        try persistence.save(pins.value, toFile: .pins)
        logger.info("V2: Pins saved.")
    }
    
    func saveInitial() throws {
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
        
        if let indexToAdd = factories.value.firstIndex(where: { $0.id == factoryID }) {
            if
                let indexToRemove = factories.value.firstIndex(where: { $0.productionIDs.contains(production.id) }),
                indexToAdd != indexToRemove
            {
                factories.value[indexToRemove].productionIDs.removeAll { $0 == production.id }
            }
            
            if !factories.value[indexToAdd].productionIDs.contains(production.id) {
                factories.value[indexToAdd].productionIDs.append(production.id)
            }
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
            singleItemPartIDs: Set(favoriteParts.map(\.id)),
            singleItemEquipmentIDs: Set(favoriteEquipment.map(\.id)),
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
        
        for partID in migratedPins.singleItemPartIDs {
            guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID) else { continue }
            
            let newPartID = migration.partIDs[migrationIndex].newID
            migratedPins.singleItemPartIDs.replace(partID, to: newPartID)
            logger.debug("V2: '\(partID)' changed to '\(newPartID)'")
        }
        
        for equipmentID in migratedPins.singleItemEquipmentIDs {
            guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
            
            let newEquipmentID = migration.equipmentIDs[migrationIndex].newID
            migratedPins.singleItemEquipmentIDs.replace(equipmentID, to: newEquipmentID)
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
