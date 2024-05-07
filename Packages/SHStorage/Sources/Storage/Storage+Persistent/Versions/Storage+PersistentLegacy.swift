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
        
        private let persistence = Persistence()
        private let fileManager = SHFileManager()
        private let logger = SHLogger(category: "Persistent.Legacy")
        private let userDefaults = UserDefaults.standard
        
        private var _url: URL {
            get throws {
                try fileManager.url()
            }
        }
        
        func canBeLoaded() throws -> Bool {
            // Storage.Persistent.Legacy did not store it's content under a respected folder,
            // so we need to check for 'version.json' file.
            let url = try _url.appendingPathComponent(.version, conformingTo: .json)
            let result = fileManager.fileExists(at: url)
            logger.info("Legacy Persistent storage \(result ? "can" : "cannot") be loaded.")
            return result
        }
        
        func load() throws {
            logger.info("Loading Legacy Persistent storage.")
            
            parts = try persistence.loadMany(Part.Persistent.Legacy.self, fromDirectory: .parts)
            equipment = try persistence.loadMany(Equipment.Persistent.Legacy.self, fromDirectory: .equipment)
            recipes = try persistence.loadMany(Recipe.Persistent.Legacy.self, fromDirectory: .recipes)
            productions = try persistence.loadMany(Production.Persistent.Legacy.self, fromDirectory: .productions)
            
            // Settings are stored in UserDefaults
            let itemViewStyleOldID = userDefaults.string(forKey: "itemViewStyle")
            settings = Settings.Persistent.Legacy(
                itemViewStyle: itemViewStyleOldID == "row" ? .row : .icon
            )
            
            logger.info("Legacy Persistent storage is loaded.")
        }
        
        func remove() throws {
            func remove(file: String) throws {
                let url = try fileManager.url().appendingPathComponent(file, conformingTo: .json)
                try fileManager.removeFile(at: url)
            }
            
            func remove(directory: String) throws {
                let url = try fileManager.url().appending(component: directory, directoryHint: .isDirectory)
                guard fileManager.directoryExists(at: url) else { return }
                try fileManager.removeDirectory(at: url)
            }
            
            logger.info("Removing Legacy Persistent storage.")
            
            try remove(file: .version)
            try remove(directory: .parts)
            try remove(directory: .equipment)
            try remove(directory: .buildings)
            try remove(directory: .vehicles)
            try remove(directory: .recipes)
            try remove(directory: .productions)
            
            // Settings are stored in UserDefaults
            userDefaults.removeObject(forKey: "itemViewStyle")
            userDefaults.removeObject(forKey: "showWithoutRecipes")
            
            logger.info("Legacy Persistent storage is removed.")
        }
    }
}

// MARK: - File/Directory name
private extension String {
    static let version = "version"
    static let parts = "Parts"
    static let equipment = "Equipments"
    static let buildings = "Buildings"
    static let vehicles = "Vehicles"
    static let recipes = "Recipes"
    static let productions = "Productions"
}
