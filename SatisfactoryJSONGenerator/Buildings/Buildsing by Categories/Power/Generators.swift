private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .generators)
    }
}

let biomassGenerator = Building(name: "Biomass Generator")
let coalGenerator = Building(name: "Coal Generator")
let fuelGenerator = Building(name: "Fuel Generator")
let geothermalGenerator = Building(name: "Geothermal Generator")
let nuclearPowerGenerator = Building(name: "Nuclear Power Generator")
let powerStorage = Building(name: "Power Storage")

let Generators = [
    biomassGenerator,
    coalGenerator,
    fuelGenerator,
    geothermalGenerator,
    nuclearPowerGenerator,
    powerStorage
]
