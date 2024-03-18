import Foundation

public struct Configuration: Codable {
    public let version: Int
    
    public init(version: Int) {
        self.version = version
    }
}
