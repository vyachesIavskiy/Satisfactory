import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproduct: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [byproduct],
            machine: V2.Buildings.blender,
            manualCrafting: [],
            duration: duration,
            electricityConsumption: ElectricityConsumption(min: 75, max: 75),
            isDefault: isDefault
        )
    }
    
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [],
            machine: V2.Buildings.blender,
            manualCrafting: [],
            duration: duration,
            electricityConsumption: ElectricityConsumption(min: 75, max: 75),
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Industrial Parts
    static let coolingSystemRecipe = Recipe.Static(
        id: "recipe-cooling-system",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 1),
        duration: 10
    )
    
    static let coolingSystemRecipe1 = Recipe.Static(
        id: "recipe-alternate-cooling-device",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 2),
        duration: 32,
        isDefault: false
    )
    
    static let fusedModularFrameRecipe = Recipe.Static(
        id: "recipe-fused-modular-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 1),
        duration: 40
    )
    
    static let fusedModularFrameRecipe1 = Recipe.Static(
        id: "recipe-alternate-heat-fused-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.fuel, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 1),
        duration: 20,
        isDefault: false
    )
    
    static let batteryRecipe = Recipe.Static(
        id: "recipe-battery",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 2.5),
            Recipe.Static.Ingredient(V2.Parts.aluminaSolution, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.battery, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.water, amount: 1.5),
        duration: 3
    )
    
    // MARK: - Fuel
    static let fuelRecipe2 = Recipe.Static(
        id: "recipe-alternate-diluted-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heavyOilResidue, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fuel, amount: 10),
        duration: 6,
        isDefault: false
    )
    
    static let turbofuelRecipe2 = Recipe.Static(
        id: "recipe-alternate-turbo-blend-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fuel, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.heavyOilResidue, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turbofuel, amount: 6),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Nuclear
    static let nonFissileUraniumRecipe = Recipe.Static(
        id: "recipe-non-fissile-uranium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.uraniumWaste, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 20),
        byproduct: Recipe.Static.Ingredient(V2.Parts.water, amount: 6),
        duration: 24
    )
    
    static let nonFissileUraniumRecipe1 = Recipe.Static(
        id: "recipe-alternate-fertile-uranium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.uranium, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.uraniumWaste, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 20),
        byproduct: Recipe.Static.Ingredient(V2.Parts.water, amount: 8),
        duration: 12,
        isDefault: false
    )
    
    static let encasedUraniumCellRecipe = Recipe.Static(
        id: "recipe-encased-uranium-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.uranium, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 5),
        byproduct: Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 2),
        duration: 12
    )
    
    // MARK: - Andvanced Refinement
    static let nitricAcidRecipe = Recipe.Static(
        id: "recipe-nitric-acid",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 12),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 3),
        duration: 6
    )
    
    static let aluminumScrapRecipe2 = Recipe.Static(
        id: "recipe-alternate-instant-scrap",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.sulfuricAcid, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aluminumScrap, amount: 30),
        byproduct: Recipe.Static.Ingredient(V2.Parts.water, amount: 5),
        duration: 6,
        isDefault: false
    )
    
    static let blenderRecipes = [
        coolingSystemRecipe,
        coolingSystemRecipe1,
        fusedModularFrameRecipe,
        fusedModularFrameRecipe1,
        batteryRecipe,
        fuelRecipe2,
        turbofuelRecipe2,
        nonFissileUraniumRecipe,
        nonFissileUraniumRecipe1,
        encasedUraniumCellRecipe,
        nitricAcidRecipe,
        aluminumScrapRecipe2
    ]
}
