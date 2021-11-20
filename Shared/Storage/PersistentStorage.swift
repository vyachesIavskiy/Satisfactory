import SwiftUI

protocol PersistentStoragable: Codable {
    static var domain: String { get }
    var filename: String { get }
}

protocol PersistentStorageProtocol {
    func save<Model: PersistentStoragable>(_ model: Model) throws
    func load<Model: PersistentStoragable>(_ model: Model.Type) throws -> [Model]
    func delete<Model: PersistentStoragable>(_ model: Model.Type, filename: String) throws
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
    
    func load<Model: PersistentStoragable>(_ model: Model.Type) throws -> [Model] {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        guard fileManager.fileExists(atPath: domainURL.path) else { return [] }
        let filenameURLs = try fileManager.contentsOfDirectory(at: domainURL, includingPropertiesForKeys: nil)
        return try filenameURLs.filter { $0.pathExtension == "json" }.map { url in
            try load(model, url: url)
        }
    }
    
    func loadIfExist<Model: PersistentStoragable>(_ model: Model.Type) throws -> [Model] {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        guard fileManager.fileExists(atPath: domainURL.path) else { return [] }
        let filenameURLs = try fileManager.contentsOfDirectory(at: domainURL, includingPropertiesForKeys: nil)
        return try filenameURLs.filter { $0.pathExtension == "json" }.map { url in
            try load(model, url: url)
        }
    }
    
    func delete<Model: PersistentStoragable>(_ model: Model.Type, filename: String) throws {
        let domainURL = try documentsURL.appendingPathComponent(Model.domain)
        let filenameURL = domainURL.appendingPathComponent("\(filename).json")
        guard fileManager.fileExists(atPath: filenameURL.path) else { return }
        try fileManager.removeItem(at: filenameURL)
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
