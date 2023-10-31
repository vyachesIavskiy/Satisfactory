import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.liquids.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let water = PartLegacy(id: "water")
    static let crudeOil = PartLegacy(id: "crude-oil")
    static let heavyOilResidue = PartLegacy(id: "heavy-oil-residue")
    static let fuel = PartLegacy(id: "fuel")
    static let liquidBiofuel = PartLegacy(id: "liquid-biofuel")
    static let turbofuel = PartLegacy(id: "turbofuel")
    static let aluminaSolution = PartLegacy(id: "alumina-solution")
    static let sulfuricAcid = PartLegacy(id: "sulfuric-acid")
    static let nitricAcid = PartLegacy(id: "nitric-acid")
    
    static let fluidParts = [
        water,
        crudeOil,
        heavyOilResidue,
        fuel,
        liquidBiofuel,
        turbofuel,
        aluminaSolution,
        sulfuricAcid,
        nitricAcid
    ]
}
