import StaticModels

private extension Recipe {
    init(id: String, inputs: [Ingredient], building: Building) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(building, amount: 1),
            machines: [],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let constructorRecipe = Recipe(
        id: "recipe-constructor",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 2),
            Recipe.Ingredient(V2.Parts.cable, amount: 8)
        ],
        building: V2.Buildings.constructor
    )
    
    static let assemblerRecipe = Recipe(
        id: "recipe-assembler",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 8),
            Recipe.Ingredient(V2.Parts.rotor, amount: 4),
            Recipe.Ingredient(V2.Parts.cable, amount: 10)
        ],
        building: V2.Buildings.assembler
    )
    
    static let manufacturerRecipe = Recipe(
        id: "recipe-manufacturer",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 5),
            Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 10),
            Recipe.Ingredient(V2.Parts.cable, amount: 50),
            Recipe.Ingredient(V2.Parts.plastic, amount: 50)
        ],
        building: V2.Buildings.manufacturer
    )
    
    static let packagerRecipe = Recipe(
        id: "recipe-packager",
        inputs: [
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 20),
            Recipe.Ingredient(V2.Parts.rubber, amount: 10),
            Recipe.Ingredient(V2.Parts.plastic, amount: 10)
        ],
        building: V2.Buildings.packager
    )
    
    static let refineryRecipe = Recipe(
        id: "recipe-refinery",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 10),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 10),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 30),
            Recipe.Ingredient(V2.Parts.copperSheet, amount: 20)
        ],
        building: V2.Buildings.refinery
    )
    
    static let blenderRecipe = Recipe(
        id: "recipe-blender",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 20),
            Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 10),
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 50),
            Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 5)
        ],
        building: V2.Buildings.blender
    )
    
    static let particleAcceleratorRecipe = Recipe(
        id: "recipe-particle-accelerator",
        inputs: [
            Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 25),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 100),
            Recipe.Ingredient(V2.Parts.supercomputer, amount: 10),
            Recipe.Ingredient(V2.Parts.coolingSystem, amount: 50),
            Recipe.Ingredient(V2.Parts.fusedModularFrame, amount: 20),
            Recipe.Ingredient(V2.Parts.turboMotor, amount: 10)
        ],
        building: V2.Buildings.particleAccelerator
    )
    
    static let manufacturersRecipes = [
        constructorRecipe,
        assemblerRecipe,
        manufacturerRecipe,
        packagerRecipe,
        refineryRecipe,
        blenderRecipe,
        particleAcceleratorRecipe
    ]
}
