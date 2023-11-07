import Foundation
import UniformTypeIdentifiers
import StorageLogger
import Dependencies

struct Persistence {
    private let fileManagerClient: FileManagerClient
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return encoder
    }()
    private let logger = Logger(category: .persistence)
    
    init(homeDirectoryName: String = "") {
        @Dependency(\.fileManagerClient) var fileManagerClient
        self.fileManagerClient = if homeDirectoryName.isEmpty {
            fileManagerClient.fileManagerFor(directoryName: homeDirectoryName)
        } else {
            fileManagerClient
        }
    }
    
    func canBeLoaded() throws -> Bool {
        try fileManagerClient.homeDirectoryExist()
    }
    
    func remove() throws {
        try fileManagerClient.removeHomeDirectory()
    }
    
    func load<D: Decodable>(modelType: D.Type, from fileName: String) throws -> D {
        logger.debug("Loading \(modelType) from file '\(fileName).json'")
        let url = try fileManagerClient.urlForFile(fileName, .json)
        return try load(modelType: modelType, from: url)
    }
    
    func load<D: Decodable>(modelType: D.Type, from directoryName: String) throws -> [D] {
        logger.debug("Loading \(modelType) from directory '\(directoryName)'")
        let fileURLs = try fileManagerClient.contentsOfDirectoryAt(directoryName)
        return try fileURLs.map { url in
            try load(modelType: modelType, from: url)
        }
    }
    
    func save<E: Encodable>(model: E, to fileName: String) throws {
        logger.debug("Saving \(E.self) to file '\(fileName).json'")
        let url = try fileManagerClient.urlForFile(fileName, .json)
        try save(model: model, to: url)
    }
    
    func save<E: Encodable>(models: [E], to directoryName: String, fileNameAndType: (_ model: E) -> (String, UTType)) throws {
        logger.debug("Saving \(E.self) to directory '\(directoryName)'")
        let directoryURL = try fileManagerClient.urlForDirectory(directoryName)
        for model in models {
            let (name, fileType) = fileNameAndType(model)
            let url = directoryURL.appending(path: name).appendingPathExtension(for: fileType)
            try save(model: model, to: url)
        }
    }
    
    func save<E: Encodable & Identifiable>(models: [E], to directoryName: String) throws where E.ID == UUID {
        try save(models: models, to: directoryName) { ($0.id.uuidString, .json) }
    }
}

private extension Persistence {
    func load<D: Decodable>(modelType: D.Type, from url: URL) throws -> D {
        logger.debug("Loading \(modelType) from url '\(url)'")
        let data = try Data(contentsOf: url)
        let model = try jsonDecoder.decode(modelType.self, from: data)
        return model
    }
    
    func save<E: Encodable>(model: E, to url: URL) throws {
        logger.debug("Saving \(E.self) to url '\(url)'")
        let data = try jsonEncoder.encode(model)
        try data.write(to: url)
    }
}
