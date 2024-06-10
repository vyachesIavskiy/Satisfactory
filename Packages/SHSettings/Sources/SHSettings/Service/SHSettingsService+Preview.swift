import Combine

extension SHSettingsService {
    final class Preview {
        private let _settings = CurrentValueSubject<Settings, Never>(Settings())
        
        var settings: AsyncStream<Settings> {
            _settings.values.eraseToStream()
        }
        
        var currentSettings: Settings {
            _settings.value
        }
        
        func setSettings(_ settings: Settings) {
            _settings.value = settings
        }
    }
}
