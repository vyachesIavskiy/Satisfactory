import Foundation
import SHModels

extension Recipe {
    package struct Static: Codable {
        package let id: String
        package let output: Ingredient
        package let byproducts: [Ingredient]?
        package let inputs: [Ingredient]
        package let machineID: String?
        package let duration: Double
        package let powerConsumption: PowerConsumption
        package let isDefault: Bool
        
        package init(
            id: String,
            output: Ingredient,
            byproducts: [Ingredient]?,
            inputs: [Ingredient],
            machineID: String?,
            duration: Double,
            powerConsumption: PowerConsumption,
            isDefault: Bool
        ) {
            self.id = id
            self.output = output
            self.byproducts = byproducts
            self.inputs = inputs
            self.machineID = machineID
            self.duration = duration
            self.powerConsumption = powerConsumption
            self.isDefault = isDefault
        }
    }
    
    package init(
        _ recipe: Recipe.Static,
        partProvider: (_ partID: String) throws -> Part,
        buildingProvider: (_ buildingID: String) throws -> Building
    ) throws {
        try self.init(
            id: recipe.id,
            output: Ingredient(.output, ingredient: recipe.output, partProvider: partProvider),
            byproducts: recipe.byproducts?.map { try Ingredient(.byproduct, ingredient: $0, partProvider: partProvider) } ?? [],
            inputs: recipe.inputs.map { try Ingredient(.input, ingredient: $0, partProvider: partProvider) },
            machine: recipe.machineID.map(buildingProvider),
            duration: recipe.duration,
            powerConsumption: PowerConsumption(
                min: recipe.powerConsumption.min,
                max: recipe.powerConsumption.max
            ),
            isDefault: recipe.isDefault
        )
    }
}

extension Recipe.Static {
    package struct Ingredient: Codable {
        package let partID: String
        package let amount: Double
        
        package init(partID: String, amount: Double) {
            self.partID = partID
            self.amount = amount
        }
    }
}

private extension Recipe.Ingredient {
    init(
        _ role: Recipe.Ingredient.Role,
        ingredient: Recipe.Static.Ingredient,
        partProvider: (_ partID: String) throws -> Part
    ) rethrows {
        try self.init(
            role: role,
            part: partProvider(ingredient.partID),
            amount: ingredient.amount
        )
    }
}

extension Recipe.Static {
    package struct PowerConsumption: Codable {
        package let min: Int
        package let max: Int
        
        package init(min: Int, max: Int) {
            self.min = min
            self.max = max
        }
        
        package init(_ amount: Int) {
            self.init(min: amount, max: amount)
        }
    }
}
