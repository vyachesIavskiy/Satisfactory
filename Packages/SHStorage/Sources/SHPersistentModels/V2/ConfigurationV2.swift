import Foundation
import SHModels

extension Configuration.Persistent {
    package struct V2: Codable {
        package var version: Int
        
        package init(version: Int = 0) {
            self.version = version
        }
    }
}
