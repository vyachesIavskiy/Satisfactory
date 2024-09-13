import Foundation
import SHModels

extension Recipe.Static {
    package struct Legacy: Decodable {
        package let id: String
        package let output: [Recipe.Static.Legacy.Ingredient]
        package let input: [Recipe.Static.Legacy.Ingredient]
        
        package init(
            id: String,
            output: [Recipe.Static.Legacy.Ingredient],
            input: [Recipe.Static.Legacy.Ingredient]
        ) {
            self.id = id
            self.input = input
            self.output = output
        }
    }
}

extension Recipe.Static.Legacy {
    package struct Ingredient: Decodable {
        package var id: String
        
        package init(id: String) {
            self.id = id
        }
    }
}

