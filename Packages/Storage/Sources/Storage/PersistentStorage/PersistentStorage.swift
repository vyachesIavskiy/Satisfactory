import Foundation
import PersistentModels

final class PersistentStorage {
    enum Version: CaseIterable {
        case legacy
        case v2
        
        var latest: Self { Self.allCases.last! }
        
        var directoryName: String {
            switch self {
            case .legacy: ""
            case .v2: "V2"
            }
        }
    }
    
    private let persistence: _Persistence
    private let currentVersion: PersistentStorageV2
    
    var configuration: PersistentConfigurationV2 { currentVersion.configuration }
    var pins: PersistentPinsV2 { currentVersion.pins }
    var productions: [PersistentProductionV2] { currentVersion.productions }
    var factories: [PersistentFactoryV2] { currentVersion.factories }
    
    init() {
        let persistence = _Persistence(directoryName: "")
        self.persistence = persistence
        self.currentVersion = PersistentStorageV2()
    }
    
    func load() throws -> Bool {
        // Step 1: Check if persistent storage is empty
        guard try !persistence.contents().isEmpty else {
            // If persistent storage is empty, save initial models
            try currentVersion.saveInitial()
            return false
        }
        
        // Step 2: Persistent storage is not empty, we need to figure out which version is currently stored.
        // We start from legacy and go up to current
        let versions: [VersionedPersistentStorage] = [
            PersistentStorageLegacy(),
            currentVersion
        ]
        
        for (index, version) in versions.dropLast().enumerated() {
            guard try version.canBeLoaded() else {
                continue
            }
            
            try migrate(from: version, remainingVersions: Array(versions[(index + 1)...]))
            return true
        }
        
        return false
    }
    
    func save() throws {
        try currentVersion.save()
    }
}

private extension PersistentStorage {
    private enum Error: Swift.Error {
        case noVersionToMigrate(from: PersistentStorage.Version)
        case cannotMigrate(from: PersistentStorage.Version, to: PersistentStorage.Version)
    }
    
    func migrate(from oldStorage: VersionedPersistentStorage, remainingVersions: [VersionedPersistentStorage]) throws {
        guard let newVersion = remainingVersions.first else {
            throw Error.noVersionToMigrate(from: oldStorage.version)
        }
        
        // Storage migrations are individual for each storage, so we need to check manually each case
        if let legacy = oldStorage as? PersistentStorageLegacy, let v2 = newVersion as? PersistentStorageV2 {
            try v2.migrate(from: legacy)
        } // ... add v2 to v3 migration when needed
        else {
            throw Error.cannotMigrate(from: oldStorage.version, to: newVersion.version)
        }
    }
}
