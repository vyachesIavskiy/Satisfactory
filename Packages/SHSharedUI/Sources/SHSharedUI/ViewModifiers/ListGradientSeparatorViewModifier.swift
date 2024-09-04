import SwiftUI

public struct ListGradientSeparatorViewModifier: ViewModifier {
    private let leadingPadding: Double
    
    @Environment(\.displayScale)
    private var displayScale
    
    public init(leadingPadding: Double) {
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
            colors: [.sh(.midnight40), .sh(.gray10)],
            startPoint: .leading,
            endPoint: UnitPoint(x: 0.85, y: 0.5)
        )
        .frame(height: 2 / displayScale)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

extension View {
    @MainActor @ViewBuilder
    public func addListGradientSeparator(leadingPadding: Double = 0) -> some View {
        modifier(ListGradientSeparatorViewModifier(leadingPadding: leadingPadding))
    }
}
