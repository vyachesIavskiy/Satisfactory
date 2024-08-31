import SHModels
import SHStaticModels

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
