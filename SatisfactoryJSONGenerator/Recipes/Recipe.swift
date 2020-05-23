import Foundation

struct Recipe: Codable {
    let id = UUID()
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: Building
    let isDefault: Bool
    
    init(input: [RecipePart], output: [RecipePart], machine: Building, isDefault: Bool = true) {
        self.input = input
        self.output = output
        self.machine = machine
        self.isDefault = isDefault
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(input, forKey: .input)
        try container.encode(output, forKey: .output)
        try container.encode(machine.id, forKey: .machine)
        try container.encode(isDefault, forKey: .isDefault)
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        let inputs = input.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        let outputs = output.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        return "\(machine): [\(inputs) -> \(outputs)]"
    }
}

extension Recipe {
    var requirements: [String: Double] {
        print(input.map { $0.resource.recipes })
        
        
        
        return [:]
    }
}

let Recipes
    = smelterRecipes
    + foundryRecipes
    + constructorRecipes
    + assemblerRecipes
    + manufacturerRecipes
    + refineryRecipes
