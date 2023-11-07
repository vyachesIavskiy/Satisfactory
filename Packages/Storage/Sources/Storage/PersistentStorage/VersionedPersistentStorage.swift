
protocol VersionedPersistentStorage {
    var version: PersistentStorage.Version { get }
    
    var canBeLoaded: () throws -> Bool { get set }
    var load: () throws -> Void { get set }
    var remove: () throws -> Void { get set }
}
