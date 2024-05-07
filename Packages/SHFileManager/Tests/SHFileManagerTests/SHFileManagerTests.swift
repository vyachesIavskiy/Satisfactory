import XCTest
@testable import SHFileManager

final class SHFileManagerTests: XCTestCase {
    private let fileManager = SHFileManager()
    
    override func setUp() async throws {
        fileManager.loggerLevel = .debug
    }
    
    func testDocumentsDirectoryCanBeFound() async throws {
        let url = try fileManager.url()
        XCTAssertFalse(url.pathComponents.isEmpty)
    }
    
    func testContentsOfDirectory() async throws {
        let url = try fileManager.url()
        let fileURL = url.appending(path: "Test.json")
        fileManager.createFile(at: fileURL)
        try XCTAssertFalse(fileManager.contentsOfDirectory(at: url).isEmpty)
        
        try fileManager.removeFile(at: fileURL)
    }
    
    func testCreateDirectory() async throws {
        let directoryURL = try fileManager.url().appending(path: "Test")
        try fileManager.createDirectory(at: directoryURL)
        XCTAssertTrue(fileManager.directoryExists(at: directoryURL))
        
        try fileManager.removeDirectory(at: directoryURL)
    }
    
    func testCreateFile() async throws {
        let fileURL = try fileManager.url().appending(path: "Test.json")
        fileManager.createFile(at: fileURL)
        XCTAssertTrue(fileManager.fileExists(at: fileURL))
        
        try fileManager.removeFile(at: fileURL)
    }
    
    func testDirectoryFullCycle() async throws {
        let directoryURL = try fileManager.url().appending(path: "Test")
        if !fileManager.directoryExists(at: directoryURL) {
            try fileManager.createDirectory(at: directoryURL)
        }
        try fileManager.removeDirectory(at: directoryURL)
        XCTAssertFalse(fileManager.directoryExists(at: directoryURL))
    }
    
    func testFileFullCycle() async throws {
        let fileURL = try fileManager.url().appending(path: "Test.json")
        if !fileManager.fileExists(at: fileURL) {
            fileManager.createFile(at: fileURL)
        }
        try fileManager.removeFile(at: fileURL)
        XCTAssertFalse(fileManager.fileExists(at: fileURL))
    }
}
