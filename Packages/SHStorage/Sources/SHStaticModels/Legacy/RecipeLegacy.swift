import Foundation
import SHModels

extension Recipe.Static {
    public struct Legacy: Decodable {
        public let id: String
        public let name: String
        public let input: [Recipe.Static.Legacy.Ingredient]
        public let output: [Recipe.Static.Legacy.Ingredient]
        public let machines: [String]
        public let duration: Int
        public let isDefault: Bool
        
        public init(
            id: String,
            name: String,
            input: [Recipe.Static.Legacy.Ingredient],
            output: [Recipe.Static.Legacy.Ingredient],
            machines: [String],
            duration: Int,
            isDefault: Bool
        ) {
            self.id = id
            self.name = name
            self.input = input
            self.output = output
            self.machines = machines
            self.duration = duration
            self.isDefault = isDefault
        }
    }
}

extension Recipe.Static.Legacy {
    public struct Ingredient: Decodable {
        public var id: String
        public var amount: Double
        
        public init(id: String, amount: Double) {
            self.id = id
            self.amount = amount
        }
    }
}

