import StaticModels

private extension Recipe {
    init(id: String, inputs: [Ingredient], equipment: Equipment) {
        self.init(
            id: id,
            inputs: inputs,
            output: Ingredient(equipment, amount: 1),
            machines: [V2.Buildings.equipmentWorkshop],
            duration: 0
        )
    }
}

extension V2.Recipes {
    // MARK: - Tools
    static let portableMinerRecipe = Recipe(
        id: "recipe-portable-miner",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironPlate, amount: 2),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 4)
        ],
        equipment: V2.Equipment.portableMiner
    )
    
    static let objectScannerRecipe = Recipe(
        id: "recipe-object-scanner",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 4),
            Recipe.Ingredient(V2.Parts.wire, amount: 20),
            Recipe.Ingredient(V2.Parts.screw, amount: 50)
        ],
        equipment: V2.Equipment.objectScanner
    )
    
    static let chainsawRecipe = Recipe(
        id: "recipe-chainsaw",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 5),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 25),
            Recipe.Ingredient(V2.Parts.screw, amount: 160),
            Recipe.Ingredient(V2.Parts.cable, amount: 15)
        ],
        equipment: V2.Equipment.chainsaw
    )
    
    static let factoryCartRecipe = Recipe(
        id: "recipe-factory-cart",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 4),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 4),
            Recipe.Ingredient(V2.Parts.rotor, amount: 2)
        ],
        equipment: V2.Equipment.factoryCart
    )
    
    static let ziplineRecipe = Recipe(
        id: "recipe-zipline",
        inputs: [
            .init(V2.Equipment.xenoZapper, amount: 1),
            Recipe.Ingredient(V2.Parts.quickwire, amount: 30),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 3),
            Recipe.Ingredient(V2.Parts.cable, amount: 10)
        ],
        equipment: V2.Equipment.zipline
    )
    
    static let goldenFactoryCartRecipe = Recipe(
        id: "recipe-golden-factory-cart",
        inputs: [
            Recipe.Ingredient(V2.Parts.cateriumIngot, amount: 15),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 4),
            Recipe.Ingredient(V2.Parts.rotor, amount: 2)
        ],
        equipment: V2.Equipment.goldenFactoryCart
    )
    
    // MARK: - Consumables
    static let proteinInhalerRecipe = Recipe(
        id: "recipe-protein-inhaler",
        inputs: [
            Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
            Recipe.Ingredient(V2.Parts.berylNut, amount: 10)
        ],
        equipment: V2.Equipment.medicinalInhaler
    )
    
    static let nutritionalInhalerRecipe = Recipe(
        id: "recipe-nutritional-inhaler",
        inputs: [
            Recipe.Ingredient(V2.Parts.baconAgaric, amount: 1),
            Recipe.Ingredient(V2.Parts.paleberry, amount: 2),
            Recipe.Ingredient(V2.Parts.berylNut, amount: 5)
        ],
        equipment: V2.Equipment.medicinalInhaler
    )
    
    static let vitaminInhalerRecipe = Recipe(
        id: "recipe-vitamin-inhaler",
        inputs: [
            Recipe.Ingredient(V2.Parts.mycelia, amount: 10),
            Recipe.Ingredient(V2.Parts.paleberry, amount: 5)
        ],
        equipment: V2.Equipment.medicinalInhaler
    )
    
    static let therapeuticInhalerRecipe = Recipe(
        id: "recipe-therapeutic-inhaler",
        inputs: [
            Recipe.Ingredient(V2.Parts.mycelia, amount: 15),
            Recipe.Ingredient(V2.Parts.alienProtein, amount: 1),
            Recipe.Ingredient(V2.Parts.baconAgaric, amount: 1)
        ],
        equipment: V2.Equipment.medicinalInhaler
    )
    
    // MARK: - Weapons
    static let xenoZapperRecipe = Recipe(
        id: "recipe-xeno-zapper",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironRod, amount: 10),
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 2),
            Recipe.Ingredient(V2.Parts.cable, amount: 15),
            Recipe.Ingredient(V2.Parts.wire, amount: 50)
        ],
        equipment: V2.Equipment.xenoZapper
    )
    
    static let nobeliskDetonatorRecipe = Recipe(
        id: "recipe-nobelisk-detonator",
        inputs: [
            Recipe.Ingredient(V2.Equipment.objectScanner, amount: 1),
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 10),
            Recipe.Ingredient(V2.Parts.cable, amount: 50)
        ],
        equipment: V2.Equipment.nobeliskDetonator
    )
    
    static let xenoBasherRecipe = Recipe(
        id: "recipe-xeno-basher",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Ingredient(V2.Equipment.xenoZapper, amount: 2),
            Recipe.Ingredient(V2.Parts.cable, amount: 25),
            Recipe.Ingredient(V2.Parts.wire, amount: 500)
        ],
        equipment: V2.Equipment.xenoBasher
    )
    
    static let rebarGunRecipe = Recipe(
        id: "recipe-rebar-gun",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 6),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 16),
            Recipe.Ingredient(V2.Parts.screw, amount: 100)
        ],
        equipment: V2.Equipment.rebarGun
    )
    
    static let rifleRecipe = Recipe(
        id: "recipe-rifle",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 2),
            Recipe.Ingredient(V2.Parts.rubber, amount: 10),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 25),
            Recipe.Ingredient(V2.Parts.screw, amount: 250)
        ],
        equipment: V2.Equipment.rifle
    )
    
    static let candyCaneBasherRecipe = Recipe(
        id: "recipe-candy-cane-basher",
        inputs: [
            .init(V2.Equipment.xenoZapper, amount: 2),
            Recipe.Ingredient(V2.Parts.candyCanePart, amount: 25),
            Recipe.Ingredient(V2.Parts.ficsmasGift, amount: 15)
        ],
        equipment: V2.Equipment.candyCaneBasher
    )
    
    static let handEquipmentRecipes = [
        portableMinerRecipe,
        objectScannerRecipe,
        chainsawRecipe,
        factoryCartRecipe,
        ziplineRecipe,
        goldenFactoryCartRecipe,
        proteinInhalerRecipe,
        nutritionalInhalerRecipe,
        vitaminInhalerRecipe,
        therapeuticInhalerRecipe,
        xenoZapperRecipe,
        nobeliskDetonatorRecipe,
        xenoBasherRecipe,
        rebarGunRecipe,
        rifleRecipe,
        candyCaneBasherRecipe
    ]
}
