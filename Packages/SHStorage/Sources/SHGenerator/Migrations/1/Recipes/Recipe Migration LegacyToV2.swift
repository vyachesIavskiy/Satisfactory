import SHModels
import SHStaticModels

extension Migration.IDs {
    init(old: Recipe.Static.Legacy, new: Recipe.Static) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Recipes {
        static let all =
        assemblerRecipes +
        blenderRecipes +
        constructorRecipes +
        foundryRecipes +
        manufacturerRecipes +
        nuclearPowerPlantRecipes +
        packagerRecipes +
        particleAcceleratorRecipes +
        refineryRecipes +
        smelterRecipes
    }
}
