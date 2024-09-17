import SHModels
import SHPersistentModels

extension Production.Content.FromResources {
    init(
        _ v2: Persistent.V2,
        partProvider: (String) -> Part,
        recipeProvider: (String) -> Recipe
    ) {
        self.init(statistics: Statistics())
    }
}

extension Production.Content.FromResources.Persistent.V2 {
    init(_ content: Production.Content.FromResources) {
        self.init()
    }
}
