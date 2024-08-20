import Foundation
import Combine
import ConcurrencyExtras
import SHModels
import SHPersistentModels
import struct SHStaticModels.Migration
import SHStaticStorage
import SHLogger

public final class SHPersistentStorage {
    private let staticStorage: SHStaticStorage
    private let v2 = V2()
    private let logger = SHLogger(subsystemName: "SHStorage", category: "SHPersistentStorage")
    
    public var configuration: Configuration {
        get { Configuration(v2.configuration) }
        set { v2.configuration = Configuration.Persistent.V2(newValue) }
    }
    
    public var streamPins: AsyncStream<Pins> {
        v2.pins
            .map(Pins.init)
            .values
            .eraseToStream()
    }
    
    public var pins: Pins {
        Pins(v2.pins.value)
    }
    
    public var factories: [Factory] {
        v2.factories.value.map(Factory.init)
    }
    
    public var streamFactories: AsyncStream<[Factory]> {
        v2.factories
            .map { $0.map(Factory.init) }
            .values
            .eraseToStream()
    }
    
    public var productions: [Production] {
        v2.productions.value.map(map)
    }
    
    public var streamProductions: AsyncStream<[Production]> {
        v2.productions
            .map { [weak self] in
                guard let self else { return [] }
                
                return $0.map(map)
            }
            .values
            .eraseToStream()
    }
    
    public init(staticStorage: SHStaticStorage) {
        self.staticStorage = staticStorage
    }
    
    // MARK: Loading
    public func load(_ options: LoadOptions) throws {
        logger.info("Loading Persistent storage.")
        
        // Check if storage can be loaded
        let legacy = Legacy()
        let canLegacyBeLoaded = legacy.canBeLoaded() || !options.v1.isEmpty
        guard canLegacyBeLoaded || v2.canBeLoaded() else {
            logger.info("Persistent storage is not detected, saving initial data.")
            
            try v2.saveInitial()
            return
        }
        
        if !v2.canBeLoaded() || !options.v1.isEmpty {
            // Migrate
            let migration = createContentMigration()
            try migrateIfNeeded(legacy: legacy, options: options, migration: migration)
        } else {
            // Load v2 Storage
            try v2.load()
        }
        
        logger.info("Persistent Storage is loaded.")
    }
    
    // MARK: IsPinned
    public func isPartPinned(_ partID: String) -> Bool {
        v2.isPartPinned(partID)
    }
    
    public func isEquipmentPinned(_ equipmentID: String) -> Bool {
        v2.isEquipmentPinned(equipmentID)
    }
    
    public func isRecipePinned(_ recipeID: String) -> Bool {
        v2.isRecipePinned(recipeID)
    }
    
    // MARK: Change pin status
    public func changePartPinStatus(_ partID: String) throws {
        try v2.changePartPinStatus(partID)
    }
    
    public func changeEquipmentPinStatus(_ equipmentID: String) throws {
        try v2.changeEquipmentPinStatus(equipmentID)
    }
    
    public func changeRecipePinStatus(_ recipeID: String) throws {
        try v2.changeRecipePinStatus(recipeID)
    }
    
    public func saveFactory(_ factory: Factory) throws {
        try v2.saveFactory(Factory.Persistent.V2(factory))
    }
    
    public func saveProduction(_ production: Production, to factoryID: UUID) throws {
        try v2.saveProduction(Production.Persistent.V2(production), to: factoryID)
    }
    
    public func deleteFactory(_ factory: Factory) throws {
        try v2.deleteFactory(Factory.Persistent.V2(factory))
    }
    
    public func deleteProduction(_ production: Production) throws {
        try v2.deleteProduction(Production.Persistent.V2(production))
    }
}

// MARK: Migration
private extension SHPersistentStorage {
    func migrateIfNeeded(legacy: Legacy, options: LoadOptions, migration: Migration?) throws {
        logger.info("Migrating Persistent storage.")
        
        func migrateLegacy() throws {
            if !options.v1.isEmpty {
                logger.debug("Load options detected. Migrating from debug provided Legacy to V2.")
                legacy.load(from: options)
                try v2.migrate(legacy: legacy, migration: migration)
            } else if legacy.canBeLoaded() {
                logger.debug("Legacy storage detected. Migrating from Legacy to V2.")
                try legacy.load()
                try v2.migrate(legacy: legacy, migration: migration)
                try legacy.remove()
            }
        }
        
        // Handle each version separately
        try migrateLegacy()
        
        // Migrate next versions
        // try migrateV2()
    }
    
    func createContentMigration() -> Migration? {
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

// MARK: Mapping

private extension SHPersistentStorage {
    func map(_ savedProduction: Production.Persistent.V2) -> Production {
        Production(savedProduction, itemProvider: item(id:), recipeProvider: recipe(id:))
    }
    
    func item(id: String) -> any Item {
        guard let item = staticStorage[itemID: id] else {
            fatalError("No item with id '\(id)'")
        }
        return item
    }
    
    func recipe(id: String) -> Recipe {
        guard let recipe = staticStorage[recipeID: id] else {
            fatalError("No recipe with id '\(id)'")
        }
        return recipe
    }
}

// MARK: - Errors
private extension SHPersistentStorage {
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
