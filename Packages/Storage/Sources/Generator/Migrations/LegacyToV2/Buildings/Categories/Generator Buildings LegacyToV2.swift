
extension LegacyToV2.Buildings {
    static let nuclearPowerPlant = Migration.IDs(old: Legacy.Buildings.nuclearPowerPlant, new: V2.Buildings.nuclearPowerPlant)
    
    static let generatorBuildings = [
        nuclearPowerPlant
    ]
}
