import SwiftUI

struct ListGradientSeparatorViewModifier: ViewModifier {
    @Environment(\.displayScale)
    private var displayScale
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            separator
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
    func addListGradientSeparator() -> some View {
        modifier(ListGradientSeparatorViewModifier())
    }
}
