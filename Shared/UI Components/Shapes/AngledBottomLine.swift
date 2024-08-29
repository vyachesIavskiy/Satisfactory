import SwiftUI

struct AngledBottomLine: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.bottomRight)
            path.addLine(to: rect.bottomLeft.offsetBy(x: cornerRadius))
            path.addLine(to: rect.bottomLeft.offsetBy(y: -cornerRadius))
        }
    }
}

#if DEBUG
#Preview {
    AngledBottomLine(cornerRadius: 10)
}
#endif
