import Models
import StaticModels

private extension Part.Static {
    init(id: String, isNaturalResource: Bool = true) {
        self.init(id: id, category: .fuels, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let leaves = Part.Static(id: "part-leaves")
    static let wood = Part.Static(id: "part-wood")
    static let mycelia = Part.Static(id: "part-mycelia")
    static let flowerPetals = Part.Static(id: "part-flower-petals")
    static let compactedCoal = Part.Static(id: "part-compacted-coal", isNaturalResource: false)
    
    static let fuelParts = [
        leaves,
        wood,
        mycelia,
        flowerPetals,
        compactedCoal
    ]
}
