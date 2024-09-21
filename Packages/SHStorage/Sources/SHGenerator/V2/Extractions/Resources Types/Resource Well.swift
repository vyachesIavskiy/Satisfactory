import SHModels
import SHStaticModels

private extension Extraction.Static {
    init(naturalResources: [Part.Static]) {
        self.init(
            building: V2.Buildings.resourceWellExtractor,
            naturalResources: naturalResources,
            rates: [
                Extraction.Rate(purity: .impure, amount: 30),
                Extraction.Rate(purity: .normal, amount: 60),
                Extraction.Rate(purity: .pure, amount: 120)
            ]
        )
    }
}

extension V2.Extractions {
    static let resourceWell = Extraction.Static(naturalResources: [
        V2.Parts.nitrogenGas,
        V2.Parts.water,
        V2.Parts.crudeOil
    ])
    
    static let resourceWellExtractions = [
        resourceWell,
    ]
}
