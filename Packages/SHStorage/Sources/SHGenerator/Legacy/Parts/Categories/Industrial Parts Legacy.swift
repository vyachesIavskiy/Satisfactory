import Models
import StaticModels

private extension Part.Static.Legacy {
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
    static let rotor = Part.Static.Legacy(id: "rotor")
    static let stator = Part.Static.Legacy(id: "stator")
    static let motor = Part.Static.Legacy(id: "motor")
    static let heatSink = Part.Static.Legacy(id: "heat-sink")
    static let coolingSystem = Part.Static.Legacy(id: "cooling-system")
    static let fusedModularFrame = Part.Static.Legacy(id: "fused-modular-frame")
    static let battery = Part.Static.Legacy(id: "battery")
    static let turboMotor = Part.Static.Legacy(id: "turbo-motor")
    
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
