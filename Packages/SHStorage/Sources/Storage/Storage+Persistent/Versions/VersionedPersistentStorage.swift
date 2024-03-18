
protocol VersionedPersistentStorage {
    var version: Storage.Persistent.Version { get }
    
    func canBeLoaded() throws -> Bool
    func load() throws
    func remove() throws
}
