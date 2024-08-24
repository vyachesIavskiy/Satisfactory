import SwiftUI

struct AngledLinedBackground: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.topLeft)
            path.addLine(to: rect.topRight.offsetBy(x: -cornerRadius))
            path.addLine(to: rect.topRight.offsetBy(y: cornerRadius))
            
            path.move(to: rect.bottomRight)
            path.addLine(to: rect.bottomLeft.offsetBy(x: cornerRadius))
            path.addLine(to: rect.bottomLeft.offsetBy(y: -cornerRadius))
        }
    }
}

struct AngledLinedBackground_Previews: PreviewProvider {
    static var previews: some View {
        AngledLinedBackground(cornerRadius: 10)
    }
}
