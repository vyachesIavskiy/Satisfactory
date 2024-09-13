
extension LegacyToV2.Recipes {
    // MARK: - Space Elevator
    static let modularEngineRecipe = Migration.IDs(old: Legacy.Recipes.modularEngineRecipe, new: V2.Recipes.modularEngineRecipe)
    static let adaptiveControlUnitRecipe = Migration.IDs(old: Legacy.Recipes.adaptiveControlUnitRecipe, new: V2.Recipes.adaptiveControlUnitRecipe)
    static let magneticFieldGeneratorRecipe = Migration.IDs(old: Legacy.Recipes.magneticFieldGeneratorRecipe, new: V2.Recipes.magneticFieldGeneratorRecipe)
    static let thermalPropulsionRocketRecipe = Migration.IDs(old: Legacy.Recipes.thermalPropulsionRocketRecipe, new: V2.Recipes.thermalPropulsionRocketRecipe)
    static let plasticSmartPlatingRecipe = Migration.IDs(old: Legacy.Recipes.smartPlatingRecipe1, new: V2.Recipes.plasticSmartPlatingRecipe)
    static let flexibleFrameworkRecipe = Migration.IDs(old: Legacy.Recipes.versatileFrameworkRecipe1, new: V2.Recipes.flexibleFrameworkRecipe)
    static let automatedSpeedWiringRecipe = Migration.IDs(old: Legacy.Recipes.automatedWiringRecipe1, new: V2.Recipes.automatedSpeedWiringRecipe)
    
    // MARK: - Standard Parts
    static let heavyModularFrameRecipe = Migration.IDs(old: Legacy.Recipes.heavyModularFrameRecipe, new: V2.Recipes.heavyModularFrameRecipe)
    static let heavyFlexibleFrameRecipe = Migration.IDs(old: Legacy.Recipes.heavyModularFrameRecipe1, new: V2.Recipes.heavyFlexibleFrameRecipe)
    static let heavyEncasedFrameRecipe = Migration.IDs(old: Legacy.Recipes.heavyModularFrameRecipe2, new: V2.Recipes.heavyEncasedFrameRecipe)
    
    // MARK: - Electronics
    static let highSpeedConnectorRecipe = Migration.IDs(old: Legacy.Recipes.highSpeedConnectorRecipe, new: V2.Recipes.highSpeedConnectorRecipe)
    static let siliconHighSpeedConnectorRecipe = Migration.IDs(old: Legacy.Recipes.highSpeedConnectorRecipe1, new: V2.Recipes.siliconHighSpeedConnectorRecipe)

    // MARK: - Industrial Parts
    static let turboMotorRecipe = Migration.IDs(old: Legacy.Recipes.turboMotorRecipe, new: V2.Recipes.turboMotorRecipe)
    static let turboElectricMotorRecipe = Migration.IDs(old: Legacy.Recipes.turboMotorRecipe1, new: V2.Recipes.turboElectricMotorRecipe)
    static let turboPressureMotorRecipe = Migration.IDs(old: Legacy.Recipes.turboMotorRecipe2, new: V2.Recipes.turboPressureMotorRecipe)
    static let rigorMotorRecipe = Migration.IDs(old: Legacy.Recipes.motorRecipe2, new: V2.Recipes.rigorMotorRecipe)
    static let classicBatteryRecipe = Migration.IDs(old: Legacy.Recipes.batteryRecipe1, new: V2.Recipes.classicBatteryRecipe)

