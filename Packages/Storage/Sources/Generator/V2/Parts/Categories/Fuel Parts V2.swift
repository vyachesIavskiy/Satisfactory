import StaticModels

private extension Part {
    init(id: String, isNaturalResource: Bool = true) {
        self.init(id: id, category: .fuels, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let leaves = Part(id: "part-leaves")
    static let wood = Part(id: "part-wood")
    static let mycelia = Part(id: "part-mycelia")
    static let flowerPetals = Part(id: "part-flower-petals")
    static let compactedCoal = Part(id: "part-compacted-coal", isNaturalResource: false)
    
    static let fuelParts = [
        leaves,
        wood,
        mycelia,
        flowerPetals,
        compactedCoal
    ]
}
