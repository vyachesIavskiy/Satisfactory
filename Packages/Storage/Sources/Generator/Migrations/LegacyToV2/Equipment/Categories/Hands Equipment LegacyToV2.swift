
extension LegacyToV2.Equipment {
    static let portableMiner = Migration.IDs(old: Legacy.Equipment.portableMiner, new: V2.Equipment.portableMiner)
    static let beacon = Migration.IDs(old: Legacy.Equipment.beacon, new: V2.Equipment.beacon)
    
    static let handsEquipment = [
        portableMiner,
        beacon
    ]
}
