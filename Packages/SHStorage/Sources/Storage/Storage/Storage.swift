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
    
    private let logger = SHLogger(category: "Storage")
    
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

    func load() throws {
        logger.info("Loading Storage.")
        
        try staticStorage.load()
        
        try persistentStorage.load(staticStorage: staticStorage)
        
        logger.info("Storage is loaded.")
    }
    
    func save() throws {
        logger.info("Saving Storage.")
        
        try persistentStorage.save()
        
        logger.info("Storage is saved.")
    }
}
