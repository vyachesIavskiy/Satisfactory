import SHModels
import SHStaticModels

extension V2.Parts {
    static let nitrogenGas = Part.Static(id: "part-nitrogen-gas", category: .gases, form: .gas, isNaturalResource: true)
    
    static let gasParts = [
        nitrogenGas
    ]
}
