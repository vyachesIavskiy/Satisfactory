import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .packaging, form: .solid)
    }
}

extension V2.Parts {
    static let packagedWater = Part.Static(id: "part-packaged-water")
    static let packagedOil = Part.Static(id: "part-packaged-oil")
    static let packagedHeavyOilResidue = Part.Static(id: "part-packaged-heavy-oil-residue")
    static let packagedLiquidBiofuel = Part.Static(id: "part-packaged-liquid-biofuel")
    static let packagedFuel = Part.Static(id: "part-packaged-fuel")
    static let packagedTurbofuel = Part.Static(id: "part-packaged-turbofuel")
    static let packagedRocketFuel = Part.Static(id: "part-packaged-rocket-fuel")
    static let packagedIonizedFuel = Part.Static(id: "part-packaged-ionized-fuel")
    static let packagedAluminaSolution = Part.Static(id: "part-packaged-alumina-solution")
    static let packagedSulfuricAcid = Part.Static(id: "part-packaged-sulfuric-acid")
    static let packagedNitricAcid = Part.Static(id: "part-packaged-nitric-acid")
    static let packagedNitrogenGas = Part.Static(id: "part-packaged-nitrogen-gas")
    
    static let packagingParts = [
        packagedWater,
        packagedOil,
        packagedHeavyOilResidue,
        packagedLiquidBiofuel,
        packagedFuel,
        packagedTurbofuel,
        packagedRocketFuel,
        packagedIonizedFuel,
        packagedAluminaSolution,
        packagedSulfuricAcid,
        packagedNitricAcid,
        packagedNitrogenGas
    ]
}
