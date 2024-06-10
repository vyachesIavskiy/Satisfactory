
protocol VersionedStorage {
    var version: Version { get }
    
    func canBeLoaded() throws -> Bool
    func load() throws
    func remove() throws
}
