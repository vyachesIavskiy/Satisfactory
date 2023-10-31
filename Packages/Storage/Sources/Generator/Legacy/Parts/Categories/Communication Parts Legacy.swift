import StaticModels

private extension PartLegacy {
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
    static let crystalOscillator = PartLegacy(id: "crystal-oscillator")
    static let computer = PartLegacy(id: "computer")
    static let radioControlUnit = PartLegacy(id: "radio-control-unit")
    static let supercomputer = PartLegacy(id: "supercomputer")
    
    static let communicationParts = [
        crystalOscillator,
        computer,
        radioControlUnit,
        supercomputer
    ]
}
