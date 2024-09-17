import Foundation
import SHModels
import SHStaticModels

extension Production.Content.Power.Persistent {
    package struct V2: Codable, Hashable {
        package init() {
        }
        
        mutating func migrate(_ migration: Migration) {
            // TODO: Add migration
        }
    }
}
