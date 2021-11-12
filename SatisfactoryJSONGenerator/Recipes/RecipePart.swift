import Foundation

struct RecipePart: Codable {
    let id: String
    let amount: Double
    
    var name: String {
        resource.name
    }
    
    var resource: Item {
        if let part = Parts.first(where: { $0.id == id }) {
            return part
        }
        
        if let equipment = Equipments.first(where: { $0.id == id }) {
            return equipment
        }
        
        if let building = Buildings.first(where: { $0.id == id }) {
            return building
        }
        
        fatalError("Item with \(id) is not found")
    }
    
    init(_ part: Part, amount: Double) {
        id = part.id
        self.amount = amount
    }
    
    init(_ equipment: Equipment, amount: Double) {
        id = equipment.id
        self.amount = amount
    }
    
    init(_ building: Building) {
        id = building.id
        amount = 1
    }
    
    init(_ vehicle: Vehicle) {
        id = vehicle.id
        amount = 1
    }
}
