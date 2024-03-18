import Foundation
import Models
import StaticModels
import SHLogger

extension Storage {
    final class Static {
        private(set) var configuration = Configuration(version: 0)
        private(set) var parts = [Part]()
        private(set) var equipment = [Equipment]()
        private(set) var buildings = [Building]()
        private(set) var recipes = [Recipe]()
        private(set) var migrations = [Migration]()
        
        private let _logger = SHLogger(category: "Static")
        private let dataDirectoryName = "Data"
        
        private var loaded = false
        
        func load(onlyData: Bool = false) throws {
            _logger {
                $0.info("'Storage.Static' start loading")
            }
            
            guard !loaded else {
                _logger {
                    $0.info("'Storage.Static' is already loaded. Aborting.")
                }
                return
            }
            
            _logger(scope: .trace) {
                $0.trace("Step 1: Loading 'configuration'")
            }
            configuration = try load(resourceName: .configuration)
            
            _logger(scope: .trace) {
                $0.trace("Step 2: Loading 'parts'")
            }
            let staticParts = try load([Part.Static].self, resourceName: .parts)
            parts = try staticParts.map(Part.init)
            
            _logger(scope: .trace) {
                $0.trace("Step 3: Loading 'buildings'")
            }
            let staticBuildings = try load([Building.Static].self, resourceName: .buildings)
            buildings = try staticBuildings.map(Building.init)
            
            _logger(scope: .trace) {
                $0.trace("Step 4: Loading 'equipment'")
            }
            let staticEquipment = try load([Equipment.Static].self, resourceName: .equipment)
            equipment = try staticEquipment.map { equipment in
                try Equipment(equipment) {
                    try self[partID: $0]
                }
            }
            
            _logger(scope: .trace) {
                $0.trace("Step 5: Loading 'static recipes'")
            }
            let staticRecipes = try load([Recipe.Static].self, resourceName: .recipes)
            recipes = try staticRecipes.map { recipe in
                try Recipe(recipe) { 
                    try self[itemID: $0]
                } buildingProvider: {
                    try self[buildingID: $0]
                }
            }
            
            if !onlyData {
                _logger(scope: .trace) {
                    $0.trace("Step 6: Loading 'migrations'")
                }
                migrations = try load(subdirectory: .migrations)
            }
            
            _logger {
                $0.info("'Storage.Static' finished loading")
            }
            
            loaded = true
        }
    }
}

// MARK: - Subscripts

extension Storage.Static {
    subscript(partID id: String) -> Part? {
        _logger(scope: .trace) {
            $0.trace("Fetching part '\(id)'")
        }
        
        let part = parts.first(id: id)
        
        _logger(scope: .trace) {
            $0.trace("Part '\(id)' \(part == nil ? "is not" : "is") found")
        }
        
        return part
    }
    
    subscript(partID id: String) -> Part {
        get throws {
            guard let part = self[partID: id] else {
                throw Error.invalidPartID(id)
            }
            
            return part
        }
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        _logger(scope: .trace) {
            $0.trace("Fetching equipment '\(id)'")
        }
        
        let equipment = equipment.first(id: id)
        
        _logger(scope: .trace) {
            $0.trace("Equipment '\(id)' \(equipment == nil ? "is not" : "is") found")
        }
        
        return equipment
    }
    
    subscript(equipmentID id: String) -> Equipment {
        get throws {
            guard let equipment = self[equipmentID: id] else {
                throw Error.invalidEquipmentID(id)
            }
            
            return equipment
        }
    }
    
    subscript(buildingID id: String) -> Building? {
        _logger(scope: .trace) {
            $0.trace("Fetching building '\(id)'")
        }
        
        let building = buildings.first(id: id)
        
        _logger(scope: .trace) {
            $0.trace("Building '\(id)' \(building == nil ? "is not" : "is") found")
        }
        
        return building
    }
    
    subscript(buildingID id: String) -> Building {
        get throws {
            guard let building = self[buildingID: id] else {
                throw Error.invalidBuildingID(id)
            }
            
            return building
        }
    }
    
    subscript(itemID id: String) -> (any Item)? {
        _logger(scope: .trace) {
            $0.trace("Fetching item '\(id)'")
        }
        
        let item: (any Item)? = self[partID: id] ??
        self[equipmentID: id] ??
        self[buildingID: id]
        
        _logger(scope: .trace) {
            $0.trace("Item '\(id)' \(item == nil ? "is not" : "is") found")
        }
        
        return item
    }
    
