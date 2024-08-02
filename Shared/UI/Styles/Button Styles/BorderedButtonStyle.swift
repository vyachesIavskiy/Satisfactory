import SwiftUI

struct SHBorderedButtonStyle: ButtonStyle {
    var cornerRadius: Double
    var corners: AngledRectangle.Corner.Set
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(cornerRadius)
            .background(.tint, in: AngledRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == SHBorderedButtonStyle {
    static func shBordered(
        cornerRadius: Double = 8,
        corners: AngledRectangle.Corner.Set = [.topRight, .bottomLeft]
    ) -> Self {
        SHBorderedButtonStyle(cornerRadius: cornerRadius, corners: corners)
    }
}

#if DEBUG
#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(.shBordered())
}
#endif
