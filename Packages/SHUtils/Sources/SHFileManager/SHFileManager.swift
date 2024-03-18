import Foundation
import SHLogger

public final class SHFileManager {
    public var loggerLevel: SHLogger.Level {
        get { _logger.level }
        set { _logger.level = newValue }
    }
    
    private let _fileManager = FileManager()
    private var _logger = SHLogger(subsystemName: "SHFileManager", category: "SHFileManager")
    
    public init() {}
    
    // MARK: - URLs
    
    public func url(for searchPathDirectory: FileManager.SearchPathDirectory = .documentDirectory) throws -> URL {
        try _fileManager.url(for: searchPathDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    public func contentsOfDirectory(at url: URL) throws -> [URL] {
        _logger(scope: .trace) {
            $0.trace("Fetching contents of directory at '\(url)'")
        }
        
        let urls = try _fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        
        _logger(scope: .trace) {
            $0.trace("Found \(urls.count) urls inside directory '\(url)'")
        }
        
        return urls
    }
    
    // MARK: - Create
    
    public func createDirectory(at url: URL) throws {
        _logger(scope: .trace) {
            $0.trace("Creating directory at '\(url)'")
        }
        
        try _fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    public func createFile(at url: URL) {
        _logger(scope: .trace) {
            $0.trace("Creating file at '\(url)'")
        }
        
        _fileManager.createFile(atPath: url.path(), contents: nil)
    }
    
    // MARK: - Existance
    
    public func directoryExists(at url: URL) -> Bool {
        _logger(scope: .trace) {
            $0.trace("Checking directory existance at '\(url)'")
        }
        
        return _fileManager.fileExists(atPath: url.path())
    }
    
    public func fileExists(at url: URL) -> Bool {
        _logger(scope: .trace) {
            $0.trace("Checking file existance at '\(url)'")
        }
        
        return _fileManager.fileExists(atPath: url.path())
    }
    
    // MARK: - Remove
    
    public func removeDirectory(at url: URL) throws {
        _logger(scope: .trace) {
            $0.trace("Removing directory at '\(url)'")
        }
        
        try _fileManager.removeItem(at: url)
    }
    
    public func removeFile(at url: URL) throws {
        _logger(scope: .trace) {
            $0.trace("Removing file at '\(url)'")
        }
        
        try _fileManager.removeItem(at: url)
    }
}
