import SwiftUI

private struct ScrollOffsetReaderPreferenceKey: PreferenceKey {
    static let defaultValue = CGPoint.zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

struct ScrollOffsetReader: View {
    @Binding var offset: CGPoint
    
    init(_ offset: Binding<CGPoint>) {
        self._offset = offset
    }
    
    var body: some View {
        GeometryReader { g in
            Color.clear
                .preference(key: ScrollOffsetReaderPreferenceKey.self, value: g.frame(in: .scrollView).origin)
        }
        .onPreferenceChange(ScrollOffsetReaderPreferenceKey.self) { value in
            if offset.x != -value.x || offset.y != -value.y {
                offset = CGPoint(x: -value.x, y: -value.y)
            }
        }
        .frame(height: 0)
    }
}

#if DEBUG
private struct _ScrollOffsetReaderPreview: View {
    @State private var scrollOffset = CGPoint.zero
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(spacing: 0) {
                ScrollOffsetReader($scrollOffset)
                
                VStack {
                    ForEach(0..<20) { index in
                        Rectangle()
                            .foregroundStyle(.orange)
                            .frame(width: 600, height: 40)
                    }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Text(verbatim: "[x: \(scrollOffset.x), y: \(scrollOffset.y)]")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding([.trailing, .top], 4)
        }
    }
}

#Preview("Scroll view reader") {
    _ScrollOffsetReaderPreview()
}
#endif
