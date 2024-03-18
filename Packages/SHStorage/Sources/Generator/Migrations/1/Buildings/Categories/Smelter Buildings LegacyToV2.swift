
extension LegacyToV2.Buildings {
    static let smelter = Migration.IDs(old: Legacy.Buildings.smelter, new: V2.Buildings.smelter)
    static let foundry = Migration.IDs(old: Legacy.Buildings.foundry, new: V2.Buildings.foundry)
    
    static let smelterBuildings = [
        smelter,
        foundry
    ]
}
