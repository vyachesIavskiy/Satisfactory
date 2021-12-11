import Foundation

struct Vehicle: Item {
    let id: String
    let name: String
    let fuel: [Part]
    var isFavorite: Bool
    
    var imageName: String { "vehicle-\(id)" }
}
