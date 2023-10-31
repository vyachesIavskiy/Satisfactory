import Foundation

public struct PersistentConfigurationV2: Codable {
    public var version: Int
    
    public init(version: Int = 0) {
        self.version = version
    }
}
