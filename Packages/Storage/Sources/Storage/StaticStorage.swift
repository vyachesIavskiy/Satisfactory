import Foundation
import StaticModels
import StorageLogger
import Dependencies

struct StaticStorageClient {
    var parts: () -> [Part]
    var equipment: () -> [Equipment]
    var buildings: () -> [Building]
    var recipes: () -> [Recipe]
    var migrations: () -> [Migration]
    var load: () throws -> Void
}

extension StaticStorageClient: DependencyKey {
    static let liveValue = live
    static let testValue = failing
    static let previewValue = live
}

extension DependencyValues {
    var staticStorageClient: StaticStorageClient {
        get { self[StaticStorageClient.self] }
        set { self[StaticStorageClient.self] = newValue }
    }
}

extension StaticStorageClient {
    static let live: StaticStorageClient = {
        let live = Live()
        
        return StaticStorageClient(
            parts: { live.parts },
            equipment: { live.equipment },
            buildings: { live.buildings },
            recipes: { live.recipes },
            migrations: { live.migrations },
            load: live.load
        )
    }()
    
    static let failing = StaticStorageClient(
        parts: unimplemented("\(Self.self).parts"),
        equipment: unimplemented("\(Self.self).equipment"),
        buildings: unimplemented("\(Self.self).buildings"),
        recipes: unimplemented("\(Self.self).recipes"),
        migrations: unimplemented("\(Self.self).migrations"),
        load: unimplemented("\(Self.self).load")
    )
}

private extension StaticStorageClient {
    final class Live {
        private(set) var configuration = Configuration(version: 0)
        private(set) var parts = [Part]()
        private(set) var equipment = [Equipment]()
        private(set) var buildings = [Building]()
        private(set) var recipes = [Recipe]()
        private(set) var migrations = [Migration]()
        
        private let logger = Logger(category: .static)
        
        func load() throws {
            logger.log("Start loading StaticStorageClient.Live")
            
            logger.debug("Step 1: Loading 'static configuration'")
            configuration = try load(resourceName: .configuration)
            
            logger.debug("Step 2: Loading 'static parts'")
            parts = try load(resourceName: .parts)
            
            logger.debug("Step 3: Loading 'static equipment'")
            equipment = try load(resourceName: .equipment)
            
            logger.debug("Step 4: Loading 'static buildings'")
            buildings = try load(resourceName: .buildings)
            
            logger.debug("Step 5: Loading 'static recipes'")
            recipes = try load(resourceName: .recipes)
            
            logger.debug("Step 6: Loading 'static migrations'")
            migrations = try load(subdirectory: .migrations)
            
            logger.log("Finished loading StaticStorageClient.Live")
        }
        
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
        
        private func load<Model: Decodable>(resourceName: String) throws -> Model {
            logger.debug("Loading \(Model.self) from resource '\(resourceName)'")
            
            guard let url = Bundle.module.url(forResource: "Resources/\(resourceName)", withExtension: .json) else {
                let error = Error.resourceNotFound(resourceName)
                logger.error("\(error)")
                throw error
            }
            
            return try load(from: url)
        }
        
        private func load<Model: Decodable>(subdirectory: String) throws -> [Model] {
            logger.debug("Loading \([Model].self) from directory '\(subdirectory)'")
            guard let urls = Bundle.module.urls(forResourcesWithExtension: .json, subdirectory: "Resources/\(subdirectory)") else {
                let error = Error.subdirectoryNotFound(subdirectory)
                logger.error("\(error)")
                throw error
            }
            
            return try urls.map(load(from:))
        }
        
        private func load<Model: Decodable>(from url: URL) throws -> Model {
            logger.debug("Loading \(Model.self) from url '\(url.path())'")
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Model.self, from: data)
        }
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
