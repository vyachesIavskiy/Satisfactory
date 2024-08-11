import SwiftUI

struct SHTintedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(.tint)
            .opacity(configuration.isPressed ? 0.65 : 1.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                ZStack {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundStyle(.tint)
                        .blur(radius: 2)
                    
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundStyle(.background)
                }
                .compositingGroup()
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension ButtonStyle where Self == SHTintedButtonStyle {
    static var shTinted: Self { SHTintedButtonStyle() }
}

#if DEBUG
#Preview("Buttons") {
    HStack {
        Button("Press me") {}
            .buttonStyle(.shTinted)
        
        Button {
            
        } label: {
            Image(systemName: "checkmark")
        }
        .buttonStyle(.shTinted)
        
        Button("Red tint") {}
            .buttonStyle(.shTinted)
            .tint(.sh(.red))
    }
}
#endif
