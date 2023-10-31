import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .nuclear, form: .solid)
    }
}

extension V2.Parts {
    static let electromagneticControlRod = Part(id: "part-electromagnetic-control-rod")
    static let encasedUraniumCell = Part(id: "part-encased-uranium-cell")
    static let uraniumFuelRod = Part(id: "part-uranium-fuel-rod")
    static let uraniumWaste = Part(id: "part-uranium-waste")
    static let nonFissileUranium = Part(id: "part-non-fissile-uranium")
    static let plutoniumPellet = Part(id: "part-plutonium-pellet")
    static let encasedPlutoniumCell = Part(id: "part-encased-plutonium-cell")
    static let plutoniumFuelRod = Part(id: "part-plutonium-fuel-rod")
    static let plutoniumWaste = Part(id: "part-plutonium-waste")
    
    static let nuclearParts = [
        electromagneticControlRod,
        encasedUraniumCell,
        uraniumFuelRod,
        uraniumWaste,
        nonFissileUranium,
        plutoniumPellet,
        encasedPlutoniumCell,
        plutoniumFuelRod,
        plutoniumWaste
    ]
}
