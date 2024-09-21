import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String, isNaturalResource: Bool = true) {
        self.init(id: id, category: .alienRemains, form: .solid, isNaturalResource: isNaturalResource)
    }
}

extension V2.Parts {
    static let hogRemains = Part.Static(id: "part-hog-remains")
    static let hatcherRemains = Part.Static(id: "part-hatcher-remains")
    static let stingerRemains = Part.Static(id: "part-stinger-remains")
    static let spitterRemains = Part.Static(id: "part-spitter-remains")
    static let alienProtein = Part.Static(id: "part-alien-protein", isNaturalResource: false)
    static let alienDNACapsule = Part.Static(id: "part-alien-dna-capsule", isNaturalResource: false)
    
    static let alienRemainsParts = [
        hogRemains,
        hatcherRemains,
        stingerRemains,
        spitterRemains,
        alienProtein,
        alienDNACapsule
    ]
}
