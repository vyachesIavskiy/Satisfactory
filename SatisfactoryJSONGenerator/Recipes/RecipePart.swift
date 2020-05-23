import Foundation

struct RecipePart: Codable {
    let id: UUID
    let amount: Double
    
    var name: String {
        resource.name
    }
    
    var resource: Resource {
        if let part = parts.first(where: { $0.id == id }) {
            return part
        }
        
        if let equipment = equipment.first(where: { $0.id == id }) {
            return equipment
        }
        
        fatalError("Resource with \(id) is not found")
    }
}
