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

struct PreviewBackground_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBackground {
            Text("Preview")
        }
        
        PreviewBackground(.orange) {
            Text("Preview")
        }
        .previewDisplayName("Preview background (Orange)")
        
        PreviewBackground(.linearGradient(colors: [.orange, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)) {
            Text("Preview")
        }
        .previewDisplayName("Preview background (Gradient Orange -> Blue)")
    }
}
#endif
