import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .biomass, form: .solid)
    }
}

extension V2.Parts {
    static let biomass = Part.Static(id: "part-biomass")
    static let solidBiofuel = Part.Static(id: "part-solid-biofuel")
    static let fabric = Part.Static(id: "part-fabric")
    
    static let biomassParts = [
        biomass,
        solidBiofuel,
        fabric
    ]
}
