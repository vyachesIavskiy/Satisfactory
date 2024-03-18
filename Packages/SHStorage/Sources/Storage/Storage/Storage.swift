import Foundation
import Models
import PersistentModels
import struct StaticModels.Migration
import Dependencies
import SHLogger

@dynamicMemberLookup
final class Storage {
    private let staticStorage = Static()
    private var persistentStorage = Persistent()
    
    private let _logger = SHLogger(category: "Storage")
    
    subscript<Member>(dynamicMember keyPath: KeyPath<Static, Member>) -> Member {
        staticStorage[keyPath: keyPath]
    }
    
    subscript<Member>(dynamicMember keyPath: KeyPath<Persistent, Member>) -> Member {
        persistentStorage[keyPath: keyPath]
    }
    
    subscript<Member>(dynamicMember keyPath: WritableKeyPath<Persistent, Member>) -> Member {
        get { persistentStorage[keyPath: keyPath] }
        set { persistentStorage[keyPath: keyPath] = newValue }
    }

    @Sendable func load() throws {
        _logger {
            $0.info("Loading 'Storage'")
        }
        
        // Step 1: Load static data
        try staticStorage.load()
        
        // Step 2: Load persistent data. During this step all storage migrations will be done if needed.
        try persistentStorage.load(staticStorage: staticStorage)
        
        // Step 3: Migrate content
        try migrateContent(migrations: staticStorage.migrations)
        
        _logger {
            $0.info("'Storage' loaded")
        }
    }
    
    @Sendable func save() throws {
        _logger {
            $0.info("Saving 'Storage'")
        }
        
        try persistentStorage.save()
        
        _logger {
            $0.info("'Storage' saved")
        }
    }
}

// MARK: - Private

private extension Storage {
    func migrateContent(migrations: [Migration]) throws {
        // Step 1: Read already saved content version
        _logger(scope: .trace) {
            $0.trace("Step 1: Load currently stored content configuration version")
        }
        let contentVersion = persistentStorage.configuration.version
        
        _logger(scope: .trace) {
            $0.trace("Content configuration version: \(contentVersion)")
        }
        
        // Step 2: Filter out migrations that are already done
        _logger(scope: .trace) {
            $0.trace("Step 2: Filtering migrations that has lower content configuration version that already stored")
        }
        let remainingMigrations = migrations
            .filter { $0.version > contentVersion }
            .sorted()
        
        guard !remainingMigrations.isEmpty else {
            // There is no new migration, exit
            _logger(scope: .trace) {
                $0.info("No new content migrations found, abort content migration")
            }
            return
        }
        
        // Step 3: Merge remaining migrations into one migration from current state to the newest.
        _logger(scope: .trace) {
            $0.trace("Step 3: Merging all new migrations into one migration")
        }
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
        _logger(scope: .trace) {
            $0.trace("Step 4: Updating persistent storage with merged migration")
        }
        persistentStorage.migrateContent(migration: mergedMigration)
        
        // Step 5: Save storage
        _logger(scope: .trace) {
            $0.trace("Step 5: Saving storage")
        }
        
        try save()
    }
}
