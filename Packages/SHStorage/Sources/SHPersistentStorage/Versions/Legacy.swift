import Foundation
import SHPersistence
import SHFileManager
import SHModels
import SHPersistentModels
import SHLogger

final class Legacy: VersionedStorage {
    let version = Version.legacy
    
    var parts = [Part.Persistent.Legacy]()
    var recipes = [Recipe.Persistent.Legacy]()
    var productions = [SingleItemProduction.Persistent.Legacy]()
    
    private let persistence = SHPersistence()
    private let fileManager = SHFileManager()
    private let logger = SHLogger(subsystemName: "SHStorage", category: "Persistent.Legacy")
    private let userDefaults = UserDefaults.standard
    
    private var _url: URL {
        fileManager.url
    }
    
    func canBeLoaded() -> Bool {
        // Legacy did not store it's content under a respected folder,
        // so we need to check for 'version.json' file.
        let url = _url.appendingPathComponent(.version, conformingTo: .json)
        let result = fileManager.fileExists(at: url)
        logger.info("Legacy \(result ? "can" : "cannot") be loaded.")
        return result
    }
    
    func load() throws {
        logger.info("Loading Legacy storage.")
        
        parts = try persistence.loadMany(Part.Persistent.Legacy.self, fromDirectory: .parts)
        recipes = try persistence.loadMany(Recipe.Persistent.Legacy.self, fromDirectory: .recipes)
        productions = try persistence.loadMany(SingleItemProduction.Persistent.Legacy.self, fromDirectory: .productions)
        
        logger.info("Legacy storage is loaded.")
    }
    
    func remove() throws {
        func remove(file: String) throws {
            let url = fileManager.url.appendingPathComponent(file, conformingTo: .json)
            try fileManager.removeFile(at: url)
        }
        
        func remove(directory: String) throws {
            let url = fileManager.url.appending(component: directory, directoryHint: .isDirectory)
            
            guard fileManager.directoryExists(at: url) else { return }
            try fileManager.removeDirectory(at: url)
        }
        
        logger.info("Removing Legacy storage.")
        
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
        
        logger.info("Legacy storage is removed.")
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
