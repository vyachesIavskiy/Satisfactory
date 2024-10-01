import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproduct: Ingredient,
        duration: Double,
        powerConsumption: PowerConsumption,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: [byproduct],
            machine: V2.Buildings.quantumEncoder,
            duration: duration,
            powerConsumption: powerConsumption,
            isDefault: isDefault
        )
    }
}

// MARK: - Space Elevator
extension V2.Recipes {
    static let aiExpansionServerRecipe = Recipe.Static(
        id: "recipe-ai-expansion-server",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.magneticFieldGenerator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.neuralQuantumProcessor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.superpositionOscillator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aiExpansionServer, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 25),
        duration: 15,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    private static let spaceElevatorRecipes = [
        aiExpansionServerRecipe
    ]
}

// MARK: - Quantum Technology
extension V2.Recipes {
    static let superpositionOscillatorRecipe = Recipe.Static(
        id: "recipe-superposition-oscillator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 9),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.superpositionOscillator, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 25),
        duration: 12,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    static let neuralQuantumProcessorRecipe = Recipe.Static(
        id: "recipe-neural-quantum-processor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.timeCrystal, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ficsiteTrigon, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.neuralQuantumProcessor, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 25),
        duration: 20,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    static let alienPowerMatrixRecipe = Recipe.Static(
        id: "recipe-alien-power-matrix",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.samFluctuator, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.powerShard, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.superpositionOscillator, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.alienPowerMatrix, amount: 10),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 24),
        duration: 24,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    fileprivate static let quantumTechnologyRecipes = [
        superpositionOscillatorRecipe,
        neuralQuantumProcessorRecipe,
        alienPowerMatrixRecipe,
    ]
}

// MARK: - Nuclear
extension V2.Recipes {
    static let ficsoniumFuelRodRecipe = Recipe.Static(
        id: "recipe-ficsonium-fuel-rod",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ficsonium, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.ficsiteTrigon, amount: 40),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsoniumFuelRod, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 20),
        duration: 24,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    fileprivate static let nuclearRecipes = [
        ficsoniumFuelRodRecipe,
    ]
}

// MARK: - Power Shards
extension V2.Recipes {
    static let syntheticPowerShardRecipe = Recipe.Static(
        id: "recipe-synthetic-power-shard",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.timeCrystal, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 12),
            Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.powerShard, amount: 1),
        byproduct: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 12),
        duration: 12,
        powerConsumption: Recipe.Static.PowerConsumption(min: 0, max: 2000)
    )
    
    fileprivate static let powerShardsRecipes = [
        syntheticPowerShardRecipe,
    ]
}

// MARK: Quantum Encoder recipes
extension V2.Recipes {
    static let quantumEncoderRecipes =
    spaceElevatorRecipes +
    quantumTechnologyRecipes +
    nuclearRecipes +
    powerShardsRecipes
}
