import Foundation
import SHModels

extension Configuration {
    package struct Static: Codable {
        package let version: Int
        
        package init(version: Int) {
            self.version = version
        }
    }
    
    package init(_ configuration: Static) {
        self.init(version: configuration.version)
    }
}
