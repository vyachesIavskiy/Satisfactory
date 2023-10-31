import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .ores, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let ironOre = Part(id: "part-iron-ore")
    static let copperOre = Part(id: "part-copper-ore")
    static let limestone = Part(id: "part-limestone")
    static let coal = Part(id: "part-coal")
    static let cateriumOre = Part(id: "part-caterium-ore")
    static let bauxite = Part(id: "part-bauxite")
    static let rawQuartz = Part(id: "part-raw-quartz")
    static let sulfur = Part(id: "part-sulfur")
    static let uranium = Part(id: "part-uranium")
    static let samOre = Part(id: "part-sam-ore")
    
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
