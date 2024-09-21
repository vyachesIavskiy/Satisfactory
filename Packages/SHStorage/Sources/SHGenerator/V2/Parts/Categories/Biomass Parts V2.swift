import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .biomass, form: .solid)
    }
}

extension V2.Parts {
    static let leaves = Part.Static(id: "part-leaves")
    static let wood = Part.Static(id: "part-wood")
    static let mycelia = Part.Static(id: "part-mycelia")
    static let biomass = Part.Static(id: "part-biomass")
    static let fabric = Part.Static(id: "part-fabric")
    static let solidBiofuel = Part.Static(id: "part-solid-biofuel")
    
    static let biomassParts = [
        leaves,
        wood,
        mycelia,
        biomass,
        fabric,
        solidBiofuel,
    ]
}
