import Foundation
import SHModels
import SHStaticModels

extension Production.Persistent {
    package struct V2: Identifiable, Codable, Hashable {
        package var id: UUID
        package var name: String
        package var creationDate: Date
        package var assetName: String
        package var content: Production.Content.Persistent.V2
        
        package init(id: UUID, name: String, creationDate: Date, assetName: String, content: Production.Content.Persistent.V2) {
            self.id = id
            self.name = name
            self.creationDate = creationDate
            self.assetName = assetName
            self.content = content
        }
        
        package mutating func migrate(migration: Migration) {
            content.migrate(migration: migration)
        }
    }
}
