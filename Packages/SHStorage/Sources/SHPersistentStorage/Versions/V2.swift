import Foundation
import Combine
import SHDependencies
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
    var orders = CurrentValueSubject<OrdersV2, Never>(OrdersV2())
    
    var sortedFactories: [Factory.Persistent.V2] {
        orders.value.factoryOrder.compactMap { factoryID in
            factories.value.first { $0.id == factoryID }
        }
    }
    
    var sortedFactoriesStream: AsyncStream<[Factory.Persistent.V2]> {
        combineLatest(orders.values, factories.values).map { orders, factories in
            return orders.factoryOrder.compactMap { factoryID in
                factories.first { $0.id == factoryID }
            }
        }
        .eraseToStream()
    }
    
    private let persistence = SHPersistence(homeDirectoryName: "Storage/V2")
    private let logger = SHLogger(subsystemName: "SHStorage", category: "Persistent.V2")
    
    func productions(inside factoryID: UUID) -> [Production.Persistent.V2] {
        guard let factory = factories.value.first(where: { $0.id == factoryID }) else {
            return []
        }
        
        let factoryProductions = productions.value.filter { factory.productionIDs.contains($0.id) }
        
        return orders.value.productionOrders
            .first(factoryID: factoryID)
            .map {
                $0.order.compactMap { productionID in
                    factoryProductions.first { $0.id == productionID }
                }
            } ?? []
    }
    
    func streamProductions(inside factoryID: UUID) -> AsyncStream<[Production.Persistent.V2]> {
        guard let factory = factories.value.first(where: { $0.id == factoryID }) else {
            return .finished
        }
        
        return combineLatest(orders.values, productions.values).map { orders, productions in
            let factoryProductions = productions.filter { factory.productionIDs.contains($0.id) }
            
            return orders.productionOrders
                .first(factoryID: factoryID)
                .map {
                    $0.order.compactMap { productionID in
                        factoryProductions.first { $0.id == productionID }
                    }
                } ?? []
        }
        .eraseToStream()
    }
    
    func canBeLoaded() -> Bool {
        let result = persistence.canBeLoaded()
        logger.info("[SHPersistentStorage.V2] \(result ? "Can" : "Cannot") be loaded.")
        return result
    }
    
    func load() throws {
        configuration = try persistence.loadOne(Configuration.Persistent.V2.self, fromFile: .configuration)
        pins.value = try persistence.loadOne(Pins.Persistent.V2.self, fromFile: .pins)
        factories.value = try persistence.loadMany(Factory.Persistent.V2.self, fromDirectory: .factories)
        productions.value = try persistence.loadMany(Production.Persistent.V2.self, fromDirectory: .productions)
        orders.value = try persistence.loadOne(OrdersV2.self, fromFile: .orders)
        
        logger.info("[SHPersistentStorage.V2] Loaded.")
    }
    
    func save() throws {
        try persistence.save(configuration, toFile: .configuration)
        try persistence.save(pins.value, toFile: .pins)
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
        try persistence.save(orders.value, toFile: .orders)
        
        logger.info("[SHPersistentStorage.V2] Saved.")
    }
    
    func isPartPinned(_ partID: String, productionType: ProductionType) -> Bool {
        let pins = switch productionType {
        case .singleItem: pins.value.singleItemPartIDs
        case .fromResources: pins.value.fromResourcesPartIDs
        case .power: pins.value.powerPartIDs
        }
        
        return pins.contains(partID)
    }
    
    func isBuildingPinned(_ buildingID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem:
            logger.error("[SHPersistentStorage.V2] Checking for pined building in Single Item production mode.")
            return false
        
        case .fromResources:
            logger.error("[SHPersistentStorage.V2] Checking for pined building in From Resources production mode.")
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
                logger.info("[SHPersistentStorage.V2] Single Item production, unpinned, partID=\(partID).")
            } else {
                pins.value.singleItemPartIDs.insert(partID)
                logger.info("[SHPersistentStorage.V2] Single Item production, pinned, partID=\(partID).")
            }
            
        case .fromResources:
            if pinned {
                pins.value.fromResourcesPartIDs.remove(partID)
                logger.info("[SHPersistentStorage.V2] From Resources production, unpinned partID=\(partID).")
            } else {
                pins.value.fromResourcesPartIDs.insert(partID)
                logger.info("[SHPersistentStorage.V2] From Resources production, pinned partID=\(partID).")
            }
            
        case .power:
            if pinned {
                pins.value.powerPartIDs.remove(partID)
                logger.info("[SHPersistentStorage.V2] Power production, unpinned partID=\(partID).")
            } else {
                pins.value.powerPartIDs.insert(partID)
                logger.info("[SHPersistentStorage.V2] Power production, pinned partID=\(partID).")
            }
        }
        
        try savePins()
    }
    
    func changeBuildingPinStatus(_ buildingID: String, productionType: ProductionType) throws {
        let pinned = isBuildingPinned(buildingID, productionType: productionType)
        switch productionType {
        case .singleItem:
            logger.error("[SHPersistentStorage.V2] Tried to pin/unpin building in Single Item production mode.")
            
        case .fromResources:
            logger.error("[SHPersistentStorage.V2] Tried to pin/unpin building in From Resources production mode.")
            
        case .power:
            if pinned {
                pins.value.powerBuildingIDs.remove(buildingID)
                logger.info("[SHPersistentStorage.V2] Power production unpinned buildingID=\(buildingID).")
            } else {
                pins.value.powerBuildingIDs.insert(buildingID)
                logger.info("[SHPersistentStorage.V2] Power production pinned buildingID=\(buildingID).")
            }
        }
        
        try savePins()
    }
    
    func changeRecipePinStatus(_ recipeID: String) throws {
        if isRecipePinned(recipeID) {
            pins.value.recipeIDs.remove(recipeID)
            logger.info("[SHPersistentStorage.V2] Unpinned, recipeID=\(recipeID).")
        } else {
            pins.value.recipeIDs.insert(recipeID)
            logger.info("[SHPersistentStorage.V2] Pinned, recipeID=\(recipeID).")
        }
        
        try savePins()
    }
    
    func savePins() throws {
        try persistence.createHomeDirectoryIfNeeded()
        
        try persistence.save(pins.value, toFile: .pins)
        logger.info("[SHPersistentStorage.V2] Pins saved.")
    }
    
    func saveInitial() throws {
        logger.info("[SHPersistentStorage.V2] Saving initial data.")
        
        configuration = Configuration.Persistent.V2(version: 1)
        
        try persistence.save(configuration, toFile: .configuration)
        try persistence.save(pins.value, toFile: .pins)
        try persistence.save(orders.value, toFile: .orders)
        
        logger.info("[SHPersistentStorage.V2] Saved initial data.")
    }
    
    func saveFactory(_ factory: Factory.Persistent.V2) throws {
        logger.info("[SHPersistentStorage.V2] Saving factory, id=\(factory.id), name=\(factory.name).")
        
        if let index = factories.value.firstIndex(where: { $0.id == factory.id }) {
            factories.value[index] = factory
        } else {
            factories.value.insert(factory, at: 0)
        }
        
        orders.value.factoryOrder = factories.value.map(\.id)
        
        try persistence.save(factories.value, toDirectory: .factories)
        try persistence.save(orders.value, toFile: .orders)
        
        logger.info("[SHPersistentStorage.V2] Saved factory, id=\(factory.id), name=\(factory.name).")
    }
    
    func saveProduction(_ production: Production.Persistent.V2, to factoryID: UUID) throws {
        logger.info("[SHPersistentStorage.V2] Saving production, id=\(production.id), name=\(production.name), factoryID=\(factoryID).")
        
        if let index = productions.value.firstIndex(where: { $0.id == production.id }) {
            productions.value[index] = production
        } else {
            productions.value.insert(production, at: 0)
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
        
        let factoryProductionIDs = factories.value
            .first { $0.id == factoryID }
            .map { factory in
                productions.value.filter { factory.productionIDs.contains($0.id) }.map(\.id)
            } ?? []
        
        if let index = orders.value.productionOrders.firstIndex(factoryID: factoryID) {
            orders.value.productionOrders[index].order = factoryProductionIDs
        } else {
            orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
        }
        
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
        try persistence.save(orders.value, toFile: .orders)
        
        logger.info("[SHPersistentStorage.V2] Saved production, id=\(production.id), name=\(production.name), factoryID=\(factoryID).")
    }
    
    func saveProductionInformation(_ production: Production.Persistent.V2, to factoryID: UUID) throws {
        enum Error: LocalizedError {
            case productionNotFound(Production.ID)
            
            var errorDescription: String? {
                switch self {
                case let .productionNotFound(id): "Production not found: productionID=\(id)"
                }
            }
        }
        
        guard let index = productions.value.firstIndex(where: { $0.id == production.id }) else {
            throw Error.productionNotFound(production.id)
        }
        
        productions.value[index].name = production.name
        productions.value[index].assetName = production.assetName
        
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
        
        let factoryProductionIDs = factories.value
            .first { $0.id == factoryID }
            .map { factory in
                productions.value.filter { factory.productionIDs.contains($0.id) }.map(\.id)
            } ?? []
        
        if let index = orders.value.productionOrders.firstIndex(factoryID: factoryID) {
            orders.value.productionOrders[index].order = factoryProductionIDs
        } else {
            orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
        }
        
        try persistence.save(productions.value, toDirectory: .productions)
        try persistence.save(factories.value, toDirectory: .factories)
        try persistence.save(orders.value, toFile: .orders)
    }
    
    func saveProductionContent(_ production: Production.Persistent.V2) throws {
        enum Error: LocalizedError {
            case productionNotFound(Production.ID)
            
            var errorDescription: String? {
                switch self {
                case let .productionNotFound(id): "Production not found: productionID=\(id)"
                }
            }
        }
        
        guard let index = productions.value.firstIndex(where: { $0.id == production.id }) else {
            throw Error.productionNotFound(production.id)
        }
        
        productions.value[index].content = production.content
        try persistence.save(productions.value, toDirectory: .productions)
    }
    
    func moveFactories(fromOffsets: IndexSet, toOffset: Int) throws {
        factories.value.move(fromOffsets: fromOffsets, toOffset: toOffset)
        orders.value.factoryOrder = factories.value.map(\.id)
        try persistence.save(orders.value, toFile: .orders)
    }
    
    func moveProductions(factoryID: UUID, fromOffsets: IndexSet, toOffset: Int) throws {
        guard let index = orders.value.productionOrders.firstIndex(factoryID: factoryID) else { return }
        
        orders.value.productionOrders[index].order.move(fromOffsets: fromOffsets, toOffset: toOffset)
        try persistence.save(orders.value, toFile: .orders)
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
        
        if let index = orders.value.productionOrders.firstIndex(factoryID: factory.id) {
            orders.value.productionOrders.remove(at: index)
        }
        
        orders.value.factoryOrder = factories.value.map(\.id)
        try persistence.save(orders.value, toFile: .orders)
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
        
        let factoryProductionIDs = productions.value.filter {
            factories.value[factoryIndex].productionIDs.contains($0.id)
        }.map(\.id)
        
        let factoryID = factories.value[factoryIndex].id
        if let index = orders.value.productionOrders.firstIndex(factoryID: factoryID) {
            orders.value.productionOrders[index].order = factoryProductionIDs
        } else {
            orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
        }
        try persistence.save(orders.value, toFile: .orders)
    }
    
    func remove() throws {
        logger.info("[SHPersistentStorage.V2] Removing.")
        
        try persistence.remove()
        
        logger.info("[SHPersistentStorage.V2] Removed.")
    }
    
    func migrate(legacy: Legacy, migration: Migration?) throws {
        @Dependency(\.date)
        var date
        
        logger.info("[SHPersistentStorage.V2] Migrating from Legacy.")
        
        logger.info("[SHPersistentStorage.V2]   Migrating pins.")
        let favoriteParts = legacy.parts.filter(\.isFavorite)
        let favoriteRecipes = legacy.recipes.filter(\.isFavorite)
        
        pins.value = Pins.Persistent.V2(
            singleItemPartIDs: Set(favoriteParts.map(\.id)),
            recipeIDs: Set(favoriteRecipes.map(\.id))
        )
        
        logger.info("[SHPersistentStorage.V2]   Migrating productions.")
        let legacyProductions = legacy.productions
        productions.value = legacyProductions.compactMap {
            guard let root = $0.root else { return nil }
            
            return Production.Persistent.V2(
                id: $0.productionTreeRootID,
                name: $0.name,
                creationDate: date(),
                assetName: $0.root?.partID ?? "",
                content: .singleItem(
                    Production.Content.SingleItem.Persistent.V2(
                        partID: root.partID,
                        amount: $0.amount,
                        inputParts: $0.productionChain.map {
                            Production.Content.SingleItem.Persistent.V2.InputPart(
                                id: $0.id,
                                partID: $0.partID,
                                recipes: [
                                    Production.Content.SingleItem.Persistent.V2.InputPart.Recipe(
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
            )
        }
        
        if !productions.value.isEmpty {
            factories.value = [Factory.Persistent.V2(
                id: UUID(),
                name: "Legacy",
                creationDate: date(),
                asset: .legacy,
                productionIDs: productions.value.map(\.id)
            )]
        }
        
        if let migration {
            migrateContent(migration: migration)
        }
        
        try save()
        
        logger.info("[SHPersistentStorage.V2] Migration completed.")
    }
}

// MARK: - Private
private extension V2 {
    func migrateContent(migration: Migration) {
        logger.info("[SHPersistentStorage.V2] Migrating content.")
        migrateConfiguration(migration: migration)
        migratePinIDs(migration: migration)
        migrateProductionItemIDs(migration: migration)
        logger.info("[SHPersistentStorage.V2] Content migrated.")
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
            logger.debug("[SHPersistentStorage.V2] '\(partID)' changed to '\(newPartID)'")
        }
        
        for recipeID in migratedPins.recipeIDs {
            guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
            
            let newRecipeID = migration.recipeIDs[migrationIndex].newID
            migratedPins.recipeIDs.replace(recipeID, to: newRecipeID)
            logger.debug("[SHPersistentStorage.V2] '\(recipeID)' changed to '\(newRecipeID)'")
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
    static let orders = "Orders"
}
