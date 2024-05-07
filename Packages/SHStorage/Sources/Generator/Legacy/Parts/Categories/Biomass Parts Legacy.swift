import Models
import StaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.biomass.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let biomass = Part.Static.Legacy(id: "biomass")
    static let solidBiofuel = Part.Static.Legacy(id: "solid-biofuel")
    static let fabric = Part.Static.Legacy(id: "fabric")
    
    static let biomassParts = [
        biomass,
        solidBiofuel,
        fabric
    ]
}
