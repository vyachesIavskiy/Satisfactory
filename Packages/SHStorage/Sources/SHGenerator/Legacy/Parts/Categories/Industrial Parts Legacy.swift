import SHModels
import SHStaticModels

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
