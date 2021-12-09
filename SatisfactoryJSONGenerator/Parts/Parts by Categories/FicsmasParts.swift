private extension Part {
    init(name: String, sortingPriority: Int, rawResource: Bool = false) {
        self.init(name: name, partType: .ficsmas, tier: .tier0, milestone: 0, sortingPriority: sortingPriority, rawResource: rawResource)
    }
}

let ficsmasGift = Part(name: "FICSMAS Gift", sortingPriority: 118, rawResource: true)
let ficsmasTreeBranch = Part(name: "FICSMAS Tree Branch", sortingPriority: 119)
let candyCanePart = Part(name: "Candy Cane", sortingPriority: 120)
let ficsmasBow = Part(name: "FICSMAS Bow", sortingPriority: 121)
let redFicsmasOrnament = Part(name: "Red FICSMAS Ornament", sortingPriority: 122)
let blueFicsmasOrnament = Part(name: "Blue FICSMAS Ornament", sortingPriority: 123)
let actualSnow = Part(name: "Actual Snow", sortingPriority: 124)
let copperFicsmasOrnament = Part(name: "Copper FICSMAS Ornament", sortingPriority: 125)
let ironFicsmasOrnament = Part(name: "Iron FICSMAS Ornament", sortingPriority: 126)
let ficsmasOrnamentBundle = Part(name: "FICSMAS Ornament Bundle", sortingPriority: 127)
let ficsmasDecoration = Part(name: "FICSMAS Decoration", sortingPriority: 128)

let FICSMASParts = [
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
    ficsmasDecoration
]
