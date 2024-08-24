import SwiftUI

struct SHBorderedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled)
    private var isEnabled
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.shButtonCornerRadius)
    private var shButtonCornerRadius
    
    private var foregroundStyle: some ShapeStyle {
        if isEnabled {
            AnyShapeStyle(.tint)
        } else {
            AnyShapeStyle(.sh(.gray))
        }
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 20, minHeight: 20)
            .foregroundStyle(foregroundStyle.opacity(configuration.isPressed ? 0.35 : 1.0))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                AngledRectangle(cornerRadius: shButtonCornerRadius)
                    .fill(foregroundStyle.opacity(0.05))
                    .stroke(foregroundStyle, lineWidth: 1 / displayScale)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == SHBorderedButtonStyle {
    static var shBordered: Self {
        SHBorderedButtonStyle()
    }
}

#if DEBUG
#Preview("Buttons") {
    HStack {
        Button("Press me") {}
            .buttonStyle(.shBordered)
        
        Button {
            
        } label: {
            Image(systemName: "checkmark")
        }
        .buttonStyle(.shBordered)
        
        Button("Red tint") {}
            .buttonStyle(.shBordered)
            .tint(.sh(.red))
    }
    
//    VStack {
//        Button("Press me", systemImage: "star") {}
//        
//        Button("Press me", systemImage: "checkmark") {}
//            .buttonStyle(.bordered)
//        
//        Button("Press me", systemImage: "star") {}
//            .buttonStyle(.bordered)
//            .tint(.red)
//            .buttonBorderShape(.automatic)
//        
//        Button("Press me", systemImage: "star") {}
//            .buttonStyle(.borderedProminent)
//        
//        Button("Delete", systemImage: "trash") {}
//            .buttonStyle(.borderedProminent)
//            .tint(.red)
//        
//        Button("Press me", systemImage: "star") {}
//            .buttonStyle(.borderless)
//        
//        Button("Press me", systemImage: "star") {}
//            .buttonStyle(.plain)
//    }
}
#endif
