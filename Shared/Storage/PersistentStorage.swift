import SwiftUI

protocol PersistentStoragable: Codable {
    static var domain: String { get }
    var filename: String { get }
}

protocol PersistentStorageProtocol {
    func save<Model: PersistentStoragable>(_ model: Model) throws
    func load<Model: PersistentStoragable>(_ model: Model.Type) throws -> [Model]
    func load<Model: PersistentStoragable>(_ model: Model.Type, name: String) throws -> Model
}

struct PersistentStorage: PersistentStorageProtocol {
    private let fileManager = FileManager.default
    private let decoder = JSONDecoder()
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    private var documentsURL: URL {
        get throws {
            try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        }
    }
    
    func save<Model: PersistentStoragable>(_ model: Model) throws {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        
        try createDirectoryIfNeeded(domainURL)
        
        let filenameURL = domainURL.appendingPathComponent("\(model.filename).json")
        
        print(filenameURL)
        
        try encoder.encode(model).write(to: filenameURL)
    }
    
    func load<Model: PersistentStoragable>(_ model: Model.Type, name: String) throws -> Model {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        let filenameURL = domainURL.appendingPathComponent("\(name).json")
        return try load(model, url: filenameURL)
    }
    
    func load<Model: PersistentStoragable>(_ model: Model.Type) throws -> [Model] {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        let fileNameURLs = try fileManager.contentsOfDirectory(at: domainURL, includingPropertiesForKeys: nil)
        return try fileNameURLs.filter { $0.pathExtension == "json" }.map { url in
            try load(model, url: url)
        }
    }
    
    private func createDirectoryIfNeeded(_ url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    private func load<Model: PersistentStoragable>(_ model: Model.Type, url: URL) throws -> Model {
        let data = try Data(contentsOf: url)
        return try decoder.decode(model, from: data)
    }
}
