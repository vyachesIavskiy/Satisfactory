import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .communications, form: .solid)
    }
}

extension V2.Parts {
    static let crystalOscillator = Part.Static(id: "part-crystal-oscillator")
    static let computer = Part.Static(id: "part-computer")
    static let radioControlUnit = Part.Static(id: "part-radio-control-unit")
    static let supercomputer = Part.Static(id: "part-supercomputer")
    
    static let communicationParts = [
        crystalOscillator,
        computer,
        radioControlUnit,
        supercomputer
    ]
}
