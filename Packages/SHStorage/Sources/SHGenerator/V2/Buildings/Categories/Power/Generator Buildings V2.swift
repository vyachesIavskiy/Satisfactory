import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .generators)
    }
}

extension V2.Buildings {
    static let biomassBurner = Building.Static(id: "building-biomass-burner")
    static let coalPoweredGenerator = Building.Static(id: "building-coal-powered-generator")
    static let fuelPoweredGenerator = Building.Static(id: "building-fuel-powered-generator")
    static let geothermalGenerator = Building.Static(id: "building-geothermal-generator")
    static let nuclearPowerPlant = Building.Static(id: "building-nuclear-power-plant")
    static let powerStorage = Building.Static(id: "building-power-storage")
    
    static let generatorBuildings = [
        biomassBurner,
        coalPoweredGenerator,
        fuelPoweredGenerator,
        geothermalGenerator,
        nuclearPowerPlant,
        powerStorage,
    ]
}
