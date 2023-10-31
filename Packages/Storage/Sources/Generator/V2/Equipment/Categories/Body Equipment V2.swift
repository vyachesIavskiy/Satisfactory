import StaticModels

extension V2.Equipment {
    static let hazmatSuit = Equipment(
        id: "equipment-hazmat-suit",
        category: .body,
        slot: .body,
        consumes: [V2.Parts.iodineInfusedFilter]
    )
    
    static let bodyEquipment = [
        hazmatSuit
    ]
}
