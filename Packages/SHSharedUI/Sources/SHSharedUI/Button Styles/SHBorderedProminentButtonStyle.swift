import SwiftUI

public struct SHBorderedProminentButtonStyle: ButtonStyle {
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
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 20, minHeight: 20)
            .foregroundStyle(.background)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                AngledRectangle(cornerRadius: shButtonCornerRadius)
                    .fill(foregroundStyle)
            }
            .opacity(configuration.isPressed ? 0.75 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == SHBorderedProminentButtonStyle {
    public static var shBorderedProminent: Self {
        SHBorderedProminentButtonStyle()
    }
}

#if DEBUG
#Preview {
    HStack {
        Button {} label: {
            Text(verbatim: "Press me")
        }
        .buttonStyle(.shBorderedProminent)
        
        Button {
            
        } label: {
            Image(systemName: "checkmark")
        }
        .buttonStyle(.shBorderedProminent)
        
        Button {} label: {
            Text(verbatim: "Red tint")
        }
        .buttonStyle(.shBorderedProminent)
        .tint(.sh(.red))
    }
}
#endif
