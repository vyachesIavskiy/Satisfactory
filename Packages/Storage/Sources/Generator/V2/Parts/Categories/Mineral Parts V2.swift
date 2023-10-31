import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .minerals, form: .solid)
    }
}

extension V2.Parts {
    static let concrete = Part(id: "part-concrete")
    static let quartzCrystal = Part(id: "part-quartz-crystal")
    static let silica = Part(id: "part-silica")
    static let aluminumScrap = Part(id: "part-aluminum-scrap")
    static let copperPowder = Part(id: "part-copper-powder")
    
    static let mineralParts = [
        concrete,
        quartzCrystal,
        silica,
        aluminumScrap,
        copperPowder
    ]
}
