import Foundation
import Models
import PersistentModels
import SHLogger
import SHFileManager

extension Storage.Persistent {
    final class Legacy: VersionedPersistentStorage {
        let version = Storage.Persistent.Version.legacy
        
        var parts = [Part.Persistent.Legacy]()
        var equipment = [Equipment.Persistent.Legacy]()
        var recipes = [Recipe.Persistent.Legacy]()
        var productions = [Production.Persistent.Legacy]()
        var settings = Settings.Persistent.Legacy(itemViewStyle: .icon)
        
        private let _fileManager = SHFileManager()
        private let _logger = SHLogger(category: "Persistent.Legacy")
        private let _userDefaults = UserDefaults.standard
        
        private var _url: URL {
            get throws {
                try _fileManager.url()
            }
        }
        
        func canBeLoaded() throws -> Bool {
            // Storage.Persistent.Legacy did not store it's content under a respected folder,
            // so we need to check for 'version.json' file.
            let url = try _url.appendingPathComponent(.version, conformingTo: .json)
            return _fileManager.fileExists(at: url)
        }
        
        func load() throws {
            _logger {
                $0.info("Loading Storage.Persistent.Legacy")
            }
            
            func load<Model: Decodable>(modelType: Model.Type = Model.self, from fileName: String) throws -> Model {
                let url = try _url.appendingPathComponent(fileName, conformingTo: .json)
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let model = try decoder.decode(modelType, from: data)
                return model
            }
            
            parts = try load(modelType: [Part.Persistent.Legacy].self, from: .parts)
            equipment = try load(modelType: [Equipment.Persistent.Legacy].self, from: .equipment)
            recipes = try load(modelType: [Recipe.Persistent.Legacy].self, from: .recipes)
            productions = try load(modelType: [Production.Persistent.Legacy].self, from: .productions)
            
            // Settings are stored in UserDefaults
            let itemViewStyleOldID = _userDefaults.string(forKey: "itemViewStyle")
            
            settings = Settings.Persistent.Legacy(
                itemViewStyle: itemViewStyleOldID == "row" ? .row : .icon
            )
            
            _logger {
                $0.info("Storage.Persistent.Legacy loaded")
            }
        }
        
        func remove() throws {
            _logger {
                $0.info("Removing Storage.Persistent.Legacy")
            }
            
            func remove(_ fileName: String) throws {
                let url = try _fileManager.url().appendingPathComponent(fileName, conformingTo: .json)
                try _fileManager.removeFile(at: url)
            }
            
            try remove(.version)
            try remove(.parts)
            try remove(.equipment)
            try remove(.buildings)
            try remove(.vehicles)
            try remove(.recipes)
            try remove(.productions)
            
            // Settings are stored in UserDefaults
            _userDefaults.removeObject(forKey: "itemViewStyle")
            _userDefaults.removeObject(forKey: "showWithoutRecipes")
            
            _logger {
                $0.info("Storage.Persistent.Legacy removed")
            }
        }
    }
}

private extension String {
    static let version = "version"
    static let parts = "Parts"
    static let equipment = "Equipments"
    static let buildings = "Buildings"
    static let vehicles = "Vehicles"
    static let recipes = "Recipes"
    static let productions = "Productions"
}
