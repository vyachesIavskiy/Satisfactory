import Combine
import SHPersistence

final class SHSettingsPublisher {
    private static let filename = "Settings"
    
    private let persistence = SHPersistence(homeDirectoryName: "Settings/V2")
    
    @Published
    var settings = Settings()
    
    init() {
        do {
            settings = try persistence.loadOne(Settings.self, fromFile: Self.filename)
        } catch {
            settings = Settings()
        }
    }
    
    private func save() {
        do {
            try persistence.save(settings, toFile: Self.filename)
        } catch {
            print(error)
        }
    }
}
