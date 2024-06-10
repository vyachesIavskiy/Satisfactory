import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.fuels.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let leaves = Part.Static.Legacy(id: "leaves")
    static let wood = Part.Static.Legacy(id: "wood")
    static let mycelia = Part.Static.Legacy(id: "mycelia")
    static let flowerPetals = Part.Static.Legacy(id: "flower-petals")
    static let compactedCoal = Part.Static.Legacy(id: "compacted-coal")
    
    static let fuelParts = [
        leaves,
        wood,
        mycelia,
        flowerPetals,
        compactedCoal
    ]
}
