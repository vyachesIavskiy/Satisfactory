import SHModels
import SHStaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.gases.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let nitrogenGas = Part.Static.Legacy(id: "nitrogen-gas")
    
    static let gasParts = [
        nitrogenGas
    ]
}
