import SwiftUI

struct ToolbarButtonStyle: ButtonStyle {
    enum Role {
        case normal
        case cancel
        case confirm
    }
    
    var role: Role = .normal
    
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
        switch role {
        case .normal: .sh(.midnight)
        case .cancel: .sh(.midnight20)
        case .confirm: .sh(.orange)
        }
    }
    
    private var shadowColor: Color {
        switch role {
        case .normal: .sh(.midnight30)
        case .cancel: .sh(.midnight10)
        case .confirm: .sh(.orange30)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.footnote)
            .fontWeight(fontWeigth)
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .frame(minWidth: 40, minHeight: 25)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .foregroundStyle(backgroundColor.opacity(configuration.isPressed ? 0.85 : 1.0))
                    .shadow(color: shadowColor, radius: 1, y: 1)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == ToolbarButtonStyle {
    static func toolbar(role: ToolbarButtonStyle.Role = .normal) -> Self {
        ToolbarButtonStyle(role: role)
    }
}

#if DEBUG
private struct _ButtonPreview: View {
    let title: String
    let role: ToolbarButtonStyle.Role
    
    init(_ title: String, role: ToolbarButtonStyle.Role) {
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
            .buttonStyle(.toolbar(role: role))
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
