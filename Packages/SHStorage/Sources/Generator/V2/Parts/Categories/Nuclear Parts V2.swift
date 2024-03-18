import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .nuclear, form: .solid)
    }
}

extension V2.Parts {
    static let electromagneticControlRod = Part.Static(id: "part-electromagnetic-control-rod")
    static let encasedUraniumCell = Part.Static(id: "part-encased-uranium-cell")
    static let uraniumFuelRod = Part.Static(id: "part-uranium-fuel-rod")
    static let uraniumWaste = Part.Static(id: "part-uranium-waste")
    static let nonFissileUranium = Part.Static(id: "part-non-fissile-uranium")
    static let plutoniumPellet = Part.Static(id: "part-plutonium-pellet")
    static let encasedPlutoniumCell = Part.Static(id: "part-encased-plutonium-cell")
    static let plutoniumFuelRod = Part.Static(id: "part-plutonium-fuel-rod")
    static let plutoniumWaste = Part.Static(id: "part-plutonium-waste")
    
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
