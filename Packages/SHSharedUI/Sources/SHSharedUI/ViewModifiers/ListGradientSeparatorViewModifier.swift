import SwiftUI

public struct ListGradientSeparatorViewModifier: ViewModifier {
    private let colors: [Color]
    private let lineWidth: Double
    private let leadingPadding: Double
    
    @Environment(\.displayScale)
    private var displayScale
    
    public init(colors: [Color], lineWidth: Double, leadingPadding: Double) {
        self.colors = colors
        self.lineWidth = lineWidth
        self.leadingPadding = leadingPadding
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
            
            separator
                .padding(.leading, leadingPadding)
        }
    }
    
    @MainActor @ViewBuilder
    private var separator: some View {
        LinearGradient(
            colors: colors,
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(height: lineWidth / displayScale)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

extension View {
    @MainActor @ViewBuilder
    public func addListGradientSeparator(
        colors: [Color] = [.sh(.midnight), .sh(.midnight30)],
        lineWidth: Double = 2,
        leadingPadding: Double = 0
    ) -> some View {
        modifier(ListGradientSeparatorViewModifier(colors: colors, lineWidth: lineWidth, leadingPadding: leadingPadding))
    }
}
