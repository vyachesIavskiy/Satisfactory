import Foundation

struct Part: Codable, Resource, CustomStringConvertible {
    let id = UUID()
    let name: String
    let type: PartType
}

// MARK: - Hub Parts
let hubParts = Part(name: "Hub Parts", type: .hubParts)

// MARK: - Ores
let ironOre = Part(name: "Iron Ore", type: .ores)
let copperOre = Part(name: "Copper Ore", type: .ores)
let limestone = Part(name: "Limestone", type: .ores)
let coal = Part(name: "Coal", type: .ores)
let rawQuartz = Part(name: "Raw Quartz", type: .ores)
let cateriumOre = Part(name: "Caterium Ore", type: .ores)
let sulfur = Part(name: "Sulfur", type: .ores)
let bauxite = Part(name: "Bauxite", type: .ores)
let uranium = Part(name: "Uranium", type: .ores)

// MARK: - Fuels
let leaves = Part(name: "Leaves", type: .fuels)
let wood = Part(name: "Wood", type: .fuels)
let mycelia = Part(name: "Mycelia", type: .fuels)
let biomass = Part(name: "Biomass", type: .fuels)
let flowerPetals = Part(name: "Flower Petals", type: .fuels)

// MARK: - Aliens
let alienCarapace = Part(name: "Alien Carapace", type: .aliens)
let alienOrgans = Part(name: "Alien Organs", type: .aliens)

// MARK: - Power Slugs
let greenPowerSlug = Part(name: "Green Power Slug", type: .powerSlugs)
let yellowPowerSlug = Part(name: "Yellow Power Slug", type: .powerSlugs)
let purplePowerSlug = Part(name: "Purple Power Slug", type: .powerSlugs)

// MARK: - Liquids
let water = Part(name: "Water", type: .liquids)
let crudeOil = Part(name: "Crude Oil", type: .liquids)
let heavyOilResidue = Part(name: "Heavy Oil Residue", type: .liquids)
let fuel = Part(name: "Fuel", type: .liquids)
let liquidBiofuel = Part(name: "Liquid Biofuel", type: .liquids)

// MARK: - Ingots
let ironIngot = Part(name: "Iron Ingot", type: .ingots)
let copperIngot = Part(name: "Copper Ingot", type: .ingots)
let cateriumIngot = Part(name: "Caterium Ingot", type: .ingots)
let steelIngot = Part(name: "Steel Ingot", type: .ingots)

// MARK: - Standart Parts
let ironPlate = Part(name: "Iron Plate", type: .standartParts)
let ironRod = Part(name: "Iron Rod", type: .standartParts)
let screw = Part(name: "Screw", type: .standartParts)
let reinforcedIronPlate = Part(name: "Reinforced Iron Plate", type: .standartParts)
let copperSheet = Part(name: "Copper Sheet", type: .standartParts)
let modularFrame = Part(name: "Modular Frame", type: .standartParts)
let steelBeam = Part(name: "Steel Beam", type: .standartParts)
let steelPipe = Part(name: "Steel Pipe", type: .standartParts)
let encasedIndustrialBeam = Part(name: "Encased Industrial Beam", type: .standartParts)
let heavyModularFrame = Part(name: "Heavy Modular Frame", type: .standartParts)

// MARK: - Electronics
let wire = Part(name: "Wire", type: .electronics)
let cable = Part(name: "Cable", type: .electronics)
let quickWire = Part(name: "Quick Wire", type: .electronics)
let circuitBoard = Part(name: "Circuit Board", type: .electronics)
let aiLimiter = Part(name: "A.I. Limiter", type: .electronics)

// MARK: - Minerals
let concrete = Part(name: "Concrete", type: .minerals)
let quartzCrystal = Part(name: "Quartz Crystal", type: .minerals)
let silica = Part(name: "Silica", type: .minerals)

// MARK: - Biomass
let biomassWood = Part(name: "Biomass (Wood)", type: .biomass)
let biomassLeaves = Part(name: "Biomass (Leaves)", type: .biomass)
let biomassAlienCarapace = Part(name: "Biomass (Alien Carapace)", type: .biomass)
let biomassAlienOrgans = Part(name: "Biomass (Alien Organs)", type: .biomass)
let biomassMycelia = Part(name: "Biomass (Mycelia)", type: .biomass)
let solidBiofuel = Part(name: "Solid Biofuel", type: .biomass)
let fabric = Part(name: "Farbic", type: .biomass)

