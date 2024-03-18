import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .minerals, form: .solid)
    }
}

extension V2.Parts {
    static let concrete = Part.Static(id: "part-concrete")
    static let quartzCrystal = Part.Static(id: "part-quartz-crystal")
    static let silica = Part.Static(id: "part-silica")
    static let aluminumScrap = Part.Static(id: "part-aluminum-scrap")
    static let copperPowder = Part.Static(id: "part-copper-powder")
    
    static let mineralParts = [
        concrete,
        quartzCrystal,
        silica,
        aluminumScrap,
        copperPowder
    ]
}
