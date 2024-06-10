import Combine
import SHPersistence

extension SHSettingsService {
    final class Live {
        private static let filename = "Settings"
        
        private let persistence = SHPersistence(homeDirectoryName: "Settings/V2")
        private let _settings: CurrentValueSubject<Settings, Never>
        
        var settings: AsyncStream<Settings> {
            _settings.values.eraseToStream()
        }
        
        var currentSettings: Settings {
            _settings.value
        }
        
        func setSettings(_ settings: Settings) {
            _settings.value = settings
            
            save()
        }
        
        init() {
            let settings: Settings
            do {
                settings = try persistence.loadOne(Settings.self, fromFile: Self.filename)
            } catch {
                settings = Settings()
            }
            
            self._settings = CurrentValueSubject(settings)
        }
        
        private func save() {
            do {
                try persistence.save(model: _settings.value, to: Self.filename)
            } catch {
                print(error)
            }
        }
    }
}