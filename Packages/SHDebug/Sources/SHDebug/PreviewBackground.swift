#if DEBUG
import SwiftUI

struct PreviewBackgroundViewModifier: ViewModifier {
    let shapeStyle: AnyShapeStyle
    
    init(_ style: some ShapeStyle = Color(white: 0.961)) {
        shapeStyle = AnyShapeStyle(style)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(shapeStyle)
                .ignoresSafeArea()
            
            content
        }
    }
}

public extension View {
    @ViewBuilder
    func previewBackground(_ style: some ShapeStyle = Color(white: 0.961)) -> some View {
        modifier(PreviewBackgroundViewModifier(style))
    }
}

#Preview("Default background") {
    Text("Preview")
        .previewBackground()
}

#Preview("Orange background") {
    Text("Preview")
        .previewBackground(.orange)
}

#Preview("Gradient background") {
    Text("Preview")
        .previewBackground(
            .linearGradient(
                colors: [.orange, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
}

#Preview("No/Default background") {
    ZStack {
        Text("Preview")
        
        Text("Preview")
            .previewBackground()
            .mask(
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0),
                        .init(color: .clear, location: 0.5),
                        .init(color: .white, location: 0.5),
                        .init(color: .white, location: 1)
                    ],
                    startPoint: .init(x: 0, y: 0.4),
                    endPoint: .init(x: 1, y: 0.6)
                )
                .ignoresSafeArea()
            )
    }
}
#endif
