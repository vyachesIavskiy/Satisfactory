import SHModels
import SHStaticModels

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
