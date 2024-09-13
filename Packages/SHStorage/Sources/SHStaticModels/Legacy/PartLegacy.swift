import Foundation
import SHModels

extension Part.Static {
    package struct Legacy: Decodable {
        package let id: String
        
        package init(id: String) {
            self.id = id
        }
    }
}
