import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .quantumTechnology, form: .solid)
    }
}

extension V2.Parts {
    static let quantumComputer = Part(id: "part-quantum-computer")
    static let superpositionOscillator = Part(id: "part-superposition-oscillator")
    
    static let quantumTechnologyParts = [
        quantumComputer,
        superpositionOscillator
    ]
}
