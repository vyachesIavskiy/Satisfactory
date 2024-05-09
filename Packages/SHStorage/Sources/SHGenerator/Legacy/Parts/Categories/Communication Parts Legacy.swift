import Models
import StaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.communications.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let crystalOscillator = Part.Static.Legacy(id: "crystal-oscillator")
    static let computer = Part.Static.Legacy(id: "computer")
    static let radioControlUnit = Part.Static.Legacy(id: "radio-control-unit")
    static let supercomputer = Part.Static.Legacy(id: "supercomputer")
    
    static let communicationParts = [
        crystalOscillator,
        computer,
        radioControlUnit,
        supercomputer
    ]
}
