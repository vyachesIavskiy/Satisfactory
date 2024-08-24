import SwiftUI
import SHSettings

private struct ShowIngredientNamesEnvironmentKey: EnvironmentKey {
    static let defaultValue = {
        @Dependency(\.settingsService)
        var settingsService
        
        return settingsService.showIngredientNames
    }()
}

extension EnvironmentValues {
    var showIngredientNames: Bool {
        get { self[ShowIngredientNamesEnvironmentKey.self] }
        set { self[ShowIngredientNamesEnvironmentKey.self] = newValue }
    }
}

extension View {
    @MainActor @ViewBuilder
    func showIngredientNames(_ showIngredientNames: Bool) -> some View {
        environment(\.showIngredientNames, showIngredientNames)
    }
}
