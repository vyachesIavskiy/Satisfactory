import SHModels
import SHStaticModels

extension Legacy.Parts {
    static let hogRemains = Part.Static.Legacy(id: "hog-remains")
    static let plasmaSpitterRemains = Part.Static.Legacy(id: "plasma-spitter-remains")
    static let stingerRemains = Part.Static.Legacy(id: "stinger-remains")
    static let hatcherRemains = Part.Static.Legacy(id: "hatcher-remains")
    static let alienProtein = Part.Static.Legacy(id: "alien-protein")
    static let alienDNACapsule = Part.Static.Legacy(id: "alien-dna-capsule")
    
    static let alienParts = [
        hogRemains,
        plasmaSpitterRemains,
        stingerRemains,
        hatcherRemains,
        alienProtein,
        alienDNACapsule
    ]
}
