import Foundation
import SHModels
import SHStaticModels
import SHLogger

public final class SHStaticStorage {
    public private(set) var configuration = Configuration(version: 1)
    public private(set) var parts = [Part]()
    public private(set) var equipment = [Equipment]()
    public private(set) var buildings = [Building]()
    public private(set) var recipes = [Recipe]()
    public private(set) var migrations = [Migration]()
    
    private let logger = SHLogger(subsystemName: "SHStorage", category: "SHStaticStorage")
    private let dataDirectoryName = "Data"
    
    private var loaded = false
    
    public init() {}
    
    public func load() throws {
        logger.info("Loading SHStaticStorage.")
        
        guard !loaded else {
            logger.info("SHStaticStorage is already loaded, skipping.")
            return
        }
        
        // Step 1
        let staticConfiguration = try load(Configuration.Static.self, resourceName: .configuration)
        configuration = Configuration(staticConfiguration)
        
        // Step 2
        let staticParts = try load([Part.Static].self, resourceName: .parts)
        parts = try staticParts.map(Part.init)
        
        // Step 3
        let staticBuildings = try load([Building.Static].self, resourceName: .buildings)
        buildings = try staticBuildings.map(Building.init)
        
        // Step 4
        let staticEquipment = try load([Equipment.Static].self, resourceName: .equipment)
        equipment = try staticEquipment.map { equipment in
            try Equipment(equipment) {
                try self[partID: $0]
            }
        }
        
        // Step 5
        let staticRecipes = try load([Recipe.Static].self, resourceName: .recipes)
        recipes = try staticRecipes.map { recipe in
            try Recipe(recipe) {
                try self[itemID: $0]
            } buildingProvider: {
                try self[buildingID: $0]
            }
        }
        
        // Step 6
        migrations = try load(subdirectory: .migrations)
        
        loaded = true
        
        logger.info("SHStaticStorage is loaded.")
    }
}

// MARK: - Subscripts
package extension SHStaticStorage {
    subscript(partID id: String) -> Part? {
        let part = parts.first(id: id)
        
        if part == nil {
            logger.debug("Part '\(id)' is not found.")
        }
        
        return part
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        let equipment = equipment.first(id: id)
        
        if equipment == nil {
            logger.debug("Equipment '\(id)' is not found.")
        }
        
        return equipment
    }
    
    subscript(buildingID id: String) -> Building? {
        let building = buildings.first(id: id)
        
        if building == nil {
            logger.debug("Building '\(id)' is not found.")
        }
        
        return building
    }
    
    subscript(itemID id: String) -> (any Item)? {
        let item: (any Item)? = parts.first(id: id) ??
        equipment.first(id: id) ??
        buildings.first(id: id)
        
        if item == nil {
            logger.debug("Item '\(id)' is not found.")
        }
        
        return item
    }
    
    subscript(recipeID id: String) -> Recipe? {
        let recipe = recipes.first(id: id)
        
        if recipe == nil {
            logger.debug("Recipe '\(id)' is not found.")
        }
        
        return recipe
    }
    
    subscript(recipesFor item: some Item, role role: Recipe.Ingredient.Role) -> [Recipe] {
        self[recipesFor: item.id, role: role]
    }
    
    subscript(recipesFor itemID: String, role role: Recipe.Ingredient.Role) -> [Recipe] {
        let recipes = recipes.filter { recipe in
            switch role {
            case .output: recipe.output.item.id == itemID
            case .byproduct: recipe.byproducts.reduce(false) { $0 || $1.item.id == itemID }
            case .input: recipe.inputs.reduce(false) { $0 || $1.item.id == itemID }
            }
        }
        
        if recipes.isEmpty {
            logger.debug("No recipes were found for '\(itemID)' as '\(role)'.")
        }
        
        return recipes
    }
}

