import SwiftUI

struct BubbleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

extension View {
    @ViewBuilder
    func insideBubble() -> some View {
        modifier(BubbleModifier())
    }
}
