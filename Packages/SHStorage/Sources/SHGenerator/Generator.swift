import Foundation
import SHLogger
import SHModels
import SHStaticModels

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
                .prefix { $0 != "SHGenerator" }
                .joined(separator: "/")
                .replacingOccurrences(of: "%20", with: "\\ ")

            guard var url = URL(string: "file:///\(path)") else {
                throw Error.cannotResolveURL(fromPath: path)
            }
            
            url.append(path: "SHStaticStorage/Data")
            
            guard try !fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil).isEmpty else {
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
        logger.info("Start generation.")
        
        logger.info("Settings progression indicies for parts.")
        
        var sortedAllParts = [Part.Static]()
        for part in V2.Parts.all {
            var copy = part
            copy.progressionIndex = V2.Parts.all.firstIndex { $0.id == part.id } ?? -1
            sortedAllParts.append(copy)
        }
        
        logger.info("Writing configuration.")
        try write(V2.configuration, to: .configuration)
        
        logger.info("Writing parts.")
        try write(sortedAllParts, to: .parts)
                
        logger.info("Writing buildings.")
        try write(V2.Buildings.all, to: .buildings)
        
        logger.info("Writing recipes.")
        try write(V2.Recipes.all, to: .recipes)
        
        logger.info("Writing extractions.")
        try write(V2.Extractions.all, to: .extractions)
        
        logger.info("Writing migrations.")
        for migration in Migrations.all {
            try write(migration, to: .migrations.appending("Migration \(migration.version)"))
        }
        
        logger.info("Generation finished.")
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
            case .resourcesDirectoryIsNotFound: "'SHStaticStorage/Data' directory cannot be found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .cannotResolveURL(path):
                "A provided path '\(path)' is not a valid URL."
                
            case let .resourcesDirectoryIsNotFound(at: url):
                "Provided URL '\(url.path())' does not point to 'SHStorage/Data' directory. Generator is designed to create files only inside 'SHStorage' module."
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
    static let extractions = "Extractions"
    static let migrations = "Migrations/"
    static let json = "json"
}
