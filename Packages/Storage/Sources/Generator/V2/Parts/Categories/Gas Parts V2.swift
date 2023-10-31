import StaticModels

extension V2.Parts {
    static let nitrogenGas = Part(id: "part-nitrogen-gas", category: .gases, form: .gas, isNaturalResource: true)
    
    static let gasParts = [
        nitrogenGas
    ]
}
