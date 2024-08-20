import SHModels
import SHStaticModels

extension V2.Extractions {
    static let water = Extraction.Static(
        building: V2.Buildings.waterExctractor,
        naturalResources: [V2.Parts.water],
        rates: [
            Extraction.Rate(purity: .normal, amount: 120)
        ]
    )
    
    static let waterExtractions = [water]
}
