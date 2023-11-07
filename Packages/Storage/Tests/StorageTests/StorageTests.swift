import XCTest
import PersistentModels
import Dependencies

@testable import Storage

final class StorageTests: XCTestCase {
    func testLoadEmptyStorage() async throws {
        try withDependencies {
            $0.fileManagerClient = .noop
            $0.staticStorageClient = .live
            $0.persistentStorageLegacyClient = .inMemory()
            $0.persistentStorageV2Client = .inMemory()
        } operation: {
            let storage = Storage()
            
            XCTAssertNoThrow(try storage.load())
            XCTAssertTrue(storage.pins.partIDs.isEmpty)
            XCTAssertTrue(storage.pins.equipmentIDs.isEmpty)
            XCTAssertTrue(storage.pins.recipeIDs.isEmpty)
        }
    }
    
    func testLoadV2Storage() async throws {
        try withDependencies {
            $0.fileManagerClient = .noop
            $0.staticStorageClient = .live
            $0.persistentStorageLegacyClient = .inMemory()
            $0.persistentStorageV2Client = .inMemory(
                configuration: PersistentConfigurationV2(version: 1),
                pins: PersistentPinsV2(partIDs: [
                    "part-iron-plate"
                ]),
                productions: [],
                factories: []
            )
        } operation: {
            let storage = Storage()
            
            XCTAssertNoThrow(try storage.load())
            
            XCTAssertTrue(storage.pins.partIDs.count == 1)
            XCTAssertEqual(storage.pins.partIDs, Set(["part-iron-plate"]))
            XCTAssertTrue(storage.pins.equipmentIDs.isEmpty)
            XCTAssertTrue(storage.pins.recipeIDs.isEmpty)
        }
    }
    
    func testLoadV2StorageWithMigration() async throws {
        try withDependencies {
            $0.fileManagerClient = .noop
            $0.staticStorageClient = .live
            $0.persistentStorageLegacyClient = .inMemory(
                parts: [
                    PersistentPartLegacy(id: "iron-plate", isPinned: true)
                ],
                equipment: [],
                recipes: [],
                productions: []
            )
            $0.persistentStorageV2Client = .inMemory()
        } operation: {
            let storage = Storage()
            
            XCTAssertNoThrow(try storage.load())
            
            XCTAssertTrue(storage.pins.partIDs.count == 1)
            XCTAssertEqual(storage.pins.partIDs, Set(["part-iron-plate"]))
            XCTAssertTrue(storage.pins.equipmentIDs.isEmpty)
            XCTAssertTrue(storage.pins.recipeIDs.isEmpty)
        }
    }
}
