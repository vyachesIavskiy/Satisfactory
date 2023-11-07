import Foundation
import PersistentModels
import StorageLogger
import Dependencies

final class PersistentStorage {
    @Dependency(\.persistentStorageLegacyClient) private var legacy
    @Dependency(\.persistentStorageV2Client) private var v2
    
    private let logger = Logger(category: .persistent)
    
    var configuration: PersistentConfigurationV2 { v2.configuration() }
    var pins: PersistentPinsV2 { v2.pins() }
    var productions: [PersistentProductionV2] { v2.productions() }
    var factories: [PersistentFactoryV2] { v2.factories() }
    
    func load() throws {
        logger.log("Start loading persistent storage")
        // Step 1: Check if persistent storage is empty
        logger.debug("Step 1: Check if persistent storage is empty")
        guard try legacy.canBeLoaded() || v2.canBeLoaded() else {
            logger.debug("Persistent storage is empty, saving initial persistent storage")
            try v2.saveInitial()
            return
        }
        
        // Step 2: Persistent storage is not empty, attemp to migrate to the final version if needed
        logger.debug("Step 2: Migrate storage versions if needed")
        try migrateIfNeeded()
        
        logger.log("Finished loading persistent storage")
    }
    
    func save() throws {
        try v2.save()
    }
}

private extension PersistentStorage {
    func migrateIfNeeded() throws {
        logger.log("Start persistent storage migration")
        // Handle each version separately
        if try legacy.canBeLoaded() {
            logger.debug("Legacy persistent storage found, migrate persistent storage from 'legacy'")
            try v2.migrateFromLegacy()
        }
        
        // Migrate next versions
        // if try v2.canBeLoaded() {
        //     ...
        // }
        
        logger.log("Finished persistent storage migration")
    }
}

extension PersistentStorage {
    enum Version: CaseIterable {
        case legacy
        case v2
    }
}
