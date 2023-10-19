import SwiftUI

struct SegmentedBackgroundClipShape: Shape {
    enum Position: Animatable {
        case left
        case middle
        case right
        case single
        
        var animatableData: Double {
            switch self {
            case .left: -1.0
            case .middle: 0.0
            case .right: 1.0
            case .single: 2.0
            }
        }
    }
    
    var position: Position
    
    var animatableData: Double {
        get { positionDoubleValue }
        set { positionDoubleValue = newValue }
    }
    
    private let cornerOffset = 4.0
    private var positionDoubleValue: Double
    
    private var cornerAnimatableOffset: Double {
        let resolvedPositionValue = if position == .single {
            positionDoubleValue * 0.5
        } else {
            positionDoubleValue
        }
        
        return cornerOffset * resolvedPositionValue
    }
    
    private var topRightOffset: Double {
        max(cornerAnimatableOffset, 0)
    }
    
    private var bottomLeftOffset: Double {
        let resolvedOffset = if position == .single {
            -cornerAnimatableOffset
        } else {
            cornerAnimatableOffset
        }
        
        return -min(resolvedOffset, 0)
    }
    
    init(position: Position) {
        self.position = position
        self.positionDoubleValue = position.animatableData
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - topRightOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + topRightOffset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + bottomLeftOffset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - bottomLeftOffset))
        }
    }
}

#Preview("Segmented - Background clip shape") {
    VStack {
        HStack {
            SegmentedBackgroundClipShape(position: .single)
        }
        .frame(height: 50)
        
        HStack {
            SegmentedBackgroundClipShape(position: .left)
            SegmentedBackgroundClipShape(position: .right)
        }
        .frame(height: 50)
        
        HStack {
            SegmentedBackgroundClipShape(position: .left)
            SegmentedBackgroundClipShape(position: .middle)
            SegmentedBackgroundClipShape(position: .right)
        }
        .frame(height: 50)
    }
    .padding()
}

struct SegmentedTileShape: Shape {
    enum Position {
        case left
        case middle
        case right
        case single
    }
    
    var position: Position
    var selected: Bool
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            switch position {
            case .left:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX + 6, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 6))
                
                if selected {
                    path.move(to: CGPoint(x: rect.minX + 3, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 3))
                }
                
            case .middle:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                
            case .right:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX - 6, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 6))
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                
                if selected {
                    path.move(to: CGPoint(x: rect.maxX - 3, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 3))
                }
                
            case .single:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX - 6, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 6))
                path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX + 6, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 6))
                
                if selected {
                    path.move(to: CGPoint(x: rect.minX + 3, y: rect.maxY))
                    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - 3))
                    path.move(to: CGPoint(x: rect.maxX - 3, y: rect.minY))
                    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + 3))
                }
            }
        }
        .strokedPath(.init(lineWidth: 1))
    }
}

#Preview("Segmented - tile shape") {
    VStack {
        HStack {
            SegmentedTileShape(position: .single, selected: false)
        }
        
        HStack {
            SegmentedTileShape(position: .left, selected: false)
            SegmentedTileShape(position: .right, selected: false)
        }
        
        HStack {
            SegmentedTileShape(position: .left, selected: false)
            SegmentedTileShape(position: .middle, selected: false)
            SegmentedTileShape(position: .right, selected: false)
        }
        
        Group {
            HStack {
                SegmentedTileShape(position: .single, selected: true)
            }
            
            HStack {
                SegmentedTileShape(position: .left, selected: true)
                SegmentedTileShape(position: .right, selected: true)
            }
            
            HStack {
                SegmentedTileShape(position: .left, selected: true)
                SegmentedTileShape(position: .middle, selected: true)
                SegmentedTileShape(position: .right, selected: true)
            }
        }
        .foregroundStyle(Color.accentColor)
    }
    .padding()
}

struct SelectionAlignmentGuide: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static var selection: HorizontalAlignment {
        HorizontalAlignment(SelectionAlignmentGuide.self)
    }
}

extension Alignment {
    static var selection: Alignment {
        Alignment(horizontal: .selection, vertical: .center)
    }
}

struct SegmentedControl: View {
    var titles: [String]
    var selection: Binding<String>?
    @State private var _selection: Int?
    @State private var maxSize: CGSize?
    
    private var position: SegmentedBackgroundClipShape.Position? {
        guard let _selection else { return nil }
        
        guard titles.count > 1 else { return .single }
        
        if titles.indices.first == _selection {
            return .left
        } else if titles.indices.last == _selection {
            return .right
        } else {
            return .middle
        }
    }
    
