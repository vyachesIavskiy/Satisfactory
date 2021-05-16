import Foundation

struct RecipePart: Codable {
    let id: UUID
    let amount: Double
    
    var name: String {
        resource.name
    }
    
    var resource: Resource {
        if let part = Parts.first(where: { $0.id == id }) {
            return part
        }
        
        if let equipment = Equipments.first(where: { $0.id == id }) {
            return equipment
        }
        
        fatalError("Resource with \(id) is not found")
    }
    
    init(_ part: Part, amount: Double) {
        id = part.id
        self.amount = amount
    }
    
    init(_ equipment: Equipment, amount: Double) {
        id = equipment.id
        self.amount = amount
    }
}
