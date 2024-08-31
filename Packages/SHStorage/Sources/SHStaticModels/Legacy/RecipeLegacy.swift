import Foundation
import SHModels

extension Recipe.Static {
    public struct Legacy: Decodable {
        public let id: String
        public let output: [Recipe.Static.Legacy.Ingredient]
        public let input: [Recipe.Static.Legacy.Ingredient]
        
        public init(
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
    public struct Ingredient: Decodable {
        public var id: String
        
        public init(id: String) {
            self.id = id
        }
    }
}

