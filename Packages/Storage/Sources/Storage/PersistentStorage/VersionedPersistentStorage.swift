
protocol VersionedPersistentStorage {
    var version: PersistentStorage.Version { get }
    
    func canBeLoaded() throws -> Bool
    func load() throws
    func erase() throws
}
