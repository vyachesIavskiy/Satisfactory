import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.industrialParts.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let rotor = PartLegacy(id: "rotor")
    static let stator = PartLegacy(id: "stator")
    static let motor = PartLegacy(id: "motor")
    static let heatSink = PartLegacy(id: "heat-sink")
    static let coolingSystem = PartLegacy(id: "cooling-system")
    static let fusedModularFrame = PartLegacy(id: "fused-modular-frame")
    static let battery = PartLegacy(id: "battery")
    static let turboMotor = PartLegacy(id: "turbo-motor")
    
    static let industrialParts = [
        rotor,
        stator,
        motor,
        heatSink,
        coolingSystem,
        fusedModularFrame,
        battery,
        turboMotor
    ]
}
