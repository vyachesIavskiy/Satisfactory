private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .generators)
    }
}

let biomassBurner = Building(name: "Biomass Burner")
let coalGenerator = Building(name: "Coal Generator")
let fuelGenerator = Building(name: "Fuel Generator")
let geothermalGenerator = Building(name: "Geothermal Generator")
let nuclearPowerPlant = Building(name: "Nuclear Power Plant")
let powerStorage = Building(name: "Power Storage")

let Generators = [
    biomassBurner,
    coalGenerator,
    fuelGenerator,
    geothermalGenerator,
    nuclearPowerPlant,
    powerStorage
]
