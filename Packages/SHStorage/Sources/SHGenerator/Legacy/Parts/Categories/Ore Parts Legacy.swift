import SHModels
import SHStaticModels

extension Legacy.Parts {
    static let ironOre = Part.Static.Legacy(id: "iron-ore")
    static let copperOre = Part.Static.Legacy(id: "copper-ore")
    static let limestone = Part.Static.Legacy(id: "limestone")
    static let coal = Part.Static.Legacy(id: "coal")
    static let cateriumOre = Part.Static.Legacy(id: "caterium-ore")
    static let bauxite = Part.Static.Legacy(id: "bauxite")
    static let rawQuartz = Part.Static.Legacy(id: "raw-quartz")
    static let sulfur = Part.Static.Legacy(id: "sulfur")
    static let uranium = Part.Static.Legacy(id: "uranium")
    
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
