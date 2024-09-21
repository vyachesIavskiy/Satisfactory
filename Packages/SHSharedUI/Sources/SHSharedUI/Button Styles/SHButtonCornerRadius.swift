import SwiftUI

private struct SHButtonCornerRadiusEnvironmentKey: EnvironmentKey {
    nonisolated(unsafe) static var defaultValue: Double = 4.0
}

extension EnvironmentValues {
    public var shButtonCornerRadius: Double {
        get { self[SHButtonCornerRadiusEnvironmentKey.self] }
        set { self[SHButtonCornerRadiusEnvironmentKey.self] = newValue }
    }
}

extension View {
    @MainActor @ViewBuilder
    public func shButtonCornerRadius(_ cornerRadius: Double) -> some View {
        environment(\.shButtonCornerRadius, cornerRadius)
    }
}
