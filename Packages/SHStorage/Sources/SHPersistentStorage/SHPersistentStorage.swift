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
            .removeDuplicates()
            .map(Pins.init)
            .values
            .eraseToStream()
    }
    
    public var pins: Pins {
        Pins(v2.pins.value)
    }
    
    public var factories = [Factory]()
    
    public init(staticStorage: SHStaticStorage) {
        self.staticStorage = staticStorage
    }
    
    // MARK: Loading
    public func load() throws {
        logger.info("Loading Persistent storage.")
        
        // Check if storage can be loaded
        let legacy = Legacy()
        guard legacy.canBeLoaded() || v2.canBeLoaded() else {
            logger.info("Persistent storage is not detected, saving initial data.")
            
            try v2.saveInitial()
            return
        }
        
        if !v2.canBeLoaded() {
            // Migrate
            let migration = createContentMigration()
            try migrateIfNeeded(legacy: legacy, migration: migration)
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
}

// MARK: Migration
private extension SHPersistentStorage {
    func migrateIfNeeded(legacy: Legacy, migration: Migration?) throws {
        logger.info("Migrating Persistent storage.")
        
        // Handle each version separately
        if legacy.canBeLoaded() {
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
