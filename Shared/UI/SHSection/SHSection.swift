import SwiftUI

struct SHSection<Data, ID, Content: View>: View {
    @Binding var expanded: Bool

    private let title: String
    private let data: [Data]
    private let id: KeyPath<Data, ID>
    private let content: (Data) -> Content
    
    @Environment(\.defaultMinListHeaderHeight)
    private var defaultMinListHeaderHeight
    
    init(
        _ title: String,
        data: [Data],
        id: KeyPath<Data, ID>,
        expanded: Binding<Bool>,
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.title = title
        self.data = data
        self.id = id
        self._expanded = expanded
        self.content = content
    }
    
    init(
        _ title: String,
        data: [Data],
        expanded: Binding<Bool>,
        @ViewBuilder content: @escaping (Data) -> Content
    ) where Data: Identifiable, Data.ID == ID {
        self.init(title, data: data, id: \.id, expanded: expanded, content: content)
    }
    
    init(
        _ title: String,
        range: Range<Int>,
        expanded: Binding<Bool>,
        @ViewBuilder content: @escaping (Data) -> Content
    ) where Data == Int, ID == Int {
        self.init(title, data: Array(range), id: \.self, expanded: expanded, content: content)
    }
    
    var body: some View {
        Section(isExpanded: $expanded) {
            ForEach(data.indices, id: \.self) { index in
                content(data[index])
            }
        } header: {
            SHSectionHeader(title, expanded: $expanded)
        }
    }
}

// MARK: - Header
struct SHSectionHeader: View {
    var title: String
    @Binding var expanded: Bool
    
    init(_ title: String, expanded: Binding<Bool>) {
        self.title = title
        self._expanded = expanded
    }
    
    var body: some View {
        Button {
            withAnimation(.default.speed(2)) {
                expanded.toggle()
            }
        } label: {
            Text(title)
                .font(.callout.lowercaseSmallCaps())
                .fontWeight(.bold)
                .foregroundStyle(.sh(expanded ? .midnight30 : .midnight))
        }
        .buttonStyle(ButtonStyle(expanded))
    }
}

// MARK: Header button style
private extension SHSectionHeader {
    struct ButtonStyle: SwiftUI.ButtonStyle {
        var expanded: Bool
        
        @Environment(\.displayScale) private var displayScale
        
        init(_ expanded: Bool) {
            self.expanded = expanded
        }
        
        func makeBody(configuration: Configuration) -> some View {
            HStack(alignment: .lastTextBaseline, spacing: 16) {
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
private extension SHSectionHeader {
    struct ExpandArrow: Shape {
        var expanded: Bool
        private var expandedFloat: CGFloat
        
        var animatableData: CGFloat {
            get { expandedFloat }
            set { expandedFloat = newValue }
        }
        
        init(_ expanded: Bool) {
            self.expanded = expanded
            self.expandedFloat = expanded ? 1.0 : 0.0
        }
        
        func path(in rect: CGRect) -> Path {
            Path { path in
                path.move(to: rect.centerLeft.offsetBy(x: 5 * expandedFloat, y: 5 * expandedFloat))
                path.addLine(to: rect.centerLeft)
                path.addLine(to: rect.centerRight)
                path.addLine(to: rect.centerRight.offsetBy(x: -5 * (1.0 - expandedFloat), y: -5 * (1.0 - expandedFloat)))
            }
        }
    }
}

#if DEBUG
// MARK: - Previews
private struct _SHSectionPreview: View {
    @State private var expanded1 = true
    @State private var expanded2 = true
    
    var body: some View {
        List {
            SHSection("SHSection preview\n(Second line for preview of long section name)", range: 0..<10, expanded: $expanded1) { index in
                Text("Row \(index)")
            }
            
            SHSection("SHSection preview", range: 0..<10, expanded: $expanded2) { index in
                Text("Row \(index)")
            }
        }
    }
}

#Preview("SHSection") {
    _SHSectionPreview()
}
#endif
