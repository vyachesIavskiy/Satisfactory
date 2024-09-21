import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .quantumTechnology, form: .solid)
    }
}

extension V2.Parts {
    static let timeCrystal = Part.Static(id: "part-time-crystal")
    static let darkMatterCrystal = Part.Static(id: "part-dark-matter-crystal")
    static let superpositionOscillator = Part.Static(id: "part-superposition-oscillator")
    static let neuralQuantumProcessor = Part.Static(id: "part-neural-quantum-processor")
    static let alienPowerMatrix = Part.Static(id: "part-alien-power-matrix")
    
    static let quantumTechnologyParts = [
        timeCrystal,
        darkMatterCrystal,
        superpositionOscillator,
        neuralQuantumProcessor,
        alienPowerMatrix
    ]
}
