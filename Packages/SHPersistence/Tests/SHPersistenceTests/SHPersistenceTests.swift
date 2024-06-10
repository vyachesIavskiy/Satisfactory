import XCTest
@testable import SHPersistence

final class SHPersistenceTests: XCTestCase {
    let persistence = SHPersistence(homeDirectoryName: "Test")
    
    override func tearDown() async throws {
        try persistence.remove()
    }
    
    func testPersistenceIsEmpty() async throws {
        XCTAssertFalse(persistence.canBeLoaded())
    }
    
    func testCreateHomeDirectory() async throws {
        XCTAssertFalse(persistence.canBeLoaded())
        
        try persistence.createHomeDirectoryIfNeeded()
        
        XCTAssertTrue(persistence.canBeLoaded())
    }
    
    func testSave() async throws {
        let testModel = "Model to save"
        
        try persistence.save(model: testModel, to: "Test")
        
        XCTAssertTrue(persistence.canBeLoaded())
    }
    
    func testLoad() async throws {
        let testModel = "Model to save and load"
        
        try persistence.save(model: testModel, to: "Test")
        let loadedModel = try persistence.loadOne(String.self, fromFile: "Test")
        
        XCTAssertEqual(testModel, loadedModel)
    }
    
    func testLoadMany() async throws {
        let models = [
            "Model 1",
            "Model 2",
            "Model 3"
        ]
        
        try persistence.save(models: models, to: "Tests") { model in
            model
        }
        
        let loadedModels = try persistence.loadMany(String.self, fromDirectory: "Tests")
        
        XCTAssertEqual(models, loadedModels)
    }
    
    func testLoadEmpty() async throws {
        let loadedModels = try persistence.loadMany(String.self, fromDirectory: "Tests")
        
        XCTAssertEqual(loadedModels, [])
    }
}
