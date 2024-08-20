import SHModels
import SHStaticModels

extension V2.Extractions {
    static let crudeOil = Extraction.Static(
        building: V2.Buildings.oilExctractor,
        naturalResources: [V2.Parts.crudeOil],
        rates: [
            Extraction.Rate(purity: .impure, amount: 30),
            Extraction.Rate(purity: .normal, amount: 60),
            Extraction.Rate(purity: .pure, amount: 120)
        ]
    )
    
    static let crudeOilExtractions = [crudeOil]
}
