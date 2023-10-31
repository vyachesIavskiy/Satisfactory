import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.aliens.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: true
        )
    }
}

extension Legacy.Parts {
    static let hogRemains = PartLegacy(id: "hog-remains")
    static let plasmaSpitterRemains = PartLegacy(id: "plasma-spitter-remains")
    static let stingerRemains = PartLegacy(id: "stinger-remains")
    static let hatcherRemains = PartLegacy(id: "hatcher-remains")
    static let alienProtein = PartLegacy(id: "alien-protein")
    static let alienDNACapsule = PartLegacy(id: "alien-dna-capsule")
    
    static let alienParts = [
        hogRemains,
        plasmaSpitterRemains,
        stingerRemains,
        hatcherRemains,
        alienProtein,
        alienDNACapsule
    ]
}
