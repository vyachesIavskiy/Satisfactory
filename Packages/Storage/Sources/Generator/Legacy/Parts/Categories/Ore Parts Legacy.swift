import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.ores.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let ironOre = PartLegacy(id: "iron-ore")
    static let copperOre = PartLegacy(id: "copper-ore")
    static let limestone = PartLegacy(id: "limestone")
    static let coal = PartLegacy(id: "coal")
    static let cateriumOre = PartLegacy(id: "caterium-ore")
    static let bauxite = PartLegacy(id: "bauxite")
    static let rawQuartz = PartLegacy(id: "raw-quartz")
    static let sulfur = PartLegacy(id: "sulfur")
    static let uranium = PartLegacy(id: "uranium")
    
    static let oreParts = [
        ironOre,
        copperOre,
        limestone,
        coal,
        cateriumOre,
        bauxite,
        rawQuartz,
        sulfur,
        uranium
    ]
}
