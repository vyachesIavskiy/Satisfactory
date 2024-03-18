import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .quantumTechnology, form: .solid)
    }
}

extension V2.Parts {
    static let quantumComputer = Part.Static(id: "part-quantum-computer")
    static let superpositionOscillator = Part.Static(id: "part-superposition-oscillator")
    
    static let quantumTechnologyParts = [
        quantumComputer,
        superpositionOscillator
    ]
}