    // MARK: - Communications
    static let computerRecipe = Migration.IDs(old: Legacy.Recipes.computerRecipe, new: V2.Recipes.computerRecipe)
    static let cateriumComputerRecipe = Migration.IDs(old: Legacy.Recipes.computerRecipe2, new: V2.Recipes.cateriumComputerRecipe)
    static let crystalOscillatorRecipe = Migration.IDs(old: Legacy.Recipes.crystalOscillatorRecipe, new: V2.Recipes.crystalOscillatorRecipe)
    static let insulatedCrystalOscillatorRecipe = Migration.IDs(old: Legacy.Recipes.crystalOscillatorRecipe1, new: V2.Recipes.insulatedCrystalOscillatorRecipe)
    static let supercomputerRecipe = Migration.IDs(old: Legacy.Recipes.supercomputerRecipe, new: V2.Recipes.supercomputerRecipe)
    static let superStateComputerRecipe = Migration.IDs(old: Legacy.Recipes.supercomputerRecipe1, new: V2.Recipes.superStateComputerRecipe)
    static let radioControlUnitRecipe = Migration.IDs(old: Legacy.Recipes.radioControlUnitRecipe, new: V2.Recipes.radioControlUnitRecipe)
    static let radioConnectionUnitRecipe = Migration.IDs(old: Legacy.Recipes.radioControlUnitRecipe1, new: V2.Recipes.radioConnectionUnitRecipe)
    static let radioControlSystemRecipe = Migration.IDs(old: Legacy.Recipes.radioControlUnitRecipe2, new: V2.Recipes.radioControlSystemRecipe)

    // MARK: - Nuclear
    static let uraniumFuelRodRecipe = Migration.IDs(old: Legacy.Recipes.uraniumFuelRodRecipe, new: V2.Recipes.uraniumFuelRodRecipe)
    static let uraniumFuelUnitRecipe = Migration.IDs(old: Legacy.Recipes.uraniumFuelRodRecipe1, new: V2.Recipes.uraniumFuelUnitRecipe)
    static let infusedUraniumCellRecipe = Migration.IDs(old: Legacy.Recipes.encasedUraniumCellRecipe1, new: V2.Recipes.infusedUraniumCellRecipe)
    static let plutoniumFuelRodRecipe = Migration.IDs(old: Legacy.Recipes.plutoniumFuelRodRecipe, new: V2.Recipes.plutoniumFuelRodRecipe)

    // MARK: - Consumables
    static let gasFilterRecipe = Migration.IDs(old: Legacy.Recipes.gasFilterRecipe, new: V2.Recipes.gasFilterRecipe)
    static let iodineInfusedFilterRecipe = Migration.IDs(old: Legacy.Recipes.iodineInfusedFilterRecipe, new: V2.Recipes.iodineInfusedFilterRecipe)
    
    // MARK: - Ammunition
    static let explosiveRebarRecipe = Migration.IDs(old: Legacy.Recipes.explosiveRebarRecipe, new: V2.Recipes.explosiveRebarRecipe)
    static let turboRifleAmmoRecipe = Migration.IDs(old: Legacy.Recipes.turboRifleAmmoRecipe, new: V2.Recipes.manufacturerTurboRifleAmmoRecipe)
    static let nukeNobeliskRecipe = Migration.IDs(old: Legacy.Recipes.nukeNobeliskRecipe, new: V2.Recipes.nukeNobeliskRecipe)

    static let manufacturerRecipes = [
        // Space Elevator
        modularEngineRecipe,
        adaptiveControlUnitRecipe,
        magneticFieldGeneratorRecipe,
        thermalPropulsionRocketRecipe,
        plasticSmartPlatingRecipe,
        flexibleFrameworkRecipe,
        automatedSpeedWiringRecipe,
        
        // Standard Parts
        heavyModularFrameRecipe,
        heavyFlexibleFrameRecipe,
        heavyEncasedFrameRecipe,
        
        // Electronics
        highSpeedConnectorRecipe,
        siliconHighSpeedConnectorRecipe,

        // Industrial Parts
        turboMotorRecipe,
        turboElectricMotorRecipe,
        turboPressureMotorRecipe,
        rigorMotorRecipe,
        classicBatteryRecipe,

        // Communications
        computerRecipe,
        cateriumComputerRecipe,
        crystalOscillatorRecipe,
        insulatedCrystalOscillatorRecipe,
        supercomputerRecipe,
        superStateComputerRecipe,
        radioControlUnitRecipe,
        radioConnectionUnitRecipe,
        radioControlSystemRecipe,

        // Nuclear
        uraniumFuelRodRecipe,
        uraniumFuelUnitRecipe,
        infusedUraniumCellRecipe,
        plutoniumFuelRodRecipe,

        // Consumables
        gasFilterRecipe,
        iodineInfusedFilterRecipe,
        
        // Ammunition
        explosiveRebarRecipe,
        turboRifleAmmoRecipe,
        nukeNobeliskRecipe,
    ]
}