// MARK: - Power Shards
let powerShard = Part(name: "Power Shard", type: .powerShards)
let powerShard1 = Part(name: "Power Shard (1)", type: .powerShards)
let powerShard2 = Part(name: "Power Shard (2)", type: .powerShards)
let powerShard5 = Part(name: "Power Shard (5)", type: .powerShards)

// MARK: - Industrial Parts
let rotor = Part(name: "Rotor", type: .industrialParts)
let stator = Part(name: "Stator", type: .industrialParts)
let motor = Part(name: "Motor", type: .industrialParts)

// MARK: - Consumed
let blackPowder = Part(name: "Black Powder", type: .consumed)
let colorCartridge = Part(name: "Color Cartridge", type: .consumed)
let nobelisk = Part(name: "Nobelisk", type: .consumed)
let filter = Part(name: "Filter", type: .consumed)

// MARK: - Communications
let crystalOscillator = Part(name: "Crystal Oscillator", type: .communications)
let computer = Part(name: "Computer", type: .communications)

// MARK: - Containers
let emptyCanister = Part(name: "Empty Canister", type: .containers)
let packagedWater = Part(name: "Packaged Water", type: .containers)
let packagedOil = Part(name: "Packaged Oil", type: .containers)
let packagedFuel = Part(name: "Packaged Fuel", type: .containers)
let packagedHeavyOilResidue = Part(name: "Packaged Heavy Oil Residue", type: .containers)
let packagedLiquidBiofuel = Part(name: "Packaged Liquid Biofuel", type: .containers)

// MARK: - Oil Products
let rubber = Part(name: "Rubber", type: .oilProducts)
let plastic = Part(name: "Plastic", type: .oilProducts)
let petroleumCoke = Part(name: "Petroleum Coke", type: .oilProducts)
let polymerResin = Part(name: "Polymer Resin", type: .oilProducts)

// MARK: - Space Elevator Parts
let smartPlating = Part(name: "Smart Plating", type: .spaceElevatorParts)
let versatileFramework = Part(name: "Versatile Framework", type: .spaceElevatorParts)
let automatedWiring = Part(name: "Automated Wiring", type: .spaceElevatorParts)
let modularEngine = Part(name: "Modular Engine", type: .spaceElevatorParts)
let adaptiveControlUnit = Part(name: "AdaptiveControlUnit", type: .spaceElevatorParts)

let parts = [
    ironOre,
    copperOre,
    limestone,
    coal,
    rawQuartz,
    cateriumOre,
    sulfur,
    bauxite,
    uranium,
    
    leaves,
    wood,
    mycelia,
    biomass,
    
    greenPowerSlug,
    yellowPowerSlug,
    purplePowerSlug,
    
    water,
    crudeOil,
    heavyOilResidue,
    fuel,
    liquidBiofuel,
    
    ironIngot,
    copperIngot,
    cateriumIngot,
    steelIngot,
    
    ironPlate,
    ironRod,
    screw,
    reinforcedIronPlate,
    copperSheet,
    modularFrame,
    steelBeam,
    steelPipe,
    encasedIndustrialBeam,
    heavyModularFrame,
    
    wire,
    cable,
    quickWire,
    circuitBoard,
    aiLimiter,
    
    concrete,
    quartzCrystal,
    silica,
    
    biomassWood,
    biomassLeaves,
    biomassAlienCarapace,
    biomassAlienOrgans,
    biomassMycelia,
    solidBiofuel,
    fabric,
    
    powerShard,
    powerShard1,
    powerShard2,
    powerShard5,
    
    rotor,
    stator,
    motor,
    
    blackPowder,
    colorCartridge,
    nobelisk,
    
    crystalOscillator,
    computer,
    
    emptyCanister,
    packagedWater,
    packagedOil,
    packagedFuel,
    packagedHeavyOilResidue,
    packagedLiquidBiofuel,
    
    rubber,
    plastic,
    petroleumCoke,
    
    smartPlating,
    versatileFramework,
    automatedWiring,
    modularEngine,
    adaptiveControlUnit
]
