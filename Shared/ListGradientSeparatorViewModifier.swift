import SwiftUI

struct ListGradientSeparatorViewModifier: ViewModifier {
    private let leadingPadding: Double
    
    @Environment(\.displayScale)
    private var displayScale
    
    init(leadingPadding: Double) {
        self.leadingPadding = leadingPadding
    }
    
    func body(content: Content) -> some View {
        ZStack {
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
    func addListGradientSeparator(leadingPadding: Double = 0) -> some View {
        modifier(ListGradientSeparatorViewModifier(leadingPadding: leadingPadding))
    }
}
