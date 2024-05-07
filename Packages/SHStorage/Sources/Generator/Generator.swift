import Foundation
import SHLogger

@main
final class Generator {
    private let logger = SHLogger(subsystemName: "SHStorage", category: "Generator")
    
    private let fileManager = FileManager.default
    private let encoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    
    private var storagePackageResourcesDirectoryURL: URL {
        get throws {
            let path = #filePath
                .split(separator: "/")
                .prefix { $0 != "Generator" }
                .joined(separator: "/")

            guard var url = URL(string: "file:///\(path)") else {
                throw Error.cannotResolveURL(fromPath: path)
            }
            
            url.append(path: "Storage/Data")
            
            guard fileManager.fileExists(atPath: url.path()) else {
                throw Error.resourcesDirectoryIsNotFound(at: url)
            }
            
            return url
        }
    }
    
    private init() {}
    
    static func main() {
        do {
            let generator = Self()
            try generator.generateNewData()
        } catch {
            print(error)
        }
    }
}

private extension Generator {
    func generateNewData() throws {
        logger.info("Start Storage data generation.")
        
        logger.info("Generating configuration.")
        try write(V2.configuration, to: .configuration)
        logger.info("Configuration is generated.")
        
        logger.info("Generating parts.")
        try write(V2.Parts.all, to: .parts)
        logger.info("Parts are generated.")
        
        logger.info("Generating equipment.")
        try write(V2.Equipment.all, to: .equipment)
        logger.info("Equipment are generated.")
        
        logger.info("Generating buildings.")
        try write(V2.Buildings.all, to: .buildings)
        logger.info("Buildings are generated.")
        
        logger.info("Generating recipes.")
        try write(V2.Recipes.all, to: .recipes)
        logger.info("Recipes are generated.")
        
        logger.info("Generating migrations.")
        for migration in Migrations.all {
            logger.info("Generating migration \(migration.version).")
            try write(migration, to: .migrations.appending("Migration \(migration.version)"))
            logger.info("Migration \(migration.version) is generated.")
        }
        logger.info("Migrations are generated.")
        
        logger.info("Storage data generation finished.")
    }
    
    func write(_ model: some Encodable, to filename: String) throws {
        let data = try encoder.encode(model)
        let url = try storagePackageResourcesDirectoryURL.appending(path: filename).appendingPathExtension(.json)
        try data.write(to: url)
    }
}

// MARK: Error
private extension Generator {
    enum Error: LocalizedError {
        case cannotResolveURL(fromPath: String)
        case resourcesDirectoryIsNotFound(at: URL)
        
        var errorDescription: String? {
            switch self {
            case .cannotResolveURL: "URL cannot be resolved."
            case .resourcesDirectoryIsNotFound: "'Storage/Data' directory cannot be found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .cannotResolveURL(path):
                "A provided path '\(path)' is not a valid URL."
                
            case let .resourcesDirectoryIsNotFound(at: url):
                "Provided URL '\(url.path())' does not point to 'Storage/Data' directory. Generator is designed to create files only inside 'Storage' module."
            }
        }
    }
}

private extension String {
    static let configuration = "Configuration"
    static let parts = "Parts"
    static let equipment = "Equipment"
    static let buildings = "Buildings"
    static let recipes = "Recipes"
    static let migrations = "Migrations/"
    static let json = "json"
}
