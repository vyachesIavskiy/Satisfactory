import SwiftUI
import SHSettings

private struct SettingsEnvironmentKey: EnvironmentKey {
    static let defaultValue = Settings()
}

extension EnvironmentValues {
    fileprivate var _settings: Settings {
        get { self[SettingsEnvironmentKey.self] }
        set { self[SettingsEnvironmentKey.self] = newValue }
    }
    
    var settings: Settings {
        _settings
    }
}

extension View {
    @MainActor @ViewBuilder
    func settings(_ settings: Settings) -> some View {
        environment(\._settings, settings)
    }
    
    @MainActor @ViewBuilder
    func viewMode(_ viewMode: ViewMode) -> some View {
        environment(\._settings.viewMode, viewMode)
    }
}
