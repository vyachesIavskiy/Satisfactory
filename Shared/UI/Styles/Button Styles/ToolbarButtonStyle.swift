import SwiftUI

struct SHToolbarButtonStyle: ButtonStyle {
    enum Role {
        case normal
        case cancel
        case confirm
    }
    
    var role: Role = .normal
    
    @Environment(\.isEnabled)
    private var isEnabled
    
    private var fontWeigth: Font.Weight {
        switch role {
        case .normal, .cancel: .regular
        case .confirm: .semibold
        }
    }
    
    private var foregroundColor: Color {
        switch role {
        case .cancel: .primary
        case .normal, .confirm: .white
        }
    }
    
    private var backgroundColor: Color {
        if !isEnabled {
            .sh(.gray40)
        } else {
            switch role {
            case .normal: .sh(.midnight)
            case .cancel: .sh(.midnight20)
            case .confirm: .sh(.orange)
            }
        }
    }
    
    private var shadowColor: Color {
        if isEnabled {
            .sh(.gray20)
        } else {
            switch role {
            case .normal: .sh(.midnight30)
            case .cancel: .sh(.midnight10)
            case .confirm: .sh(.orange30)
            }
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout)
            .fontWeight(fontWeigth)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .frame(minWidth: 40, minHeight: 25)
            .background {
                AngledRectangle(cornerRadius: 4)
                    .foregroundStyle(backgroundColor.opacity(configuration.isPressed ? 0.85 : 1.0))
                    .shadow(color: shadowColor, radius: 1, y: 1)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == SHToolbarButtonStyle {
    static func shToolbar(role: SHToolbarButtonStyle.Role = .normal) -> Self {
        SHToolbarButtonStyle(role: role)
    }
}

#if DEBUG
private struct _ButtonPreview: View {
    let title: String
    let role: SHToolbarButtonStyle.Role
    
    init(_ title: String, role: SHToolbarButtonStyle.Role) {
        self.title = title
        self.role = role
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
            
            Button {
                
            } label: {
                Label("Press Me", systemImage: "star")
            }
            .buttonStyle(.shToolbar(role: role))
        }
    }
}

#Preview("Buttons") {
    HStack {
        _ButtonPreview("Normal", role: .normal)
        
        _ButtonPreview("Cancel", role: .cancel)
        
        _ButtonPreview("Confirm", role: .confirm)
    }
}
#endif
