import SwiftUI

public struct SectionHeader<Label: View>: View {
    @Environment(\.displayScale)
    private var displayScale
    
    var label: Label
    var expanded: Binding<Bool>?
    
    public init(expanded: Binding<Bool>? = nil, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.expanded = expanded
    }
    
    @_disfavoredOverload
    public init<S: StringProtocol>(_ title: S, expanded: Binding<Bool>? = nil) where Label == Text {
        self.label = Text(title)
        self.expanded = expanded
    }
    
    public init(_ title: LocalizedStringKey, expanded: Binding<Bool>? = nil) where Label == Text {
        self.label = Text(title)
        self.expanded = expanded
    }
    
    public var body: some View {
        let resolvedLabel = label
            .textCase(nil)
            .font(.callout)
            .fontWeight(.semibold)
            .drawingGroup()
        
        if let expanded {
            Button {
                withAnimation(.default.speed(2)) {
                    expanded.wrappedValue.toggle()
                }
            } label: {
                resolvedLabel
                    .foregroundStyle(.sh(expanded.wrappedValue ? .gray : .midnight))
            }
            .buttonStyle(ButtonStyle(expanded.wrappedValue))
        } else {
            resolvedLabel
                .foregroundStyle(.sh(.gray))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 3)
                .padding(.bottom, 5)
                .padding(.trailing, 4)
                .background(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 2 / displayScale)
                        .foregroundStyle(.sh(.midnight30))
                }
        }
    }
}

// MARK: Header button style
private extension SectionHeader {
    struct ButtonStyle: SwiftUI.ButtonStyle {
        var expanded: Bool
        
        @Environment(\.displayScale)
        private var displayScale
        
        init(_ expanded: Bool) {
            self.expanded = expanded
        }
        
        func makeBody(configuration: Configuration) -> some View {
            HStack(spacing: 16) {
                configuration.label
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ExpandArrow(expanded)
                    .stroke(lineWidth: expanded ? 1 : 2)
                    .foregroundStyle(.sh(expanded ? .midnight30 : .midnight))
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 20)
            }
            .padding(.top, 3)
            .padding(.bottom, 5)
            .padding(.trailing, 4)
            .background(alignment: .bottom) {
                Rectangle()
                    .frame(width: expanded ? nil : 0, height: 2 / displayScale)
                    .foregroundStyle(.sh(.midnight30))
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: Arrow
public struct ExpandArrow: Shape {
    var expanded: Bool
    private var expandedFloat: CGFloat
    
    public var animatableData: CGFloat {
        get { expandedFloat }
        set { expandedFloat = newValue }
    }
    
    public init(_ expanded: Bool) {
        self.expanded = expanded
        self.expandedFloat = expanded ? 1.0 : 0.0
    }
    
    public func path(in rect: CGRect) -> Path {
        let verticalOffset = rect.width / 4
        
        return Path { path in
            path.move(
                to: rect.centerLeft.offsetBy(
                    x: verticalOffset * expandedFloat,
                    y: verticalOffset * expandedFloat
                )
            )
            path.addLine(to: rect.centerLeft)
            path.addLine(to: rect.centerRight)
            path.addLine(
                to: rect.centerRight.offsetBy(
                    x: -verticalOffset * (1.0 - expandedFloat),
                    y: -verticalOffset * (1.0 - expandedFloat)
                )
            )
        }
    }
}

#if DEBUG
// MARK: - Previews
private struct _SectionPreview: View {
    @State
    private var expanded = true
    
    var body: some View {
        List {
            Section(isExpanded: $expanded) {
                ForEach(0..<10) { index in
                    Text(verbatim: "Row \(index)")
                }
            } header: {
                SectionHeader("Section preview\n(Second line for preview of long section name)", expanded: $expanded)
            }
            
            Section {
                ForEach(0..<10) { index in
                    Text(verbatim: "Row \(index)")
                }
            } header: {
                SectionHeader("Section preview")
            }
        }
    }
}

#Preview("Section") {
    _SectionPreview()
}
#endif
