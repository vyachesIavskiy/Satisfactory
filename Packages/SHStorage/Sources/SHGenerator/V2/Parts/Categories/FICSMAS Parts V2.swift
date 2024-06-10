import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String, isNaturalResource: Bool = false) {
        self.init(id: id, category: .ficsmas, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let ficsmasGift = Part.Static(id: "part-ficsmas-gift", isNaturalResource: true)
    static let ficsmasTreeBranch = Part.Static(id: "part-ficsmas-tree-branch")
    static let candyCanePart = Part.Static(id: "part-candy-cane")
    static let ficsmasBow = Part.Static(id: "part-ficsmas-bow")
    static let redFicsmasOrnament = Part.Static(id: "part-red-ficsmas-ornament")
    static let blueFicsmasOrnament = Part.Static(id: "part-blue-ficsmas-ornament")
    static let actualSnow = Part.Static(id: "part-actual-snow")
    static let copperFicsmasOrnament = Part.Static(id: "part-copper-ficsmas-ornament")
    static let ironFicsmasOrnament = Part.Static(id: "part-iron-ficsmas-ornament")
    static let ficsmasOrnamentBundle = Part.Static(id: "part-ficsmas-ornament-bundle")
    static let ficsmasDecoration = Part.Static(id: "part-ficsmas-decoration")
    static let ficsmasWonderStar = Part.Static(id: "part-ficsmas-wonder-star")
    static let snowball = Part.Static(id: "part-snowball")
    static let sweetFireworks = Part.Static(id: "part-sweet-fireworks")
    static let fancyFireworks = Part.Static(id: "part-fancy-fireworks")
    static let sparklyFireworks = Part.Static(id: "part-sparkly-fireworks")
    
    static let ficsmasParts = [
        ficsmasGift,
        ficsmasTreeBranch,
        candyCanePart,
        ficsmasBow,
        redFicsmasOrnament,
        blueFicsmasOrnament,
        actualSnow,
        copperFicsmasOrnament,
        ironFicsmasOrnament,
        ficsmasOrnamentBundle,
        ficsmasDecoration,
        ficsmasWonderStar,
        snowball,
        sweetFireworks,
        fancyFireworks,
        sparklyFireworks
    ]
}
