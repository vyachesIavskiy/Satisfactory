import Foundation
import SHLogger

public final class SHFileManager {
    private let _fileManager = FileManager.default
    private var logger = SHLogger(subsystemName: "SHFileManager", category: "SHFileManager", enabled: false)
    
    public init() {}
    
    // MARK: - URLs
    
    public var url: URL {
        URL.documentsDirectory
    }
    
    public func contentsOfDirectory(at url: URL) throws -> [URL] {
        logger.debug("Fetching contents of directory at '\(url)'")
        
        let urls = try _fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        
        logger.debug("Found \(urls.count) urls inside directory '\(url)'")
        
        return urls
    }
    
    // MARK: - Create
    
    public func createDirectory(at url: URL) throws {
        logger.info("Creating directory at '\(url)'")
        
        try _fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }
    
    public func createFile(at url: URL) throws {
        logger.info("Creating file at '\(url)'")
        
        if !_fileManager.createFile(atPath: url.path(), contents: nil) {
            throw Error.failedToCreateFile(at: url)
        }
    }
    
    // MARK: - Existance
    
    public func directoryExists(at url: URL) -> Bool {
        logger.debug("Checking directory existance at '\(url)'")
        
        return _fileManager.fileExists(atPath: url.path())
    }
    
    public func fileExists(at url: URL) -> Bool {
        logger.debug("Checking file existance at '\(url)'")
        
        return _fileManager.fileExists(atPath: url.path())
    }
    
    // MARK: - Remove
    
    public func removeDirectory(at url: URL) throws {
        logger.info("Removing directory at '\(url)'")
        
        try _fileManager.removeItem(at: url)
    }
    
    public func removeFile(at url: URL) throws {
        logger.info("Removing file at '\(url)'")
        
        try _fileManager.removeItem(at: url)
    }
}

extension SHFileManager {
    enum Error: LocalizedError {
        case failedToCreateFile(at: URL)
    }
}
