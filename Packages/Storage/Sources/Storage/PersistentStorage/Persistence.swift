import Foundation
import UniformTypeIdentifiers

/// A storage handler for a ``VersionedPersistentStorage``
final class _Persistence {
    private let decoder = JSONDecoder()
    
    private let encoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    
    private let fileManager = FileManager.default
    
    private let directoryName: String
    
    private var url: URL {
        get throws {
            try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appending(path: directoryName)
        }
    }
    
    /// Creates a new storage handler for a specified directory name.
    ///
    /// This will work with `<userDocumentsDirectory>`/directoryName
    ///
    /// - Parameter directoryName: A directory name, appending to a user documents directory path.
    init(directoryName: String) {
        self.directoryName = directoryName
    }
}

// MARK: Error
private extension _Persistence {
    private enum Error: Swift.Error {
        case fileDoesNotExist(String)
    }
}

// MARK: URLs
extension _Persistence {
    /// Returns a URL for a requested filename.
    ///
    /// Filename will be resolved agains ``url``.
    /// - Throws: A ``fileDoesNotExist`` error if a file was requested for an unexisted path and `create` parameter is `false`.
    ///
    /// - Parameters:
    ///   - filename: A requested filename. This can be a subpath, e.g. `Directory/File`.
    ///   - create: A boolean flag that indicate if a file should be created.
    ///
    /// - Returns: A URL for requested filename.
    func url(for filename: String, create: Bool = false) throws -> URL {
        let fileURL = try url.appendingPathComponent(filename, conformingTo: .json)
        let filePath = fileURL.path()
        
        let fileExists = fileManager.fileExists(atPath: filePath)
        
        if !fileExists {
            if create {
                fileManager.createFile(atPath: filePath, contents: nil)
            } else {
                throw Error.fileDoesNotExist(filePath)
            }
        }
        
        return fileURL
    }
    
    /// Returns an array of URLs representing content of a reuested directory URL.
    ///
    /// - Note: This function returs only URLs for any `json` file found in the directory. Other files are ignored.
    ///
    /// - Parameter url: A URL representing a requested directory.
    ///
    /// - Returns: An array of URLs representing contents of a requested directory URL.
    func contents(of url: URL) throws -> [URL] {
        try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension == .json }
    }
    
    /// Returns an array of URLs representing content of a reuested directory URL.
    ///
    /// - Note: This function returs only URLs for any `json` file found in the directory. Other files are ignored.
    ///
    /// - Parameter directoryName: A requested directory. This can be a subpath, e.g. `Directory/File`.
    ///
    /// - Returns: An array of URLs representing contents of a requested directory URL.
    func contents(of directoryName: String) throws -> [URL] {
        try contents(of: url.appending(path: directoryName))
    }
    
    func contents() throws -> [URL] {
        try contents(of: url)
    }
}

// MARK: Existence
extension _Persistence {
    func urlExists(_ url: URL) -> Bool {
        fileManager.fileExists(atPath: url.path())
    }
    
    func fileExists(_ filename: String) throws -> Bool {
        try urlExists(url.appendingPathComponent(filename, conformingTo: .json))
    }
    
    func exists() throws -> Bool {
        try urlExists(url)
    }
}

// MARK: Load
extension _Persistence {
    func load<Model: Decodable>(_ modelType: Model.Type, from url: URL) throws -> Model {
        let data = try Data(contentsOf: url)
        return try decoder.decode(modelType, from: data)
    }
    
    func load<Model: Decodable>(_ modelType: Model.Type, fromFileName filename: String, fileType: UTType = .json) throws -> Model {
        try load(modelType, from: url.appendingPathComponent(filename, conformingTo: fileType))
    }
    
    func load<Model: Decodable>(_ modelType: Model.Type, fromDirectory directoryURL: URL) throws -> [Model] {
        try contents(of: directoryURL).map { try load(modelType, from: $0) }
    }
    
    func load<Model: Decodable>(_ modelType: Model.Type, fromDirectoryName directoryName: String) throws -> [Model] {
        try contents(of: directoryName).map { try load(modelType, from: $0) }
    }
}

// MARK: Save
extension _Persistence {
    func save<Model: Encodable>(_ model: Model, to url: URL) throws {
        let data = try encoder.encode(model)
        
        let filePath = url.path()
        if !fileManager.fileExists(atPath: filePath) {
            fileManager.createFile(atPath: filePath, contents: data)
        } else {
            try data.write(to: url)
        }
    }
    
    func save<Model: Encodable>(_ model: Model, toFileName filename: String, fileType: UTType = .json) throws {
        try save(model, to: url.appendingPathComponent(filename, conformingTo: fileType))
    }
    
    func save<Model: Encodable>(_ models: [Model], toDirectory directoryURL: URL, fileName: (Model) -> String) throws {
        if !fileManager.fileExists(atPath: directoryURL.path()) {
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        
        for model in models {
            let filename = fileName(model)
            let fileURL = directoryURL.appendingPathComponent(filename, conformingTo: .json)
            try save(model, to: fileURL)
        }
    }
    
    func save<Model: Encodable>(_ models: [Model], toDirectoryName directoryName: String, fileName: (Model) -> String) throws {
        try save(models, toDirectory: url.appending(path: directoryName), fileName: fileName)
    }
    
    func save<Model: Encodable & Identifiable>(_ models: [Model], toDirectory directoryURL: URL) throws where Model.ID == String {
        try save(models, toDirectory: directoryURL, fileName: \.id)
    }
    
    func save<Model: Encodable & Identifiable>(_ models: [Model], toDirectoryName directoryName: String) throws where Model.ID == String {
        try save(models, toDirectoryName: directoryName, fileName: \.id)
    }
    
    func save<Model: Encodable & Identifiable>(_ models: [Model], toDirectory directoryURL: URL) throws where Model.ID == UUID {
        try save(models, toDirectory: directoryURL, fileName: \.id.uuidString)
    }
    
    func save<Model: Encodable & Identifiable>(_ models: [Model], toDirectoryName directoryName: String) throws where Model.ID == UUID {
        try save(models, toDirectoryName: directoryName, fileName: \.id.uuidString)
    }
}

// MARK: Remove
extension _Persistence {
    func remove(url: URL) throws {
        try fileManager.removeItem(at: url)
    }
    
    func remove(filename: String, fileType: UTType = .json) throws {
        try remove(url: url.appendingPathComponent(filename, conformingTo: fileType))
    }
    
    func remove() throws {
        try remove(url: url)
    }
    
    func remove(urls: [URL]) throws {
        for url in urls {
            try remove(url: url)
        }
    }
    
    func remove(fileNames: [String], fileType: UTType = .json) throws {
        try remove(urls: fileNames.map { try url.appendingPathComponent($0, conformingTo: fileType) })
    }
}

private extension String {
    static let json = "json"
}
