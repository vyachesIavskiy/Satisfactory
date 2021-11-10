import Foundation

struct Recipe: Encodable {
    let id: String
    let name: String
    let input: [RecipePart]
    let output: [RecipePart]
    let machines: [Building]
    let duration: Int
    let isDefault: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case input
        case output
        case machines
        case duration
        case isDefault
    }
    
    init(name: String, input: [RecipePart], output: [RecipePart], machines: [Building], duration: Int, isDefault: Bool = true) {
        self.id = name.idFromName
        self.name = name
        self.input = input
        self.output = output
        self.machines = machines
        self.duration = duration
        self.isDefault = isDefault
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(input, forKey: .input)
        try container.encode(output, forKey: .output)
        try container.encode(machines.map(\.id), forKey: .machines)
        try container.encode(duration, forKey: .duration)
        try container.encode(isDefault, forKey: .isDefault)
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        let inputs = input.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        let outputs = output.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        return "\(machines.first?.name ?? "Build gun"): [\(inputs) -> \(outputs)]"
    }
}

let Recipes
    = SmelterRecipes
    + FoundryRecipes
    + ConstructorRecipes
    + AssemblerRecipes
    + RefineryRecipes
    + PackagerRecipes
    + ManufacturerRecipes
    + BlenderRecipes
    + ParticleAcceleratorRecipes
    + BuildingRecipes
