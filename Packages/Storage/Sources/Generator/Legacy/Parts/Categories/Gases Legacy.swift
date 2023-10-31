import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.gases.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let nitrogenGas = PartLegacy(id: "nitrogen-gas")
    
    static let gasParts = [
        nitrogenGas
    ]
}