    subscript(itemID id: String) -> any Item {
        get throws {
            guard let item = self[itemID: id] else {
                throw Error.invalidItemID(id)
            }
            
            return item
        }
    }
    
    subscript(recipeID id: String) -> Recipe? {
        _logger(scope: .trace) {
            $0.trace("Fetching recipe '\(id)'")
        }
        
        let recipe = recipes.first(id: id)
        
        _logger(scope: .trace) {
            $0.trace("Recipe '\(id)' \(recipe == nil ? "is not" : "is") found")
        }
        
        return recipe
    }
    
    subscript(recipeID id: String) -> Recipe {
        get throws {
            guard let recipe = self[recipeID: id] else {
                throw Error.invalidRecipeID(id)
            }
            
            return recipe
        }
    }
    
    subscript(recipesFor item: some Item, role role: Recipe.Ingredient.Role) -> [Recipe] {
        self[recipesFor: item.id, role: role]
    }
    
    subscript(recipesFor itemID: String, role role: Recipe.Ingredient.Role) -> [Recipe] {
        _logger(scope: .trace) {
            $0.trace("Fetching recipes for item '\(itemID)' as '\(role)'")
        }
        
        let recipes = recipes.filter { recipe in
            switch role {
            case .input: recipe.input.reduce(false) { $0 || $1.item.id == itemID }
            case .output: recipe.output.item.id == itemID
            case .byproduct: recipe.byproducts.reduce(false) { $0 || $1.item.id == itemID }
            }
        }
        
        _logger(scope: .trace) {
            $0.trace("Found \(recipes.count) recipes for item '\(itemID)' as '\(role)'")
        }
        
        return recipes
    }
}

// MARK: - Errors

extension Storage.Static {
    private enum LoadingError: Swift.Error, CustomDebugStringConvertible {
        case resourceNotFound(String)
        case subdirectoryNotFound(String)
        
        var debugDescription: String {
            switch self {
            case let .resourceNotFound(resourceName): "Cannot find resource: '\(resourceName).json'"
            case let .subdirectoryNotFound(subdirectory): "Cannot find subdirectory '\(subdirectory)'"
            }
        }
    }
    
    enum Error: Swift.Error {
        case invalidPartID(String)
        case invalidEquipmentID(String)
        case invalidBuildingID(String)
        case invalidItemID(String)
        case invalidRecipeID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidPartID(id): "Part '\(id)' not found"
            case let .invalidEquipmentID(id): "Equipment '\(id)' not found'"
            case let .invalidBuildingID(id): "Building '\(id)' not found"
            case let .invalidItemID(id): "Item '\(id)' not found"
            case let .invalidRecipeID(id): "Recipe '\(id)' not found"
            }
        }
    }
}

// MARK: - Loading

private extension Storage.Static {
    func load<Model: Decodable>(_ modelType: Model.Type = Model.self, resourceName: String) throws -> Model {
        _logger(scope: .trace) {
            $0.trace("Loading '\(Model.self)' from resource '\(resourceName)'")
        }
        
        guard let url = Bundle.module.url(forResource: "\(dataDirectoryName)/\(resourceName)", withExtension: .json) else {
            let error = LoadingError.resourceNotFound(resourceName)
            _logger(scope: .error) {
                $0.error("\(error)")
            }
            throw error
        }
        
        return try load(from: url)
    }
    
    func load<Model: Decodable>(_ modelType: Model.Type = Model.self, subdirectory: String) throws -> [Model] {
        _logger(scope: .trace) {
            $0.trace("Loading '\([Model].self)' from directory '\(subdirectory)'")
        }
        guard let urls = Bundle.module.urls(forResourcesWithExtension: .json, subdirectory: "\(dataDirectoryName)/\(subdirectory)") else {
            let error = LoadingError.subdirectoryNotFound(subdirectory)
            _logger(scope: .error) {
                $0.error("\(error)")
            }
            throw error
        }
        
        return try urls.map(load(from:))
    }
    
    func load<Model: Decodable>(from url: URL) throws -> Model {
        _logger(scope: .trace) {
            $0.trace("Loading '\(Model.self)' from url '\(url.path())'")
        }
        let data = try Foundation.Data(contentsOf: url)
        return try JSONDecoder().decode(Model.self, from: data)
    }
}

private extension String {
    static let configuration = "Configuration"
    static let parts = "Parts"
    static let equipment = "Equipment"
    static let buildings = "Buildings"
    static let recipes = "Recipes"
    static let migrations = "Migrations"
    static let json = "json"
}
