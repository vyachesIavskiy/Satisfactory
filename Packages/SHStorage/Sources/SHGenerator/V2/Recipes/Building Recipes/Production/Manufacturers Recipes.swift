import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(id: String, inputs: [Ingredient], building: Building.Static) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(building, amount: 1),
            machine: nil,
            manualCrafting: [],
            duration: 0
        )
    }
}

extension V2.Recipes {
    static let constructorRecipe = Recipe.Static(
        id: "recipe-constructor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 8)
        ],
        building: V2.Buildings.constructor
    )
    
    static let assemblerRecipe = Recipe.Static(
        id: "recipe-assembler",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 10)
        ],
        building: V2.Buildings.assembler
    )
    
    static let manufacturerRecipe = Recipe.Static(
        id: "recipe-manufacturer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 50)
        ],
        building: V2.Buildings.manufacturer
    )
    
    static let packagerRecipe = Recipe.Static(
        id: "recipe-packager",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 10)
        ],
        building: V2.Buildings.packager
    )
    
    static let refineryRecipe = Recipe.Static(
        id: "recipe-refinery",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 30),
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 20)
        ],
        building: V2.Buildings.refinery
    )
    
    static let blenderRecipe = Recipe.Static(
        id: "recipe-blender",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 5)
        ],
        building: V2.Buildings.blender
    )
    
    static let particleAcceleratorRecipe = Recipe.Static(
        id: "recipe-particle-accelerator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 10)
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
