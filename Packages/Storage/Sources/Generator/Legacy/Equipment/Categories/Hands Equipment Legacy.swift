import StaticModels

private extension EquipmentLegacy {
    init(id: String, name: String) {
        self.init(
            id: id,
            name: id,
            slot: "Hands",
            ammo: nil,
            fuel: nil,
            consumes: nil
        )
    }
}

extension Legacy.Equipment {
    static let portableMiner = EquipmentLegacy(id: "equipment-portable-miner", name: "Portable Miner")
    static let beacon = EquipmentLegacy(id: "equipment-beacon", name: "Beacon")
}
