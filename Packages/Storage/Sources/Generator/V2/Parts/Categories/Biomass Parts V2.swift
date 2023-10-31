import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .biomass, form: .solid)
    }
}

extension V2.Parts {
    static let biomass = Part(id: "part-biomass")
    static let solidBiofuel = Part(id: "part-solid-biofuel")
    static let fabric = Part(id: "part-fabric")
    
    static let biomassParts = [
        biomass,
        solidBiofuel,
        fabric
    ]
}
