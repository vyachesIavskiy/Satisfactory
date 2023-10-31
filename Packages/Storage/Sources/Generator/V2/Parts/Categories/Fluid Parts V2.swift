import StaticModels

private extension Part {
    init(id: String, isNaturalResource: Bool = false) {
        self.init(id: id, category: .fluids, form: .fluid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let water = Part(id: "part-water", isNaturalResource: true)
    static let crudeOil = Part(id: "part-crude-oil", isNaturalResource: true)
    static let heavyOilResidue = Part(id: "part-heavy-oil-residue")
    static let fuel = Part(id: "part-fuel")
    static let liquidBiofuel = Part(id: "part-liquid-biofuel")
    static let turbofuel = Part(id: "part-turbofuel")
    static let aluminaSolution = Part(id: "part-alumina-solution")
    static let sulfuricAcid = Part(id: "part-sulfuric-acid")
    static let nitricAcid = Part(id: "part-nitric-acid")
    
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
