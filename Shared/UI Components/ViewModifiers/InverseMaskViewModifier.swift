import SwiftUI

private struct InverseMaskViewModifier<Mask: View>: ViewModifier {
    let mask: Mask
    
    init(@ViewBuilder mask: () -> Mask) {
        self.mask = mask()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            mask
                .blendMode(.destinationOut)
        }
        .compositingGroup()
    }
}

extension View {
    @ViewBuilder
    func inverseMask<Mask: View>(@ViewBuilder _ mask: () -> Mask) -> some View {
        modifier(InverseMaskViewModifier(mask: mask))
    }
}

#if DEBUG
#Preview("Rectangle - Circle") {
    Rectangle()
        .fill(.green.gradient)
        .aspectRatio(1, contentMode: .fit)
        .border(.red)
        .inverseMask {
            Circle()
                .padding(10)
        }
        .padding(20)
}

#Preview("Circle - Text") {
    Circle()
        .fill(.brown.gradient)
        .aspectRatio(1, contentMode: .fit)
        .border(.red)
        .inverseMask {
            Text("This text will be cut out from circle")
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .background(.linearGradient(colors: [.red, .orange, .yellow], startPoint: .leading, endPoint: .trailing))
        .padding(20)
}
#endif
