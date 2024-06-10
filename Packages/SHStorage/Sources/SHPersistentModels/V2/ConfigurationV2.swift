import Foundation
import SHModels

extension Configuration.Persistent {
    public struct V2: Codable {
        public var version: Int
        
        public init(version: Int = 0) {
            self.version = version
        }
    }
}
