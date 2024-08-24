import SwiftUI

private struct SHButtonCornerRadiusEnvironmentKey: EnvironmentKey {
    static var defaultValue: Double = 4.0
}

extension EnvironmentValues {
    var shButtonCornerRadius: Double {
        get { self[SHButtonCornerRadiusEnvironmentKey.self] }
        set { self[SHButtonCornerRadiusEnvironmentKey.self] = newValue }
    }
}

extension View {
    @MainActor @ViewBuilder
    func shButtonCornerRadius(_ cornerRadius: Double) -> some View {
        environment(\.shButtonCornerRadius, cornerRadius)
    }
}
