import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: [Ingredient],
        output: [Ingredient],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: input,
            output: output,
            machines: [Legacy.Buildings.blender.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // MARK: - Industrial Parts
    static let coolingSystemRecipe = Recipe.Static.Legacy(
        id: "cooling-system",
        name: "Cooling System",
        input: [
            .init(Legacy.Parts.heatSink, amount: 2),
            .init(Legacy.Parts.rubber, amount: 2),
            .init(Legacy.Parts.water, amount: 5),
            .init(Legacy.Parts.nitrogenGas, amount: 25)
        ],
        output: [
            .init(Legacy.Parts.coolingSystem, amount: 1)
        ],
        duration: 10
    )

    static let coolingSystemRecipe1 = Recipe.Static.Legacy(
        id: "alternate-cooling-device",
        name: "Alternate: Cooling Device",
        input: [
            .init(Legacy.Parts.heatSink, amount: 5),
            .init(Legacy.Parts.motor, amount: 1),
            .init(Legacy.Parts.nitrogenGas, amount: 24)
        ],
        output: [
            .init(Legacy.Parts.coolingSystem, amount: 2)
        ],
        duration: 32,
        isDefault: false
    )

    static let fusedModularFrameRecipe = Recipe.Static.Legacy(
        id: "fused-modular-frame",
        name: "Fused Modular Frame",
        input: [
            .init(Legacy.Parts.heavyModularFrame, amount: 1),
            .init(Legacy.Parts.aluminumCasing, amount: 50),
            .init(Legacy.Parts.nitrogenGas, amount: 25)
        ],
        output: [
            .init(Legacy.Parts.fusedModularFrame, amount: 1)
        ],
        duration: 40
    )

    static let fusedModularFrameRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heat-fused-frame",
        name: "Alternate: Heat-Fused Frame",
        input: [
            .init(Legacy.Parts.heavyModularFrame, amount: 1),
            .init(Legacy.Parts.aluminumIngot, amount: 50),
            .init(Legacy.Parts.nitricAcid, amount: 8),
            .init(Legacy.Parts.fuel, amount: 10)
        ],
        output: [
            .init(Legacy.Parts.fusedModularFrame, amount: 1)
        ],
        duration: 20,
        isDefault: false
    )

    static let batteryRecipe = Recipe.Static.Legacy(
        id: "battery",
        name: "Battery",
        input: [
            .init(Legacy.Parts.sulfuricAcid, amount: 2.5),
            .init(Legacy.Parts.aluminaSolution, amount: 2),
            .init(Legacy.Parts.aluminumCasing, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.battery, amount: 1),
            .init(Legacy.Parts.water, amount: 1.5)
        ],
        duration: 3
    )

    // Fuel
    static let fuelRecipe2 = Recipe.Static.Legacy(
        id: "alternate-diluted-fuel",
        name: "Alternate: Diluted Fuel",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 5),
            .init(Legacy.Parts.water, amount: 10)
        ],
        output: [
            .init(Legacy.Parts.fuel, amount: 10)
        ],
        duration: 6,
        isDefault: false
    )

    static let turbofuelRecipe2 = Recipe.Static.Legacy(
        id: "alternate-turbo-blend-fuel",
        name: "Alternate: Turbo Blend Fuel",
        input: [
            .init(Legacy.Parts.fuel, amount: 2),
            .init(Legacy.Parts.heavyOilResidue, amount: 4),
            .init(Legacy.Parts.sulfur, amount: 3),
            .init(Legacy.Parts.petroleumCoke, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.turbofuel, amount: 6)
        ],
        duration: 8,
        isDefault: false
    )

    // Nuclear
    static let nonFissileUraniumRecipe = Recipe.Static.Legacy(
        id: "non-fissile-uranium",
        name: "Non-fissile Uranium",
        input: [
            .init(Legacy.Parts.uraniumWaste, amount: 15),
            .init(Legacy.Parts.silica, amount: 10),
            .init(Legacy.Parts.nitricAcid, amount: 6),
            .init(Legacy.Parts.sulfuricAcid, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.nonFissileUranium, amount: 20),
            .init(Legacy.Parts.water, amount: 6)
        ],
        duration: 24
    )

    static let nonFissileUraniumRecipe1 = Recipe.Static.Legacy(
        id: "alternate-fertile-uranium",
        name: "Alternate: Fertile Uranium",
        input: [
            .init(Legacy.Parts.uranium, amount: 5),
            .init(Legacy.Parts.uraniumWaste, amount: 5),
            .init(Legacy.Parts.nitricAcid, amount: 3),
            .init(Legacy.Parts.sulfuricAcid, amount: 5)
        ],
        output: [
            .init(Legacy.Parts.nonFissileUranium, amount: 20),
            .init(Legacy.Parts.water, amount: 8)
        ],
        duration: 12,
        isDefault: false
    )

    static let encasedUraniumCellRecipe = Recipe.Static.Legacy(
        id: "encased-uranium-cell",
        name: "Encased Uranium Cell",
        input: [
            .init(Legacy.Parts.uranium, amount: 10),
            .init(Legacy.Parts.concrete, amount: 3),
            .init(Legacy.Parts.sulfuricAcid, amount: 8)
        ],
        output: [
            .init(Legacy.Parts.encasedUraniumCell, amount: 5),
            .init(Legacy.Parts.sulfuricAcid, amount: 2)
        ],
        duration: 12
    )

    // Andvanced Refinement
    static let nitricAcidRecipe = Recipe.Static.Legacy(
        id: "nitric-acid",
        name: "Nitric Acid",
        input: [
            .init(Legacy.Parts.nitrogenGas, amount: 12),
            .init(Legacy.Parts.water, amount: 3),
            .init(Legacy.Parts.ironPlate, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.nitricAcid, amount: 3)
        ],
        duration: 6
    )

    static let aluminumScrapRecipe2 = Recipe.Static.Legacy(
        id: "alternate-instant-scrap",
        name: "Alternate: Instant Scrap",
        input: [
            .init(Legacy.Parts.bauxite, amount: 15),
            .init(Legacy.Parts.coal, amount: 10),
            .init(Legacy.Parts.sulfuricAcid, amount: 5),
            .init(Legacy.Parts.water, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.aluminumScrap, amount: 30),
            .init(Legacy.Parts.water, amount: 5)
        ],
        duration: 6,
        isDefault: false
    )

    static let blenderRecipes = [
        // Industrial parts
        coolingSystemRecipe,
        coolingSystemRecipe1,
        fusedModularFrameRecipe,
        fusedModularFrameRecipe1,
        batteryRecipe,
        
        // Fuel
        fuelRecipe2,
        turbofuelRecipe2,
        
        // Nuclear
        nonFissileUraniumRecipe,
        nonFissileUraniumRecipe1,
        encasedUraniumCellRecipe,
        
        // Advanced Refinement
        nitricAcidRecipe,
        aluminumScrapRecipe2
    ]
}