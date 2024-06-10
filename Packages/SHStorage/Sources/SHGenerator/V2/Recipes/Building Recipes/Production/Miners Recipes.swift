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
    static let minerMk1Recipe = Recipe.Static(
        id: "recipe-miner-mk-1",
        inputs: [
            Recipe.Static.Ingredient(V2.Equipment.portableMiner, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 10)
        ],
        building: V2.Buildings.minerMK1
    )
    
    static let minerMk2Recipe = Recipe.Static(
        id: "recipe-miner-mk-2",
        inputs: [
            Recipe.Static.Ingredient(V2.Equipment.portableMiner, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 10)
        ],
        building: V2.Buildings.minerMK2
    )
    
    static let minerMk3Recipe = Recipe.Static(
        id: "recipe-miner-mk-3",
        inputs: [
            Recipe.Static.Ingredient(V2.Equipment.portableMiner, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 3)
        ],
        building: V2.Buildings.minerMK3
    )
    
    static let minersRecipes = [
        minerMk1Recipe,
        minerMk2Recipe,
        minerMk3Recipe
    ]
}
