import SHModels
import SHStaticModels

extension Legacy.Parts {
    static let water = Part.Static.Legacy(id: "water")
    static let crudeOil = Part.Static.Legacy(id: "crude-oil")
    static let heavyOilResidue = Part.Static.Legacy(id: "heavy-oil-residue")
    static let fuel = Part.Static.Legacy(id: "fuel")
    static let liquidBiofuel = Part.Static.Legacy(id: "liquid-biofuel")
    static let turbofuel = Part.Static.Legacy(id: "turbofuel")
    static let aluminaSolution = Part.Static.Legacy(id: "alumina-solution")
    static let sulfuricAcid = Part.Static.Legacy(id: "sulfuric-acid")
    static let nitricAcid = Part.Static.Legacy(id: "nitric-acid")
    
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
