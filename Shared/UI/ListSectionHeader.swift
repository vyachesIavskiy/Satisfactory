import SwiftUI

struct ListSectionHeader: View {
    var title: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Text(title)
            .font(.title2.weight(.semibold))
            .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
            .padding(.horizontal, 12)
            .background {
                AngledRectangle(cornerRadius: 8, corners: .bottom)
                    .foregroundStyle(.background)
                    .shadow(color: colorScheme == .dark ? Color(white: 0.25) : .gray, radius: 2, x: 0, y: 1)
            }
    }
}

struct ListSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.white
                    .ignoresSafeArea()
                
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                    .preferredColorScheme(.dark)
            }
            
            VStack {
                ListSectionHeader(title: "Test")
                
                ListSectionHeader(title: "Test")
                    .preferredColorScheme(.dark)
            }
        }
    }
}

struct ListSectionHeaderNew: View {
    var title: LocalizedStringKey
    var numberOfItems: Int
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
            }
        } label: {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color("Secondary"))
        }
        .buttonStyle(.listSectionHeader(isExpanded: isExpanded))
    }
}

private struct ListSectionHeaderButtonStyle: ButtonStyle {
    var isExpanded: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .opacity(configuration.isPressed ? 0.25 : 1)
            
            Spacer()
            
            ListSectionHeaderExpandArrow(isExpanded: isExpanded)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color("Secondary").opacity(0.75))
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 20)
        }
        .padding(.horizontal, 15)
        .padding(.top, 5)
        .padding(.bottom, 7)
        .contentShape(Rectangle())
        .background {
            VStack {
                ListSectionHeaderTopShape(cornerRadius: 10, isExpanded: isExpanded)
                    .stroke(lineWidth: 0.75)
                    .foregroundStyle(Color("Secondary").opacity(0.75))
                    .shadow(color: isExpanded ? Color("Secondary").opacity(0.5) : .clear, radius: 2)
                
                Spacer()
                
                ListSectionHeaderBottomShape(cornerRadius: 10, isExpanded: isExpanded)
                    .stroke(lineWidth: 0.75)
                    .foregroundStyle(Color("Secondary").opacity(isExpanded ? 0.25 : 0.75))
                    .padding(.horizontal, isExpanded ? 10 : 0)
            }
        }
    }
}

private extension ButtonStyle where Self == ListSectionHeaderButtonStyle {
    static func listSectionHeader(isExpanded: Bool) -> Self {
        ListSectionHeaderButtonStyle(isExpanded: isExpanded)
    }
}

private struct ListSectionHeaderTopShape: Shape {
    var cornerRadius: CGFloat
    var isExpanded: Bool
    private var isExpandedFloat: CGFloat
    
    var animatableData: CGFloat {
        get { isExpandedFloat }
        set { isExpandedFloat = newValue }
    }
    
    private var expandedCornerRadius: CGFloat {
        max(0, cornerRadius - 4 * isExpandedFloat)
    }
    
    init(cornerRadius: CGFloat, isExpanded: Bool) {
        self.cornerRadius = cornerRadius
        self.isExpanded = isExpanded
        self.isExpandedFloat = isExpanded ? 1.0 : 0.0
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.topLeft)
            path.addLine(to: rect.topRight.offsetBy(x: -cornerRadius))
            path.addLine(to: rect.topRight.offsetBy(y: cornerRadius))
            
            path.move(to: rect.topRight.offsetBy(x: -expandedCornerRadius))
            path.addLine(to: rect.topRight.offsetBy(y: expandedCornerRadius))
        }
    }
}

private struct ListSectionHeaderExpandArrow: Shape {
    var isExpanded: Bool
    private var isExpandedFloat: CGFloat
    
    var animatableData: CGFloat {
        get { isExpandedFloat }
        set { isExpandedFloat = newValue }
    }
    
    init(isExpanded: Bool) {
        self.isExpanded = isExpanded
        self.isExpandedFloat = isExpanded ? 1.0 : 0.0
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.centerLeft.offsetBy(x: 5 * isExpandedFloat, y: 5 * isExpandedFloat))
            path.addLine(to: rect.centerLeft)
            path.addLine(to: rect.centerRight)
            path.addLine(to: rect.centerRight.offsetBy(x: -5 * (1.0 - isExpandedFloat), y: -5 * (1.0 - isExpandedFloat)))
        }
    }
}

private struct ListSectionHeaderBottomShape: Shape {
    var cornerRadius: CGFloat
    var isExpanded: Bool
    private var isExpandedFloat: CGFloat
    
    var animatableData: CGFloat {
        get { isExpandedFloat }
        set { isExpandedFloat = newValue }
    }
    
    init(cornerRadius: CGFloat, isExpanded: Bool) {
        self.cornerRadius = cornerRadius
        self.isExpanded = isExpanded
        self.isExpandedFloat = isExpanded ? 0.0 : 1.0
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.bottomRight)
            
            path.addLine(to: rect.bottomLeft.offsetBy(x: cornerRadius * isExpandedFloat))
            path.addLine(to: rect.bottomLeft.offsetBy(y: -cornerRadius * isExpandedFloat))
        }
    }
}

struct ListSectionFooterShape: Shape {
    var cornerRadius: CGFloat
    
    private var expandedCornerRadius: CGFloat {
        max(0, cornerRadius - 5)
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.bottomRight)
            path.addLine(to: rect.bottomLeft.offsetBy(x: cornerRadius))
            path.addLine(to: rect.bottomLeft.offsetBy(y: -cornerRadius))
            
            path.move(to: rect.bottomLeft.offsetBy(x: expandedCornerRadius))
            path.addLine(to: rect.bottomLeft.offsetBy(y: -expandedCornerRadius))
        }
    }
}

struct ListSectionHeaderNew_Previews: PreviewProvider {
    private struct Preview: View {
        @State private var isExpanded = false
        @State private var isExpanded2 = false
        
        var body: some View {
            VStack(spacing: 50) {
                Button(isExpanded ? "Collapse" : "Expand") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
                Group {
                    ListSectionHeaderTopShape(cornerRadius: 10, isExpanded: isExpanded)
                        .stroke(lineWidth: 0.75)
                        .shadow(color: isExpanded ? Color("Secondary") : Color.clear, radius: 2)
                    
                    ListSectionHeaderBottomShape(cornerRadius: 10, isExpanded: isExpanded)
                        .stroke(lineWidth: 0.75)
                        .foregroundStyle(Color("Secondary").opacity(isExpanded ? 0.25 : 0.75))
                        .padding(.horizontal, isExpanded ? 10 : 0)
                    
                    ListSectionFooterShape(cornerRadius: 10)
                        .stroke(lineWidth: 0.75)
                        .shadow(color: Color("Secondary"), radius: 2)
                        
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(Color("Secondary").opacity(0.75))
                
                ListSectionHeaderNew(title: "Section", numberOfItems: 10, isExpanded: $isExpanded2)
                    .padding(.horizontal)
            }
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
