import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .communications, form: .solid)
    }
}

extension V2.Parts {
    static let crystalOscillator = Part(id: "part-crystal-oscillator")
    static let computer = Part(id: "part-computer")
    static let radioControlUnit = Part(id: "part-radio-control-unit")
    static let supercomputer = Part(id: "part-supercomputer")
    
    static let communicationParts = [
        crystalOscillator,
        computer,
        radioControlUnit,
        supercomputer
    ]
}
