import Foundation
import Models
import PersistentModels
import struct StaticModels.Migration

enum StorageVersion: CaseIterable {
    case legacy
    case v2
    
    var latest: Self { Self.allCases.last! }
    
    var folderName: String {
        switch self {
        case .legacy: ""
        case .v2: "V2"
        }
    }
}

public final class Storage {
    var parts = [Part]()
    var equipment = [Equipment]()
    var buildings = [Building]()
    var recipes = [Recipe]()
    var factories = [Factory]()
    
    private var pins = PersistentPinsV2()
    private let persistentStorage = PersistentStorage()

    func load() throws {
        // Step 1: Load static data
        let staticStorage = try loadStatic()
        
        // Step 2: Load persistent data. During this step all storage migrations will be done if needed.
        let storageMigrated = try loadPersistent()
        
        // Step 3: Migrate content
        let contentMigrated = try migrateContent(migrations: staticStorage.migrations)
        
        // Step 4: Finally save everything if any migration was made
        if storageMigrated || contentMigrated {
            try persistentStorage.save()
        }
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
    
    func loadStatic() throws -> StaticStorage {
        // Step 1: Load StaticStorage
        let staticStorage = StaticStorage()
        try staticStorage.load()
        
        // Step 2: Convert parts. Parts are essential and do not depend on anything
        parts = try staticStorage.parts.map(Part.init)
        
        // Step 3: Convert buildings. Buildings do not depend on anything as well
        buildings = try staticStorage.buildings.map(Building.init)
        
        // Step 4: Convert equipment. Equipment depend on Part since their 'ammo', 'fuel' and 'consumes' fields are Parts.
        equipment = try staticStorage.equipment.map { equipment in
            try Equipment(equipment) { partID in
                guard let part = self[partID: partID] else {
                    throw Error.invalidPartID(partID)
                }
                
                return part
            }
        }
        
        // Step 5: Convert recipes. Recipes must be converted last since they can have anything as it's output.
        recipes = try staticStorage.recipes.map { recipe in
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
        
        return staticStorage
    }
    
    func loadPersistent() throws -> Bool {
        // Step 1: Load persistent storage
        let migrated = try persistentStorage.load()
        
        // Step 2: Save pins
        pins = persistentStorage.pins
        
        // Step 3: Convert factories and productions
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
        
        return migrated
    }
    
    func migrateContent(migrations: [Migration]) throws -> Bool {
        // Step 1: Read already saved content version
        let contentVersion = persistentStorage.configuration.version
        
        // Step 2: Filter out migrations that are already done
        let remainingMigrations = migrations
            .filter { $0.version > contentVersion }
            .sorted()
        
        // Step 3: Exit early if there are no new migrations to apply
        guard !remainingMigrations.isEmpty else {
            return false
        }
        
        // Step 4: Merge remaining migrations into one migration from current state to the newest.
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
        
        // Step 5: Update pins with merged migration values
        for (pinIndex, pinID) in pins.partIDs.enumerated() {
            guard let migrationIndex = mergedMigration.partIDs.firstIndex(oldID: pinID) else { continue }
            
            pins.partIDs[pinIndex] = mergedMigration.partIDs[migrationIndex].newID
        }
        
        for (pinIndex, pinID) in pins.equipmentIDs.enumerated() {
            guard let migrationIndex = mergedMigration.equipmentIDs.firstIndex(oldID: pinID) else { continue }
            
            pins.equipmentIDs[pinIndex] = mergedMigration.equipmentIDs[migrationIndex].newID
        }
        
        for (pinIndex, pinID) in pins.recipeIDs.enumerated() {
            guard let migrationIndex = mergedMigration.recipeIDs.firstIndex(oldID: pinID) else { continue }
            
            pins.recipeIDs[pinIndex] = mergedMigration.recipeIDs[migrationIndex].newID
        }
        
        return true
    }
}

// MARK: Subscripts
public extension Storage {
    subscript(partID id: String) -> Part? {
        parts.first(id: id)
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        equipment.first(id: id)
    }
    
    subscript(buildingID id: String) -> Building? {
        buildings.first(id: id)
    }
    
    subscript(itemID id: String) -> Item? {
        self[partID: id] ??
        self[equipmentID: id] ??
        self[buildingID: id]
    }
    
    subscript(recipeID id: String) -> Recipe? {
        recipes.first(id: id)
    }
}
