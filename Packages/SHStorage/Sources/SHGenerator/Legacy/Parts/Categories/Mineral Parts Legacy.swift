import SHModels
import SHStaticModels

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
