import SHModels
import SHStaticModels

private extension Equipment.Static {
    init(
        id: String,
        fuel: [Part.Static]? = nil,
        requireElectrecity: Bool = false
    ) {
        self.init(id: id, category: .back, slot: .back, fuel: fuel, requireElectricity: requireElectrecity)
    }
}

extension V2.Equipment {
    static let parachute = Equipment.Static(id: "equipment-parachute")
    static let jetpack = Equipment.Static(id: "equipment-jetpack", fuel: [
        V2.Parts.solidBiofuel,
        V2.Parts.packagedFuel,
        V2.Parts.packagedLiquidBiofuel,
        V2.Parts.packagedTurbofuel
    ])
    static let hoverPack = Equipment.Static(id: "equipment-hover-pack", requireElectrecity: true)
    
    static let backEquipment = [
        parachute,
        jetpack,
        hoverPack
    ]
}
