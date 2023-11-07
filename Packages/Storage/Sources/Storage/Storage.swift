import Foundation
import Models
import PersistentModels
import struct StaticModels.Migration
import Dependencies
import StorageLogger

public final class Storage {
    public var parts = [Part]()
    public var equipment = [Equipment]()
    public var buildings = [Building]()
    public var recipes = [Recipe]()
    public var factories = [Factory]()
    public private(set) var pins = PersistentPinsV2()
    
    private let logger = Logger(category: .storage)
    private let persistentStorage = PersistentStorage()

    public func load() throws {
        // Step 1: Load static data
        logger.log("Start loading storage")
        
        logger.debug("Step 1: Loading static storage")
        let staticStorageClient = try loadStatic()
        
        // Step 2: Load persistent data. During this step all storage migrations will be done if needed.
        logger.debug("Step 2: Loading persistent storage")
        try loadPersistent()
        
        // Step 3: Migrate content
        logger.debug("Step 3: Migrating storage content")
        try migrateContent(migrations: staticStorageClient.migrations())
        
        logger.log("Finished loading storage")
    }
    
    public func save() throws {
        logger.log("Start saving storage")
        try persistentStorage.save()
        logger.log("Finished saving storage")
    }
}

private extension Storage {
    enum Error: Swift.Error {
        case invalidPartID(String)
        case invalidEquipmentID(String)
        case invalidBuildingID(String)
        case invalidItemID(String)
        case invalidRecipeID(String)
        case productionNotFound(UUID, factoryID: UUID)
        
        var debugDescription: String {
            switch self {
            case let .invalidPartID(id): "Part with ID '\(id)' not found"
            case let .invalidEquipmentID(id): "Equipment with ID '\(id)' not found'"
            case let .invalidBuildingID(id): "Building with ID '\(id)' not found"
            case let .invalidItemID(id): "Item with ID '\(id)' not found"
            case let .invalidRecipeID(id): "Recipe with ID '\(id)' not found"
            case let .productionNotFound(id, factoryID): "Factory with ID '\(factoryID)' contains a production with ID '\(id)' which cannot be found"
            }
        }
    }
    
    func loadStatic() throws -> StaticStorageClient {
        logger.log("Start loading static storage")
        
        // Step 1: Load StaticStorage
        logger.debug("Step 1: Load static storage")
        @Dependency(\.staticStorageClient) var staticStorageClient
        try staticStorageClient.load()
        
        // Step 2: Convert parts. Parts are essential and do not depend on anything
        logger.debug("Step 2: Converting 'static parts' to 'parts'")
        parts = try staticStorageClient.parts().map(Part.init)
        
        // Step 3: Convert buildings. Buildings do not depend on anything as well
        logger.debug("Step 3: Converting 'static buildings' to 'buildings'")
        buildings = try staticStorageClient.buildings().map(Building.init)
        
        // Step 4: Convert equipment. Equipment depend on Part since their 'ammo', 'fuel' and 'consumes' fields are Parts.
        logger.debug("Step 4: Converting 'static equipment' to 'equipment'")
        equipment = try staticStorageClient.equipment().map { equipment in
            try Equipment(equipment) { partID in
                guard let part = self[partID: partID] else {
                    throw Error.invalidPartID(partID)
                }
                
                return part
            }
        }
        
        // Step 5: Convert recipes. Recipes must be converted last since they can have anything as it's output.
        logger.debug("Step 5: Converting 'static recipes' to 'recipes'")
        recipes = try staticStorageClient.recipes().map { recipe in
            try Recipe(recipe) { itemID in
                guard let item = self[itemID: itemID] else {
                    throw Error.invalidItemID(itemID)
                }
                
                return item
            } buildingProvider: { buildingID in
                guard let building = self[buildingID: buildingID] else {
                    throw Error.invalidBuildingID(buildingID)
                }
                
                return building
            }
        }
        
        logger.info("Finished loading static storage")
        return staticStorageClient
    }
    
    func loadPersistent() throws {
        logger.log("Start loading persistent storage")
        
        // Step 1: Load persistent storage
        logger.debug("Step 1: Load persistent storage")
        try persistentStorage.load()
        
        // Step 2: Save pins
        logger.debug("Step 2: Save 'persistent pins' into 'pins'")
        pins = persistentStorage.pins
        
        // Step 3: Convert factories and productions
        logger.debug("Step 3: Convert 'persistent factories' and 'persistent productions' into 'factories' and 'productions'")
        let persistentProductions = persistentStorage.productions
        let persistentFactories = persistentStorage.factories
        factories = try persistentFactories.map { factory in
            try Factory(
                id: factory.id,
                name: factory.name,
                productions: factory.productionIDs.compactMap { productionID in
                    guard let production = persistentProductions.first(where: { $0.id == productionID }) else {
                        throw Error.productionNotFound(productionID, factoryID: factory.id)
                    }
                    
                    guard let item = self[itemID: production.itemID] else {
                        throw Error.invalidItemID(production.itemID)
                    }
                    
                    return Production(
                        id: productionID,
                        name: production.name,
                        item: item,
                        amount: production.amount
                    )
                }
            )
        }
        
        logger.log("Finished loading persistent storage")
    }
    
