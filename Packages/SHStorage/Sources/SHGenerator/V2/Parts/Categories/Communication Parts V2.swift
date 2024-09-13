import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .communications, form: .solid)
    }
}

extension V2.Parts {
    static let computer = Part.Static(id: "part-computer")
    static let supercomputer = Part.Static(id: "part-supercomputer")
    static let crystalOscillator = Part.Static(id: "part-crystal-oscillator")
    static let radioControlUnit = Part.Static(id: "part-radio-control-unit")
    
    static let communicationParts = [
        computer,
        supercomputer,
        crystalOscillator,
        radioControlUnit,
    ]
}
