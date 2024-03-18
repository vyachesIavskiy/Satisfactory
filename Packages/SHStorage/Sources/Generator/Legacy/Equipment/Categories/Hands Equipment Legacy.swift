import Models
import StaticModels

private extension Equipment.Static.Legacy {
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
    static let portableMiner = Equipment.Static.Legacy(id: "equipment-portable-miner", name: "Portable Miner")
    static let beacon = Equipment.Static.Legacy(id: "equipment-beacon", name: "Beacon")
}
