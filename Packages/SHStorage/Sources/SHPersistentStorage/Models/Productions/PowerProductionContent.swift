import SHModels
import SHPersistentModels

extension Production.Content.Power {
    init(
        _ v2: Persistent.V2,
        partProvider: (String) -> Part,
        recipeProvider: (String) -> Recipe
    ) {
        self.init(statistics: Statistics())
    }
}

extension Production.Content.Power.Persistent.V2 {
    init(_ content: Production.Content.Power) {
        self.init()
    }
}
