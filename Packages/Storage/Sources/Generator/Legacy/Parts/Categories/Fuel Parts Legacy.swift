import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.fuels.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let leaves = PartLegacy(id: "leaves")
    static let wood = PartLegacy(id: "wood")
    static let mycelia = PartLegacy(id: "mycelia")
    static let flowerPetals = PartLegacy(id: "flower-petals")
    static let compactedCoal = PartLegacy(id: "compacted-coal")
    
    static let fuelParts = [
        leaves,
        wood,
        mycelia,
        flowerPetals,
        compactedCoal
    ]
}
