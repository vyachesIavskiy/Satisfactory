import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .industrialParts, form: .solid)
    }
}

extension V2.Parts {
    static let rotor = Part.Static(id: "part-rotor")
    static let stator = Part.Static(id: "part-stator")
    static let motor = Part.Static(id: "part-motor")
    static let heatSink = Part.Static(id: "part-heat-sink")
    static let coolingSystem = Part.Static(id: "part-cooling-system")
    static let fusedModularFrame = Part.Static(id: "part-fused-modular-frame")
    static let turboMotor = Part.Static(id: "part-turbo-motor")
    static let battery = Part.Static(id: "part-battery")
    
    static let industrialParts = [
        rotor,
        stator,
        motor,
        heatSink,
        coolingSystem,
        fusedModularFrame,
        turboMotor,
        battery,
    ]
}
