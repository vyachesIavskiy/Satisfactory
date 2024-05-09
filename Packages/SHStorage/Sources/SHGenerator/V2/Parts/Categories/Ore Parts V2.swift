import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .ores, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let ironOre = Part.Static(id: "part-iron-ore")
    static let copperOre = Part.Static(id: "part-copper-ore")
    static let limestone = Part.Static(id: "part-limestone")
    static let coal = Part.Static(id: "part-coal")
    static let cateriumOre = Part.Static(id: "part-caterium-ore")
    static let bauxite = Part.Static(id: "part-bauxite")
    static let rawQuartz = Part.Static(id: "part-raw-quartz")
    static let sulfur = Part.Static(id: "part-sulfur")
    static let uranium = Part.Static(id: "part-uranium")
    static let samOre = Part.Static(id: "part-sam-ore")
    
    static let oreParts = [
        ironOre,
        copperOre,
        limestone,
        coal,
        cateriumOre,
        bauxite,
        rawQuartz,
        sulfur,
        uranium,
        samOre
    ]
}
