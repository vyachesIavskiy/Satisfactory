import StaticModels

private extension PartLegacy {
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
    static let electromagneticControlRod = PartLegacy(id: "electromagnetic-control-rod")
    static let encasedUraniumCell = PartLegacy(id: "encased-uranium-cell")
    static let uraniumFuelRod = PartLegacy(id: "uranium-fuel-rod")
    static let uraniumWaste = PartLegacy(id: "uranium-waste")
    static let nonFissileUranium = PartLegacy(id: "non-fissile-uranium")
    static let plutoniumPellet = PartLegacy(id: "plutonium-pellet")
    static let encasedPlutoniumCell = PartLegacy(id: "encased-plutonium-cell")
    static let plutoniumFuelRod = PartLegacy(id: "plutonium-fuel-rod")
    static let plutoniumWaste = PartLegacy(id: "plutonium-waste")
    
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
