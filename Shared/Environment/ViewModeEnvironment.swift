import SwiftUI
import SHSettings

private struct ViewModeEnvironmentKey: EnvironmentKey {
    static let defaultValue = {
        @Dependency(\.settingsService)
        var settingsService
        
        return settingsService.currentSettings().viewMode
    }()
}

extension EnvironmentValues {
    var viewMode: ViewMode {
        get { self[ViewModeEnvironmentKey.self] }
        set { self[ViewModeEnvironmentKey.self] = newValue }
    }
}

extension View {
    @MainActor @ViewBuilder
    func viewMode(_ viewMode: ViewMode) -> some View {
        environment(\.viewMode, viewMode)
    }
}
