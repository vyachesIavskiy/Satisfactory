import SwiftUI

struct InverseMaskViewModifier<Mask: View>: ViewModifier {
    let alignment: Alignment
    let mask: Mask
    
    init(alignment: Alignment, @ViewBuilder mask: () -> Mask) {
        self.alignment = alignment
        self.mask = mask()
    }
    
    func body(content: Content) -> some View {
        content
            .mask {
                Rectangle()
                    .overlay(alignment: alignment) {
                        mask
                            .blendMode(.destinationOut)
                    }
            }
    }
}

extension View {
    func inverseMask<Mask: View>(alignment: Alignment = .center, @ViewBuilder _ mask: () -> Mask) -> some View {
        modifier(InverseMaskViewModifier(alignment: alignment, mask: mask))
    }
}

#Preview {
    Text("Hello, world!")
        .inverseMask {
            Circle()
        }
}
