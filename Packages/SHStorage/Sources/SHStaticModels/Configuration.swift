import Foundation
import SHModels

extension Configuration {
    public struct Static: Codable {
        public let version: Int
        
        public init(version: Int) {
            self.version = version
        }
    }
    
    public init(_ configuration: Static) {
        self.init(version: configuration.version)
    }
}
