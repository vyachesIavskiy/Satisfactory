import Foundation

struct Vehicle: Item {
    let id: String
    let name: String
    
    var recipes: [Recipe] {
        Storage[recipesFor: id]
    }
}
