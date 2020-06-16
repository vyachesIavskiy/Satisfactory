import SwiftUI

//struct RoundedRectangle: View {
//    var topLeft: CGFloat = 0
//    var topRight: CGFloat = 0
//    var bottomLeft: CGFloat = 0
//    var bottomRight: CGFloat = 0
//    var color: Color = .clear
//    
//    var body: some View {
//        GeometryReader { reader in
//            Path { path in
//                let w = reader.size.width
//                let h = reader.size.height
//                
//                let hw = w / 2
//                let hh = h / 2
//                
//                let tl = min(min(self.topLeft, hw), hh)
//                let tr = min(min(self.topRight, hw), hh)
//                let bl = min(min(self.bottomLeft, hw), hh)
//                let br = min(min(self.bottomRight, hw), hh)
//                
//                path.move(to: .init(x: 0, y: hh))
//                path.addLine(to: .init(x: 0, y: tl))
//                path.addArc(center: .init(x: tl, y: tl), radius: tl, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)
//                path.addLine(to: .init(x: w - tr, y: 0))
//                path.addArc(center: .init(x: w - tr, y: tr), radius: tr, startAngle: .init(degrees: 270), endAngle: .init(degrees: 0), clockwise: false)
//                path.addLine(to: .init(x: w, y: h - br))
//                path.addArc(center: .init(x: w - br, y: h - br), radius: br, startAngle: .init(degrees: 0), endAngle: .init(degrees: 90), clockwise: false)
//                path.addLine(to: .init(x: bl, y: h))
//                path.addArc(center: .init(x: bl, y: h - bl), radius: bl, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
//            }
//            .fill(self.color)
//        }
//    }
//}
