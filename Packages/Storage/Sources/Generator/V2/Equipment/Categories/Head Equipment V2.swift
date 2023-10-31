import StaticModels

extension V2.Equipment {
    static let gasMask = Equipment(
        id: "equipment-gas-mask",
        category: .head,
        slot: .head,
        consumes: [V2.Parts.gasFilter]
    )
    
    static let headEquipment = [
        gasMask
    ]
}
