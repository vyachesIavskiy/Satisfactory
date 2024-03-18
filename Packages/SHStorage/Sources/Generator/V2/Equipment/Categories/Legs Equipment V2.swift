import Models
import StaticModels

extension V2.Equipment {
    static let bladeRunners = Equipment.Static(
        id: "equipment-blade-runners",
        category: .legs,
        slot: .legs
    )
    
    static let legEquipment = [
        bladeRunners
    ]
}
