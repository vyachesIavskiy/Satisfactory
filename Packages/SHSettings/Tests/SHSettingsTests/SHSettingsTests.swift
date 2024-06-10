import XCTest
import SHDependencies
@testable import SHSettings

final class SHSettingsTests: XCTestCase {
    func testDefaultSettings() async throws {
        let settings = Settings()
        
        XCTAssertEqual(settings.viewMode, .icon)
        XCTAssertEqual(settings.autoSelectSingleRecipe, true)
        XCTAssertEqual(settings.autoSelectSinglePinnedRecipe, false)
        XCTAssertEqual(settings.showFICSMAS, true)
    }
    
    func testDefaultPreviewSettings() async throws {
        await withDependencies {
            $0.settingsService = .preview
        } operation: {
            @Dependency(\.settingsService) var settings
            
            let viewMode = await settings.viewMode().first { _ in true }
            let autoSelectSingleRecipe = await settings.autoSelectSingleRecipe().first { _ in true }
            let autoSelectSinglePinnedRecipe = await settings.autoSelectSinglePinnedRecipe().first { _ in true }
            let showFICSMAS = await settings.showFICSMAS().first { _ in true }
            
            XCTAssertEqual(viewMode, .icon)
            XCTAssertEqual(autoSelectSingleRecipe, true)
            XCTAssertEqual(autoSelectSinglePinnedRecipe, false)
            XCTAssertEqual(showFICSMAS, true)
        }
    }
    
    func testViewModeChangePublished() async throws {
        await withDependencies {
            $0.settingsService = .preview
        } operation: {
            @Dependency(\.settingsService) var settings
            
            settings.setViewMode(.row)
            
            let newViewMode = await settings.viewMode().first { _ in true }
            
            XCTAssertEqual(newViewMode, .row)
        }
    }
}