    var body: some View {
        ZStack(alignment: .selection) {
            HStack(spacing: 2) {
                ForEach(titles.indices, id: \.self) { index in
                    Group {
                        if index == _selection {
                            titleBackgroundView(index)
                                .alignmentGuide(.selection) { d in
                                    d[HorizontalAlignment.center]
                                }
                                .foregroundStyle(Color.accentColor.opacity(0.75))
                        } else {
                            titleBackgroundView(index)
                        }
                    }
                    .frame(width: maxSize?.width, height: maxSize?.height)
                }
            }
            
            if let position {
                SegmentedBackgroundClipShape(position: position)
                    .padding(3)
                    .frame(width: maxSize?.width, height: maxSize?.height)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.accentColor.opacity(0.65), .accentColor],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .background {
                        SegmentedBackgroundClipShape(position: position)
                            .foregroundStyle(Color.accentColor)
                            .inverseMask {
                                SegmentedBackgroundClipShape(position: position)
                                    .padding(1.5)
                            }
                            .padding(1.5)
                            .blur(radius: 2)
                    }
                    .alignmentGuide(.selection) { d in
                        d[HorizontalAlignment.center]
                    }
            }
            
            HStack(spacing: 2) {
                ForEach(titles.indices, id: \.self) { index in
                    titleView(index)
                        .provideMaxSize()
                        .frame(width: maxSize?.width, height: maxSize?.height)
                }
            }
            .readMaxSize($maxSize)
        }
    }
    
    init(titles: [String], selection: Binding<String>? = nil) {
        self.titles = titles
        self.selection = selection
    }
    
    func isSelected(index: Int) -> Bool {
        _selection == index
    }
    
    @ViewBuilder private func titleView(_ index: Int) -> some View {
        let sharedView = Text(titles[index])
            .tag(index)
            .padding(8)
            .contentShape(Rectangle())
            .frame(minWidth: 60)
            .fixedSize(horizontal: true, vertical: false)
        
        if isSelected(index: index) {
            sharedView
                .alignmentGuide(.selection) { d in
                    d[HorizontalAlignment.center]
                }
                .foregroundStyle(.background)
                .fontWeight(.medium)
        } else {
            sharedView
                .onTapGesture {
                    withAnimation {
                        _selection = index
                    }
                }
        }
    }
    
    @ViewBuilder private func titleBackgroundView(_ index: Int) -> some View {
        let position: SegmentedTileShape.Position = {
            guard titles.count > 1 else { return .single }
            
            switch index {
            case 0: return .left
            case titles.indices.last: return .right
            default: return .middle
            }
        }()
        
        let isSelected = selection?.wrappedValue == titles[index]
        
        SegmentedTileShape(position: position, selected: isSelected)
    }
}

#Preview("Segmented") {
    VStack {
        SegmentedControl(titles: ["Single"])
        SegmentedControl(titles: ["First", "Second"])
        SegmentedControl(titles: ["First", "Second", "Third"])
    }
}

struct MaxSizeReader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: MaxSizePreferenceKey.self, value: geometry.size)
                }
            }
    }
}

extension View {
    @ViewBuilder func provideMaxSize() -> some View {
        modifier(MaxSizeReader())
    }
    
    @ViewBuilder func readMaxSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        onPreferenceChange(MaxSizePreferenceKey.self, perform: onChange)
    }
    
    @ViewBuilder func readMaxSize(_ binding: Binding<CGSize?>) -> some View {
        onPreferenceChange(MaxSizePreferenceKey.self) { binding.wrappedValue = $0 }
    }
}

private struct MaxSizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = max(value, nextValue())
    }
}

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        lhs.width < rhs.width || lhs.height < rhs.height
    }
}

#Preview("Max Size Reader") {
    struct P: View {
        @State private var maxSize: CGSize?
        
        var body: some View {
            ZStack {
                HStack {
                    Text("Short")
                        .provideMaxSize()
                        .frame(width: maxSize?.width)
                        .border(.red)
                    
                    Text("Long text")
                        .provideMaxSize()
                        .frame(width: maxSize?.width)
                        .border(.red)
                    
                    Text("Very long Text")
                        .provideMaxSize()
                        .frame(width: maxSize?.width)
                        .border(.red)
                }
                .readMaxSize($maxSize)
                
                if let maxSize {
                    Text("(\(maxSize.width), \(maxSize.height))")
                        .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
    }

    return P()
}
