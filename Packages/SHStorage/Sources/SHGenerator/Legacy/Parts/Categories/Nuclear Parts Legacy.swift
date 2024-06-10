import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.nuclear.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let electromagneticControlRod = Part.Static.Legacy(id: "electromagnetic-control-rod")
    static let encasedUraniumCell = Part.Static.Legacy(id: "encased-uranium-cell")
    static let uraniumFuelRod = Part.Static.Legacy(id: "uranium-fuel-rod")
    static let uraniumWaste = Part.Static.Legacy(id: "uranium-waste")
    static let nonFissileUranium = Part.Static.Legacy(id: "non-fissile-uranium")
    static let plutoniumPellet = Part.Static.Legacy(id: "plutonium-pellet")
    static let encasedPlutoniumCell = Part.Static.Legacy(id: "encased-plutonium-cell")
    static let plutoniumFuelRod = Part.Static.Legacy(id: "plutonium-fuel-rod")
    static let plutoniumWaste = Part.Static.Legacy(id: "plutonium-waste")
    
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
