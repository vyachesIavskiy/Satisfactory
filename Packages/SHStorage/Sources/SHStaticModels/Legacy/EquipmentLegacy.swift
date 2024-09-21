import Foundation
import SHModels

package enum Equipment {}

extension Equipment {
    package enum Static {}
}

extension Equipment.Static {
    package struct Legacy: Decodable {
        package let id: String
        
        package init(id: String) {
            self.id = id
        }
    }
}
