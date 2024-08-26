import Foundation
import UniformTypeIdentifiers
import SHFileManager

public struct SHPersistence {
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    
    private let homeDirectoryName: String
    private var homeDirectoryURL: URL {
        _fileManager.url.appending(path: homeDirectoryName)
    }
    
    private let _fileManager = SHFileManager()
    
    public init(homeDirectoryName: String = "") {
        self.homeDirectoryName = homeDirectoryName
    }
    
    public func canBeLoaded() -> Bool {
        _fileManager.directoryExists(at: homeDirectoryURL)
    }
    
    // MARK: - Load
    
    public func loadOne<D: Decodable>(_ modelType: D.Type, fromFile fileName: String) throws -> D {
        let fileURL = fileURL(for: fileName)
        return try load(modelType: modelType, from: fileURL)
    }
    
    public func loadMany<D: Decodable>(_ modelType: D.Type, fromDirectory directoryName: String) throws -> [D] {
        let directoryURL = directoryURL(for: directoryName)
        var fileURLs = [URL]()
        
        guard _fileManager.fileExists(at: directoryURL) else {
            return []
        }
        
        do {
            fileURLs = try _fileManager.contentsOfDirectory(at: directoryURL)
        } catch let error as NSError {
            guard error.code == NSFileReadNoSuchFileError else {
                throw error
            }
        }
        
        return try fileURLs.map { url in
            try load(modelType: modelType, from: url)
        }
    }
    
    // MARK: - Save
    
    public func save<E: Encodable>(_ model: E, toFile fileName: String) throws {
        try createHomeDirectoryIfNeeded()
        
        let fileURL = fileURL(for: fileName)
        try save(model: model, to: fileURL)
    }
    
    public func save<E: Encodable>(_ model: E, toDirectory directoryName: String, fileName: String) throws {
        let directoryURL = directoryURL(for: directoryName)
        if !_fileManager.directoryExists(at: directoryURL) {
            try _fileManager.createDirectory(at: directoryURL)
        }
        
        let fileURL = directoryURL
            .appending(path: fileName)
            .appendingPathExtension(for: .json)
        try save(model: model, to: fileURL)
    }
    
    public func save<E: Encodable & Identifiable>(_ model: E, toDirectory directoryName: String) throws where E.ID == UUID {
        try save(model, toDirectory: directoryName, fileName: model.id.uuidString)
    }
    
    public func save<E: Encodable>(_ models: [E], toDirectory directoryName: String, fileName: (_ model: E) -> String) throws {
        for model in models {
            try save(model, toDirectory: directoryName, fileName: fileName(model))
        }
    }
    
    public func save<E: Encodable & Identifiable>(_ models: [E], toDirectory directoryName: String) throws where E.ID == UUID {
        try save(models, toDirectory: directoryName, fileName: \.id.uuidString)
    }
    
    // MARK: Delete
    
    public func delete<E: Encodable>(_ model: E, fromDirectory directoryName: String, filename: String) throws {
        let directoryURL = directoryURL(for: directoryName)
        
        guard _fileManager.directoryExists(at: directoryURL) else { return }
        
        let fileURL = directoryURL
            .appending(path: filename)
            .appendingPathExtension(for: .json)
        
        try _fileManager.removeFile(at: fileURL)
    }
    
    public func delete<Model: Encodable & Identifiable>(_ model: Model, fromDirectory directoryName: String) throws where Model.ID == UUID {
        try delete(model, fromDirectory: directoryName, filename: model.id.uuidString)
    }
    
    // MARK: - URLs
    
    public func directoryURL(for relativePath: String) -> URL {
        homeDirectoryURL.appending(path: relativePath)
    }
    
    public func fileURL(for relativePath: String) -> URL {
        directoryURL(for: relativePath).appendingPathExtension(for: .json)
    }
    
    // MARK: - Create
    
    public func createHomeDirectoryIfNeeded() throws {
        if !_fileManager.directoryExists(at: homeDirectoryURL) {
            try _fileManager.createDirectory(at: homeDirectoryURL)
        }
    }
    
    // MARK: - Remove
    
    public func remove() throws {
        guard canBeLoaded() else { return }
        
        try _fileManager.removeDirectory(at: homeDirectoryURL)
    }
}

// MARK: - Private

private extension SHPersistence {
    func load<D: Decodable>(modelType: D.Type, from url: URL) throws -> D {
        let data = try Data(contentsOf: url)
        let model = try jsonDecoder.decode(modelType.self, from: data)
        return model
    }
    
    func save<E: Encodable>(model: E, to url: URL) throws {
        let data = try jsonEncoder.encode(model)
        try data.write(to: url)
    }
}
