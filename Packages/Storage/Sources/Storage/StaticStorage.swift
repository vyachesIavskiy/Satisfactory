import Foundation
import StaticModels

final class StaticStorage {
    private(set) var parts = [Part]()
    private(set) var equipment = [Equipment]()
    private(set) var buildings = [Building]()
    private(set) var recipes = [Recipe]()
    private(set) var migrations = [Migration]()
    
    func load() throws {
        parts = try load(resourceName: .parts)
        equipment = try load(resourceName: .equipment)
        buildings = try load(resourceName: .buildings)
        recipes = try load(resourceName: .recipes)
        migrations = try load(subdirectory: .migrations)
    }
}

private extension StaticStorage {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case resourceNotFound(String)
        case subdirectoryNotFound(String)
        
        var debugDescription: String {
            switch self {
            case let .resourceNotFound(resourceName): "Cannot find resource: '\(resourceName).json'"
            case let .subdirectoryNotFound(subdirectory): "Cannot find subdirectory '\(subdirectory)'"
            }
        }
    }
    
    func load<Model: Decodable>(resourceName: String) throws -> Model {
        guard let url = Bundle.module.url(forResource: resourceName, withExtension: .json) else {
            throw Error.resourceNotFound(resourceName)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Model.self, from: data)
    }
    
    func load<Model: Decodable>(subdirectory: String) throws -> [Model] {
        guard let urls = Bundle.module.urls(forResourcesWithExtension: .json, subdirectory: subdirectory) else {
            throw Error.subdirectoryNotFound(subdirectory)
        }
        
        let models = try urls.map { url in
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Model.self, from: data)
        }
        
        return models
    }
}

private extension String {
    static let parts = "Parts"
    static let equipment = "Equipment"
    static let buildings = "Buildings"
    static let recipes = "Recipes"
    static let migrations = "Migrations"
    static let json = "json"
}
