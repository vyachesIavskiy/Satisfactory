import Models
import StaticModels

private extension Part.Static {
    init(id: String, isNaturalResource: Bool = false) {
        self.init(id: id, category: .fluids, form: .fluid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let water = Part.Static(id: "part-water", isNaturalResource: true)
    static let crudeOil = Part.Static(id: "part-crude-oil", isNaturalResource: true)
    static let heavyOilResidue = Part.Static(id: "part-heavy-oil-residue")
    static let fuel = Part.Static(id: "part-fuel")
    static let liquidBiofuel = Part.Static(id: "part-liquid-biofuel")
    static let turbofuel = Part.Static(id: "part-turbofuel")
    static let aluminaSolution = Part.Static(id: "part-alumina-solution")
    static let sulfuricAcid = Part.Static(id: "part-sulfuric-acid")
    static let nitricAcid = Part.Static(id: "part-nitric-acid")
    
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