// MARK: - Throwing subscripts
package extension SHStaticStorage {
    subscript(partID id: String) -> Part {
        get throws {
            guard let part = self[partID: id] else {
                throw Error.invalidPartID(id)
            }
            
            return part
        }
    }
    
    subscript(equipmentID id: String) -> Equipment {
        get throws {
            guard let equipment = self[equipmentID: id] else {
                throw Error.invalidEquipmentID(id)
            }
            
            return equipment
        }
    }
    
    subscript(buildingID id: String) -> Building {
        get throws {
            guard let building = self[buildingID: id] else {
                throw Error.invalidBuildingID(id)
            }
            
            return building
        }
    }
    
    subscript(itemID id: String) -> any Item {
        get throws {
            guard let item = self[itemID: id] else {
                throw Error.invalidItemID(id)
            }
            
            return item
        }
    }
    
    subscript(recipeID id: String) -> Recipe {
        get throws {
            guard let recipe = self[recipeID: id] else {
                throw Error.invalidRecipeID(id)
            }
            
            return recipe
        }
    }
}

// MARK: - Errors
extension SHStaticStorage {
    enum Error: LocalizedError {
        case invalidPartID(String)
        case invalidEquipmentID(String)
        case invalidBuildingID(String)
        case invalidItemID(String)
        case invalidRecipeID(String)
        
        var errorDescription: String? {
            switch self {
            case .invalidPartID: "Part is not found."
            case .invalidEquipmentID: "Equipment is not found."
            case .invalidBuildingID: "Building is not found."
            case .invalidItemID: "Item is not found."
            case .invalidRecipeID: "Recipe is not found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .invalidPartID(id): "There is no part with id '\(id)'."
            case let .invalidEquipmentID(id): "There is no equipment with id '\(id)'."
            case let .invalidBuildingID(id): "There is no building with id '\(id)'."
            case let .invalidItemID(id): "There is no item with id '\(id)'."
            case let .invalidRecipeID(id): "There is no recipe with id '\(id)'."
            }
        }
    }
    
    private enum BundleError: LocalizedError {
        case resourceNotFound(Bundle, String)
        case subdirectoryNotFound(Bundle, String)
        
        var errorDescription: String? {
            switch self {
            case .resourceNotFound: "Resourse is not found."
            case .subdirectoryNotFound: "Subdirectory is not found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .resourceNotFound(bundle, resourceName):
                "Bundle '\(bundle)' does not contain resource '\(resourceName).json'."
                
            case let .subdirectoryNotFound(bundle, subdirectory):
                "Bundle '\(bundle)' does not have subdirectory '\(subdirectory)'."
            }
        }
    }
}

// MARK: - Loading
private extension SHStaticStorage {
    func load<Model: Decodable>(_ modelType: Model.Type = Model.self, resourceName: String) throws -> Model {
        guard let url = Bundle.module.url(forResource: "\(dataDirectoryName)/\(resourceName)", withExtension: .json) else {
            let error = BundleError.resourceNotFound(.module, resourceName)
            throw error
        }
        
        return try load(from: url)
    }
    
    func load<Model: Decodable>(_ modelType: Model.Type = Model.self, subdirectory: String) throws -> [Model] {
        guard let urls = Bundle.module.urls(forResourcesWithExtension: .json, subdirectory: "\(dataDirectoryName)/\(subdirectory)") else {
            let error = BundleError.subdirectoryNotFound(.module, subdirectory)
            logger.error(error)
            throw error
        }
        
        return try urls.map(load(from:))
    }
    
    func load<Model: Decodable>(from url: URL) throws -> Model {
        let data = try Foundation.Data(contentsOf: url)
        return try JSONDecoder().decode(Model.self, from: data)
    }
}

// MARK: - File/Directory names
private extension String {
    static let configuration = "Configuration"
    static let parts = "Parts"
    static let equipment = "Equipment"
    static let buildings = "Buildings"
    static let recipes = "Recipes"
    static let migrations = "Migrations"
    static let json = "json"
}
