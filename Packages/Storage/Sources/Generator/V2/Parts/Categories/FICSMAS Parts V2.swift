import StaticModels

private extension Part {
    init(id: String, isNaturalResource: Bool = false) {
        self.init(id: id, category: .ficsmas, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let ficsmasGift = Part(id: "part-ficsmas-gift", isNaturalResource: true)
    static let ficsmasTreeBranch = Part(id: "part-ficsmas-tree-branch")
    static let candyCanePart = Part(id: "part-candy-cane")
    static let ficsmasBow = Part(id: "part-ficsmas-bow")
    static let redFicsmasOrnament = Part(id: "part-red-ficsmas-ornament")
    static let blueFicsmasOrnament = Part(id: "part-blue-ficsmas-ornament")
    static let actualSnow = Part(id: "part-actual-snow")
    static let copperFicsmasOrnament = Part(id: "part-copper-ficsmas-ornament")
    static let ironFicsmasOrnament = Part(id: "part-iron-ficsmas-ornament")
    static let ficsmasOrnamentBundle = Part(id: "part-ficsmas-ornament-bundle")
    static let ficsmasDecoration = Part(id: "part-ficsmas-decoration")
    static let ficsmasWonderStar = Part(id: "part-ficsmas-wonder-star")
    static let snowball = Part(id: "part-snowball")
    static let sweetFireworks = Part(id: "part-sweet-fireworks")
    static let fancyFireworks = Part(id: "part-fancy-fireworks")
    static let sparklyFireworks = Part(id: "part-sparkly-fireworks")
    
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
