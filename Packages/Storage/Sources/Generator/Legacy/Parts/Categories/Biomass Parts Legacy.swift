import StaticModels

private extension PartLegacy {
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
    static let biomass = PartLegacy(id: "biomass")
    static let solidBiofuel = PartLegacy(id: "solid-biofuel")
    static let fabric = PartLegacy(id: "fabric")
    
    static let biomassParts = [
        biomass,
        solidBiofuel,
        fabric
    ]
}
