import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .industrialParts, form: .solid)
    }
}

extension V2.Parts {
    static let rotor = Part(id: "part-rotor")
    static let stator = Part(id: "part-stator")
    static let motor = Part(id: "part-motor")
    static let heatSink = Part(id: "part-heat-sink")
    static let coolingSystem = Part(id: "part-cooling-system")
    static let fusedModularFrame = Part(id: "part-fused-modular-frame")
    static let battery = Part(id: "part-battery")
    static let turboMotor = Part(id: "part-turbo-motor")
    
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