    func migrateContent(migrations: [Migration]) throws {
        logger.log("Start content migration")
        
        // Step 1: Read already saved content version
        logger.debug("Step 1: Load currently stored content configuration version")
        let contentVersion = persistentStorage.configuration.version
        
        logger.debug("Content configuration version: \(contentVersion)")
        
        // Step 2: Filter out migrations that are already done
        logger.debug("Step 2: Filtering migrations that has lower content configuration version that already stored")
        let remainingMigrations = migrations
            .filter { $0.version > contentVersion }
            .sorted()
        
        guard !remainingMigrations.isEmpty else {
            // There is no new migration, exit
            logger.debug("No new content migrations found, abort content migration")
            return
        }
        
        // Step 3: Merge remaining migrations into one migration from current state to the newest.
        logger.debug("Step 3: Merging all new migrations into one migration")
        var mergedMigration = remainingMigrations[0]
        if remainingMigrations.count > 1 {
            for migration in remainingMigrations.dropLast() {
                for (mergedIndex, partID) in mergedMigration.partIDs.enumerated() {
                    guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID.newID) else { continue }
                    
                    mergedMigration.partIDs[mergedIndex].newID = migration.partIDs[migrationIndex].newID
                }
                
                for (mergedIndex, equipmentID) in mergedMigration.equipmentIDs.enumerated() {
                    guard let migrationIndex = migration.equipmentIDs.firstIndex(oldID: equipmentID.newID) else { continue }
                    
                    mergedMigration.equipmentIDs[mergedIndex].newID = migration.equipmentIDs[migrationIndex].newID
                }
                
                for (mergedIndex, recipeID) in mergedMigration.recipeIDs.enumerated() {
                    guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID.newID) else { continue }
                    
                    mergedMigration.recipeIDs[mergedIndex].newID = migration.recipeIDs[migrationIndex].newID
                }
            }
        }
        
        // Step 4: Update pins with merged migration values
        logger.debug("Step 4: Updating 'pins' with content migration values")
        for partID in pins.partIDs {
            guard let migrationIndex = mergedMigration.partIDs.firstIndex(oldID: partID) else { continue }
            
            pins.partIDs.replace(partID, to: mergedMigration.partIDs[migrationIndex].newID)
        }
        
        for equipmentID in pins.equipmentIDs {
            guard let migrationIndex = mergedMigration.equipmentIDs.firstIndex(oldID: equipmentID) else { continue }
            
            pins.equipmentIDs.replace(equipmentID, to: mergedMigration.equipmentIDs[migrationIndex].newID)
        }
        
        for recipeID in pins.recipeIDs {
            guard let migrationIndex = mergedMigration.recipeIDs.firstIndex(oldID: recipeID) else { continue }
            
            pins.recipeIDs.replace(recipeID, to: mergedMigration.recipeIDs[migrationIndex].newID)
        }
        
        // Step 5: Save storage
        logger.debug("Step 5: Saving storage")
        try save()
        
        logger.log("Finished content migration")
    }
}

// MARK: Subscripts
public extension Storage {
    subscript(partID id: String) -> Part? {
        logger.debug("Fetching part with id '\(id)'")
        
        return parts.first(id: id)
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        logger.debug("Fetching equipment with id '\(id)'")
        
        return equipment.first(id: id)
    }
    
    subscript(buildingID id: String) -> Building? {
        logger.debug("Fetching building with id '\(id)'")
        
        return buildings.first(id: id)
    }
    
    subscript(itemID id: String) -> Item? {
        logger.debug("Fetching item with id '\(id)'")
        
        return self[partID: id] ??
        self[equipmentID: id] ??
        self[buildingID: id]
    }
    
    subscript(recipeID id: String) -> Recipe? {
        logger.debug("Fetching recipe with id '\(id)'")
        
        return recipes.first(id: id)
    }
}

// MARK: Pins
public extension Storage {
    func isPinned(_ item: some BaseItem) -> Bool {
        logger.debug("Fetching pin sttatus for item with id '\(item.id)'")
        
        return pins.partIDs.contains(item.id) ||
        pins.equipmentIDs.contains(item.id) ||
        pins.recipeIDs.contains(item.id)
    }
    
    func `set`(_ part: Part, pinned: Bool) {
        logger.debug("Setting part with id: \(part.id) as '\(pinned ? "pinned" : "unpinned")'")
        
        if pinned {
            pins.partIDs.insert(part.id)
        } else {
            pins.partIDs.remove(part.id)
        }
    }
    
    func `set`(_ equipment: Equipment, pinned: Bool) {
        logger.debug("Setting equipment with id: \(equipment.id) as '\(pinned ? "pinned" : "unpinned")'")
        
        if pinned {
            pins.equipmentIDs.insert(equipment.id)
        } else {
            pins.equipmentIDs.remove(equipment.id)
        }
    }
    
    func `set`(_ recipe: Recipe, pinned: Bool) {
        logger.debug("Setting recipe with id: \(recipe.id) as '\(pinned ? "pinned" : "unpinned")'")
        
        if pinned {
            pins.recipeIDs.insert(recipe.id)
        } else {
            pins.recipeIDs.remove(recipe.id)
        }
    }
}

private extension Set {
    mutating func replace(_ oldMember: Element, to newMember: Element) {
        remove(oldMember)
        insert(newMember)
    }
}
