import Foundation

@main
final class Generator {
    private init() {}
    
    static func main() {
        Task {
            do {
                let generator = Self()
                try generator.generateNewData()
            } catch {
                print(error)
            }
        }
    }
}

private extension Generator {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case cannotResolveURL(fromPath: String)
        case cannotFindResourcesDirectory(at: URL)
        
        var debugDescription: String {
            switch self {
            case let .cannotResolveURL(path): "Cannot build URL from provided path '\(path)'"
            case let .cannotFindResourcesDirectory(at: providedURL): "'Storage/Resources' directory is not found at '\(providedURL.path())'. Generator can create files only as a part of Storage package."
            }
        }
    }
    
    static let fileManager = FileManager.default
    static let encoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted/*, .sortedKeys*/]
        return encoder
    }()
    
    static var storagePackageResourcesDirectorURL: URL {
        get throws {
            let path = #file
                .split(separator: "/")
                .prefix { $0 != "Generator" }
                .joined(separator: "/")

            guard var url = URL(string: "file:///\(path)") else {
                throw Error.cannotResolveURL(fromPath: path)
            }
            
            url.append(path: "Storage/Resources")
            
            guard Self.fileManager.fileExists(atPath: url.path()) else {
                throw Error.cannotFindResourcesDirectory(at: url)
            }
            
            return url
        }
    }
    
    func generateNewData() throws {
        try write(V2.configuration, to: .configuration)
        
        try write(V2.Parts.all, to: .parts)
        try write(V2.Equipment.all, to: .equipment)
        try write(V2.Buildings.all, to: .buildings)
        
        try write(V2.Recipes.all, to: .recipes)
        
        try write(Migrations.all, to: .legacyToV2Migration)
    }
    
    func write(_ model: some Encodable, to filename: String) throws {
        let data = try Self.encoder.encode(model)
        let url = try Self.storagePackageResourcesDirectorURL.appending(path: filename).appendingPathExtension(.json)
        try data.write(to: url)
    }
}

private extension String {
    static let configuration = "Configuration"
    static let parts = "Parts"
    static let equipment = "Equipment"
    static let buildings = "Buildings"
    static let recipes = "Recipes"
    static let migrations = "Migrations"
    static let legacyToV2Migration = "\(migrations)/LegacyToV2"
    static let json = "json"
}
