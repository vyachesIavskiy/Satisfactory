import SwiftUI

extension View {
    @MainActor @ViewBuilder
    public func disabledStyle(_ disabled: Bool) -> some View {
        grayscale(disabled ? 0.5 : 0.0)
            .brightness(disabled ? -0.25 : 0.0)
    }
}
