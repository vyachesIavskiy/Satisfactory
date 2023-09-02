#if DEBUG
import SwiftUI

public struct PreviewBackground<Content: View>: View {
    let shapeStyle: AnyShapeStyle
    let content: Content
    
    public init(_ style: some ShapeStyle = Color(white: 0.961), @ViewBuilder content: () -> Content) {
        shapeStyle = AnyShapeStyle(style)
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(shapeStyle)
                .ignoresSafeArea()
            
            content
        }
    }
}

#Preview("Preview background") {
    PreviewBackground {
        Text("Preview")
    }
}

#Preview("Preview background (Orange)") {
    PreviewBackground(.orange) {
        Text("Preview")
    }
}

#Preview("Preview background (Gradient Orange -> Blue)") {
    PreviewBackground(.linearGradient(colors: [.orange, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)) {
        Text("Preview")
    }
}
#endif
