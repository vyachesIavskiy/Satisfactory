import SHModels
import SHStaticModels

extension Part.Static {
    init(id: String, category: Category, form: Part.Form, isNaturalResource: Bool = false) {
        self.init(id: id, categoryID: category.id, formID: form.id, isNaturalResource: isNaturalResource)
    }
}

extension V2 {
    enum Parts {
        static let all =
        alienParts +
        biomassParts +
        communicationParts +
        consumedParts +
        containerParts +
        electronicParts +
        ficsmasParts +
        fluidParts +
        fuelParts +
        gasParts +
        industrialParts +
        ingotParts +
        mineralParts +
        nuclearParts +
        oilProductParts +
        oreParts +
        powerShardParts +
        powerSlugParts +
        quantumTechnologyParts +
        spaceElevatorParts +
        specialParts +
        standardParts
        
        static let allSortedByProgression = [
            HUBParts,
            baconAgaric,
            berylNut,
            paleberry,
            somersloop,
            mercerSphere,
            hardDrive,
            leaves,
            wood,
            mycelia,
            flowerPetals,
            hogRemains,
            plasmaSpitterRemains,
            stingerRemains,
            hatcherRemains,
            bluePowerSlug,
            yellowPowerSlug,
            purplePowerSlug,
            ironOre,
            ironIngot,
            ironPlate,
            ironRod,
            copperOre,
            copperIngot,
            wire,
            cable,
            limestone,
            concrete,
            screw,
            reinforcedIronPlate,
            biomass,
            alienProtein,
            alienDNACapsule,
            fabric,
            powerShard,
            copperSheet,
            rotor,
            modularFrame,
            smartPlating,
            ironRebar,
            solidBiofuel,
            colorCartridge,
            water,
            coal,
            steelIngot,
            steelBeam,
            steelPipe,
            versatileFramework,
            encasedIndustrialBeam,
            stator,
            motor,
            automatedWiring,
            heavyModularFrame,
            crudeOil,
            heavyOilResidue,
            plastic,
            rubber,
            polymerResin,
            fuel,
            petroleumCoke,
            circuitBoard,
            computer,
            modularEngine,
            adaptiveControlUnit,
            liquidBiofuel,
            emptyCanister,
            packagedWater,
            packagedOil,
            packagedHeavyOilResidue,
            packagedFuel,
            packagedLiquidBiofuel,
            gasFilter,
            cateriumOre,
            cateriumIngot,
            quickwire,
            stunRebar,
            aiLimiter,
            highSpeedConnector,
            supercomputer,
            bauxite,
            aluminaSolution,
            packagedAluminaSolution,
            aluminumScrap,
            aluminumIngot,
            alcladAluminumSheet,
            aluminumCasing,
            radioControlUnit,
            rawQuartz,
            quartzCrystal,
            silica,
            shatterRebar,
            crystalOscillator,
            sulfur,
            sulfuricAcid,
            packagedSulfuricAcid,
            battery,
            assemblyDirectorSystem,
            blackPowder,
            compactedCoal,
            turbofuel,
            packagedTurbofuel,
            nobelisk,
            gasNobelisk,
            pulseNobelisk,
            smokelessPowder,
            clusterNobelisk,
            explosiveRebar,
            rifleAmmo,
            homingRifleAmmo,
            turboRifleAmmo,
            iodineInfusedFilter,
            uranium,
            encasedUraniumCell,
            electromagneticControlRod,
            uraniumFuelRod,
            uraniumWaste,
            magneticFieldGenerator,
            nukeNobelisk,
            nitrogenGas,
            emptyFluidTank,
            packagedNitrogenGas,
            heatSink,
            coolingSystem,
            fusedModularFrame,
            turboMotor,
            thermalPropulsionRocket,
            nitricAcid,
            packagedNitricAcid,
            nonFissileUranium,
            plutoniumPellet,
            encasedPlutoniumCell,
            plutoniumFuelRod,
            plutoniumWaste,
            copperPowder,
            pressureConversionCube,
            nuclearPasta,
            coupon,
            samOre,
            superpositionOscillator,
            
            // FICSMAS is always on the bottom
            ficsmasGift,
            ficsmasTreeBranch,
            candyCanePart,
            ficsmasBow,
            redFicsmasOrnament,
            blueFicsmasOrnament,
            actualSnow,
            copperFicsmasOrnament,
            ironFicsmasOrnament,
            ficsmasOrnamentBundle,
            ficsmasDecoration,
            ficsmasWonderStar,
            snowball,
            sweetFireworks,
            fancyFireworks,
            sparklyFireworks
        ]
    }
}
