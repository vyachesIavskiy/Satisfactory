import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .aliens, form: .solid, isNaturalResource: true)
    }
}

extension V2.Parts {
    static let hogRemains = Part(id: "part-hog-remains")
    static let plasmaSpitterRemains = Part(id: "part-plasma-spitter-remains")
    static let stingerRemains = Part(id: "part-stinger-remains")
    static let hatcherRemains = Part(id: "part-hatcher-remains")
    static let alienProtein = Part(id: "part-alien-protein")
    static let alienDNACapsule = Part(id: "part-alien-dna-capsule")
    
    static let alienParts = [
        hogRemains,
        plasmaSpitterRemains,
        stingerRemains,
        hatcherRemains,
        alienProtein,
        alienDNACapsule
    ]
}
