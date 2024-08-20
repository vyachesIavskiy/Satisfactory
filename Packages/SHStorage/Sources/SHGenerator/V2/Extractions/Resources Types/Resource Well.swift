import SHModels
import SHStaticModels

private extension Extraction.Static {
    init(naturalResource: Part.Static) {
        self.init(
            building: V2.Buildings.resourceWellExtractor,
            naturalResources: [naturalResource],
            rates: [
                Extraction.Rate(purity: .impure, amount: 30),
                Extraction.Rate(purity: .normal, amount: 60),
                Extraction.Rate(purity: .pure, amount: 120)
            ]
        )
    }
}

extension V2.Extractions {
    static let nitrogenGas = Extraction.Static(naturalResource: V2.Parts.nitrogenGas)
    static let waterWell = Extraction.Static(naturalResource: V2.Parts.water)
    static let crudeOilWell = Extraction.Static(naturalResource: V2.Parts.crudeOil)
    
    static let resourceWellExtractions = [
        nitrogenGas,
        waterWell,
        crudeOilWell
    ]
}
