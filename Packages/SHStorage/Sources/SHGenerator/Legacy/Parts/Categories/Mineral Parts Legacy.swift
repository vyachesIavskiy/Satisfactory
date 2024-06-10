import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.minerals.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let concrete = Part.Static.Legacy(id: "concrete")
    static let quartzCrystal = Part.Static.Legacy(id: "quartz-crystal")
    static let silica = Part.Static.Legacy(id: "silica")
    static let aluminumScrap = Part.Static.Legacy(id: "aluminum-scrap")
    static let copperPowder = Part.Static.Legacy(id: "copper-powder")
    
    static let mineralParts = [
        concrete,
        quartzCrystal,
        silica,
        aluminumScrap,
        copperPowder
    ]
}
