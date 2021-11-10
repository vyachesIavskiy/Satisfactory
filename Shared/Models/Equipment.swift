import Foundation

enum EquipmentType: String, Hashable, CaseIterable {
    case hands = "Hands"
    case body = "Body"
}

struct Equipment: Item, Hashable, Identifiable {
    let id: String
    let name: String
    let equipmentType: EquipmentType
    let fuel: String?
    let ammo: String?
    
    var recipes: [Recipe] { Storage.shared[recipesFor: id] }
}
