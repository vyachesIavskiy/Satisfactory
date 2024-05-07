
extension LegacyToV2.Buildings {
    static let craftBench = Migration.IDs(old: Legacy.Buildings.craftBench, new: V2.Buildings.craftBench)
    static let equipmentWorkshop = Migration.IDs(old: Legacy.Buildings.equipmentWorkshop, new: V2.Buildings.equipmentWorkshop)
    
    static let workstationBuildings = [
        craftBench,
        equipmentWorkshop,
    ]
}
