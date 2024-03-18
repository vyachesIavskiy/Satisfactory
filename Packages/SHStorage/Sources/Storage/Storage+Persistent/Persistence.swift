import Foundation
import UniformTypeIdentifiers
import SHFileManager
import SHLogger

struct Persistence {
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    
    private let homeDirectoryName: String
    
    private let _fileManager = SHFileManager()
    private let _logger = SHLogger(subsystemName: "Storage", category: "Persistance")
    
    init(homeDirectoryName: String = "") {
        self.homeDirectoryName = homeDirectoryName
    }
    
    func canBeLoaded() throws -> Bool {
        let url = try directoryURL(for: homeDirectoryName)
        return _fileManager.directoryExists(at: url)
    }
    
    // MARK: - Load
    
    func load<D: Decodable>(modelType: D.Type, from fileName: String) throws -> D {
        _logger(scope: .debug) {
            $0.debug("Loading \(modelType) from file '\(fileName).json'")
        }
        
        let fileURL = try fileURL(for: fileName)
        return try load(modelType: modelType, from: fileURL)
    }
    
    func load<D: Decodable>(modelType: D.Type, from directoryName: String) throws -> [D] {
        _logger(scope: .debug) {
            $0.debug("Loading \(modelType) from directory '\(directoryName)'")
        }
        
        let directoryURL = try directoryURL(for: directoryName)
        let fileURLs = try _fileManager.contentsOfDirectory(at: directoryURL)
        return try fileURLs.map { url in
            try load(modelType: modelType, from: url)
        }
    }
    
    // MARK: - Save
    
    func save<E: Encodable>(model: E, to fileName: String) throws {
        _logger(scope: .debug) {
            $0.debug("Saving \(E.self) to file '\(fileName).json'")
        }
        
        let fileURL = try fileURL(for: fileName)
        if !_fileManager.fileExists(at: fileURL) {
            _fileManager.createFile(at: fileURL)
        }
        
        try save(model: model, to: fileURL)
    }
    
    func save<E: Encodable>(models: [E], to directoryName: String, fileName: (_ model: E) -> String) throws {
        _logger(scope: .debug) {
            $0.debug("Saving \(E.self) to directory '\(directoryName)'")
        }
        
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
        try _fileManager.url()
            .appending(path: homeDirectoryName)
            .appending(path: relativePath)
    }
    
    func fileURL(for relativePath: String) throws -> URL {
        try directoryURL(for: relativePath)
            .appendingPathExtension(for: .json)
    }
    
    // MARK: - Create
    
    func createHomeDirectory() throws {
        _logger(scope: .debug) {
            $0.debug("Creating home '\(homeDirectoryName)' directory")
        }
        
        let url = try directoryURL(for: homeDirectoryName)
        try _fileManager.createDirectory(at: url)
    }
    
    // MARK: - Remove
    
    func remove() throws {
        let url = try directoryURL(for: homeDirectoryName)
        try _fileManager.removeDirectory(at: url)
    }
}

// MARK: - Private

private extension Persistence {
    func load<D: Decodable>(modelType: D.Type, from url: URL) throws -> D {
        _logger(scope: .debug) {
            $0.debug("Loading \(modelType) from url '\(url)'")
        }
        
        let data = try Data(contentsOf: url)
        let model = try jsonDecoder.decode(modelType.self, from: data)
        return model
    }
    
    func save<E: Encodable>(model: E, to url: URL) throws {
        _logger(scope: .debug) {
            $0.debug("Saving \(E.self) to url '\(url)'")
        }
        
        let data = try jsonEncoder.encode(model)
        try data.write(to: url)
    }
}
