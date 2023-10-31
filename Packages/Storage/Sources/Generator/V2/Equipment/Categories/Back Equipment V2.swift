import StaticModels

private extension Equipment {
    init(
        id: String,
        fuel: [StaticModels.Part]? = nil,
        requireElectrecity: Bool = false
    ) {
        self.init(id: id, category: .back, slot: .back, fuel: fuel, requireElectricity: requireElectrecity)
    }
}

extension V2.Equipment {
    static let parachute = Equipment(id: "equipment-parachute")
    static let jetpack = Equipment(id: "equipment-jetpack", fuel: [
        V2.Parts.solidBiofuel,
        V2.Parts.packagedFuel,
        V2.Parts.packagedLiquidBiofuel,
        V2.Parts.packagedTurbofuel
    ])
    static let hoverPack = Equipment(id: "equipment-hover-pack", requireElectrecity: true)
    
    static let backEquipment = [
        parachute,
        jetpack,
        hoverPack
    ]
}
