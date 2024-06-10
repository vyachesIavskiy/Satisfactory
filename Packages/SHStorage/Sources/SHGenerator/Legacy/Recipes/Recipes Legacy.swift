import SHStaticModels

extension Legacy {
    enum Recipes {
        static var all = 
        smelterRecipes +
        foundryRecipes +
        constructorRecipes +
        assemblerRecipes +
        refineryRecipes +
        packagerRecipes +
        manufacturerRecipes +
        blenderRecipes +
        nuclearPowerPlantRecipes +
        particleAcceleratorRecipes
    }
}
