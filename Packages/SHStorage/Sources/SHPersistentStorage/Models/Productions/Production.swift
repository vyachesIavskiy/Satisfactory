import Foundation
import SHModels
import SHPersistentModels

extension Production {
    init(
        _ v2: Persistent.V2,
        partProvider: (_ partID: String) -> Part,
        recipeProvider: (_ recipeID: String) -> Recipe
    ) {
        self.init(
            id: v2.id,
            name: v2.name,
            creationDate: v2.creationDate,
            assetName: v2.assetName,
            content: Content(v2.content, partProvider: partProvider, recipeProvider: recipeProvider)
        )
    }
}

extension Production.Persistent.V2 {
    init(_ production: Production) {
        self.init(
            id: production.id,
            name: production.name,
            creationDate: production.creationDate,
            assetName: production.assetName,
            content: Production.Content.Persistent.V2(production.content)
        )
    }
}
