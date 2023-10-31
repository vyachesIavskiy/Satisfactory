import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .powerSlugs, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let bluePowerSlug = Part(id: "part-blue-power-slug")
    static let yellowPowerSlug = Part(id: "part-yellow-power-slug")
    static let purplePowerSlug = Part(id: "part-purple-power-slug")
    
    static let powerSlugParts = [
        bluePowerSlug,
        yellowPowerSlug,
        purplePowerSlug
    ]
}
