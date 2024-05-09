import Foundation
import UniformTypeIdentifiers
import SHFileManager

struct Persistence {
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    
    private let homeDirectoryName: String
    private var homeDirectoryURL: URL {
        get throws {
            try _fileManager.url()
                .appending(path: homeDirectoryName)
        }
    }
    
    private let _fileManager = SHFileManager()
    
    init(homeDirectoryName: String = "") {
        self.homeDirectoryName = homeDirectoryName
    }
    
    func canBeLoaded() throws -> Bool {
        try _fileManager.directoryExists(at: homeDirectoryURL)
    }
    
    // MARK: - Load
    
    func loadOne<D: Decodable>(_ modelType: D.Type, fromFile fileName: String) throws -> D {
        let fileURL = try fileURL(for: fileName)
        return try load(modelType: modelType, from: fileURL)
    }
    
    func loadMany<D: Decodable>(_ modelType: D.Type, fromDirectory directoryName: String) throws -> [D] {
        let directoryURL = try directoryURL(for: directoryName)
        var fileURLs = [URL]()
        
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
    
    func save<E: Encodable>(model: E, to fileName: String) throws {
        let fileURL = try fileURL(for: fileName)
        try save(model: model, to: fileURL)
    }
    
    func save<E: Encodable>(models: [E], to directoryName: String, fileName: (_ model: E) -> String) throws {
        let directoryURL = try directoryURL(for: directoryName)
        if !_fileManager.directoryExists(at: directoryURL) {
            try _fileManager.createDirectory(at: directoryURL)
        }
        
        for model in models {
            let name = fileName(model)
            let fileURL = directoryURL
                .appending(path: name)
                .appendingPathExtension(for: .json)
            try save(model: model, to: fileURL)
        }
    }
    
    func save<E: Encodable & Identifiable>(models: [E], to directoryName: String) throws where E.ID == UUID {
        try save(models: models, to: directoryName, fileName: \.id.uuidString)
    }
    
    // MARK: - URLs
    
    func directoryURL(for relativePath: String) throws -> URL {
        try homeDirectoryURL
            .appending(path: relativePath)
    }
    
    func fileURL(for relativePath: String) throws -> URL {
        try directoryURL(for: relativePath)
            .appendingPathExtension(for: .json)
    }
    
    // MARK: - Create
    
    func createHomeDirectoryIfNeeded() throws {
        if try !_fileManager.directoryExists(at: homeDirectoryURL) {
            try _fileManager.createDirectory(at: homeDirectoryURL)
        }
    }
    
    // MARK: - Remove
    
    func remove() throws {
        try _fileManager.removeDirectory(at: homeDirectoryURL)
    }
}

// MARK: - Private

private extension Persistence {
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
