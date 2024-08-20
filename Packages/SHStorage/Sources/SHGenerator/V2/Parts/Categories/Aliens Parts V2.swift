import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String, isNaturalResource: Bool = true) {
        self.init(id: id, category: .aliens, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let hogRemains = Part.Static(id: "part-hog-remains")
    static let plasmaSpitterRemains = Part.Static(id: "part-plasma-spitter-remains")
    static let stingerRemains = Part.Static(id: "part-stinger-remains")
    static let hatcherRemains = Part.Static(id: "part-hatcher-remains")
    static let alienProtein = Part.Static(id: "part-alien-protein", isNaturalResource: false)
    static let alienDNACapsule = Part.Static(id: "part-alien-dna-capsule", isNaturalResource: false)
    
    static let alienParts = [
        hogRemains,
        plasmaSpitterRemains,
        stingerRemains,
        hatcherRemains,
        alienProtein,
        alienDNACapsule
    ]
}
