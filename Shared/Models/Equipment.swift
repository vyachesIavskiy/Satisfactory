import Foundation

enum EquipmentSlot: String, Hashable, CaseIterable {
    case hands = "Hands"
    case body = "Body"
}

struct Equipment: Item, Hashable, Identifiable {
    let id: String
    let name: String
    let slot: EquipmentSlot
    let fuel: Part?
    let ammo: Part?
    let consumes: Part?
    var isPinned: Bool
    
    var imageName: String { "equipment-\(id)" }
}
