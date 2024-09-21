import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .containers, form: .solid)
    }
}

extension V2.Parts {
    static let emptyCanister = Part.Static(id: "part-empty-canister")
    static let emptyFluidTank = Part.Static(id: "part-empty-fluid-tank")
    static let pressureConversionCube = Part.Static(id: "part-pressure-conversion-cube")
    
    static let containerParts = [
        emptyCanister,
        emptyFluidTank,
        pressureConversionCube,
    ]
}
