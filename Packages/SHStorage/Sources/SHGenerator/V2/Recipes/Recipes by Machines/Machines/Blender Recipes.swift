import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproduct: Ingredient,
        duration: Double,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [byproduct],
            machine: V2.Buildings.blender,
            duration: duration,
            powerConsumption: PowerConsumption(75),
            isDefault: isDefault
        )
    }
    
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Double,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [],
            machine: V2.Buildings.blender,
            duration: duration,
            powerConsumption: PowerConsumption(75),
            isDefault: isDefault
        )
    }
}

// MARK: - Space Elevator
extension V2.Recipes {
    static let biochemicalSculpturRecipe = Recipe.Static(
        id: "recipe-biochemical-sculptor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.assemblyDirectorSystem, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ficsiteTrigon, amount: 80),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.biochemicalSculptor, amount: 4),
        duration: 120
    )
    
    private static let spaceElevatorRecipes = [
        biochemicalSculpturRecipe
    ]
}

// MARK: - Andvanced Refinement
extension V2.Recipes {
    static let distilledSilicaRecipe = Recipe.Static(
        id: "recipe-alternate-distilled-silica",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.dissolvedSilica, amount: 12),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.silica, amount: 27),
        byproduct: Recipe.Static.Ingredient(V2.Parts.water, amount: 8),
        duration: 6
    )
    
    static let instantScrapRecipe = Recipe.Static(
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
    
    private static let advancedRefinementRecipes = [
        distilledSilicaRecipe,
        instantScrapRecipe,
        nitricAcidRecipe,
    ]
}

// MARK: - Fuel
extension V2.Recipes {
    static let dilutedFuelRecipe = Recipe.Static(
        id: "recipe-alternate-diluted-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heavyOilResidue, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.water, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fuel, amount: 10),
        duration: 6,
        isDefault: false
    )
    
    static let turboBlendFuelRecipe = Recipe.Static(
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
    
    static let rocketFuelRecipe = Recipe.Static(
        id: "recipe-rocket-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.turbofuel, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.nitricAcid, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rocketFuel, amount: 10),
        byproduct: Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 1),
        duration: 6
    )
    
    static let nitroRocketFuelRecipe = Recipe.Static(
        id: "recipe-alternate-nitro-rocket-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fuel, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rocketFuel, amount: 6),
        byproduct: Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 1),
        duration: 2.4
    )
    
    private static let fuelRecipes = [
        dilutedFuelRecipe,
        turboBlendFuelRecipe,
        rocketFuelRecipe,
        nitroRocketFuelRecipe,
    ]
}

// MARK: - Industrial Parts
extension V2.Recipes {
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
    
    static let coolingDeviceRecipe = Recipe.Static(
        id: "recipe-alternate-cooling-device",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 2),
        duration: 24,
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
    
    static let heatFusedModularFrameRecipe = Recipe.Static(
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
    
    private static let industrialPartsRecipes = [
        coolingSystemRecipe,
        coolingDeviceRecipe,
        fusedModularFrameRecipe,
        heatFusedModularFrameRecipe,
        batteryRecipe,
    ]
}

// MARK: - Nuclear
extension V2.Recipes {
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
    
    static let fertileUraniumRecipe = Recipe.Static(
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
    
    private static let nuclearRecipes = [
        encasedUraniumCellRecipe,
        nonFissileUraniumRecipe,
        fertileUraniumRecipe,
    ]
}

// MARK: - Ammunition
extension V2.Recipes {
    static let blenderTurboRifleAmmoRecipe = Recipe.Static(
        id: "recipe-turbo-rifle-ammo-blender",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.turbofuel, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboRifleAmmo, amount: 50),
        duration: 12
    )
    
    private static let ammunitionRecipes = [
        blenderTurboRifleAmmoRecipe,
    ]
}

// MARK: Blender recipes
extension V2.Recipes {
    static let blenderRecipes =
    spaceElevatorRecipes +
    advancedRefinementRecipes +
    fuelRecipes +
    industrialPartsRecipes +
    nuclearRecipes +
    ammunitionRecipes
}
