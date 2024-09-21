import SHModels
import SHStaticModels

private extension Extraction.Static {
    init(building: Building.Static, rates: [Extraction.Rate]) {
        self.init(
            building: building,
            naturalResources: [
                V2.Parts.ironOre,
                V2.Parts.copperOre,
                V2.Parts.limestone,
                V2.Parts.coal,
                V2.Parts.cateriumOre,
                V2.Parts.bauxite,
                V2.Parts.rawQuartz,
                V2.Parts.sulfur,
                V2.Parts.uranium,
                V2.Parts.sam
            ],
            rates: rates
        )
    }
}

extension V2.Extractions {
    static let minerMK1 = Extraction.Static(building: V2.Buildings.minerMK1, rates: [
        Extraction.Rate(purity: .impure, amount: 30),
        Extraction.Rate(purity: .normal, amount: 60),
        Extraction.Rate(purity: .pure, amount: 120)
    ])
    
    static let minerMK2 = Extraction.Static(building: V2.Buildings.minerMK2, rates: [
        Extraction.Rate(purity: .impure, amount: 60),
        Extraction.Rate(purity: .normal, amount: 120),
        Extraction.Rate(purity: .pure, amount: 240)
    ])
    
    static let minerMK3 = Extraction.Static(building: V2.Buildings.minerMK3, rates: [
        Extraction.Rate(purity: .impure, amount: 120),
        Extraction.Rate(purity: .normal, amount: 240),
        Extraction.Rate(purity: .pure, amount: 480)
    ])
    
    static let minerExtractions = [
        minerMK1,
        minerMK2,
        minerMK3
    ]
}
