import SHModels
import SHStaticModels

extension V2.Equipment {
    static let hazmatSuit = Equipment.Static(
        id: "equipment-hazmat-suit",
        category: .body,
        slot: .body,
        consumes: [V2.Parts.iodineInfusedFilter]
    )
    
    static let bodyEquipment = [
        hazmatSuit
    ]
}