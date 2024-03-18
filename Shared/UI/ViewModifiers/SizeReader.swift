import SwiftUI

struct SizeReader: ViewModifier {
    private struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGSize { .zero }
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
    }
    
    private var onChange: (CGSize) -> Void
    
    fileprivate init(_ onChange: @escaping (CGSize) -> Void) {
        self.onChange = onChange
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: PreferenceKey.self, value: proxy.size)
                }
            }
            .onPreferenceChange(PreferenceKey.self, perform: onChange)
    }
}

extension View {
    @ViewBuilder func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReader(onChange))
    }
    
    @ViewBuilder func readSize(_ size: Binding<CGSize>) -> some View {
        readSize { size.wrappedValue = $0 }
    }
}

#Preview("Size Reader") {
    struct Preview: View {
        @State private var size = CGSize.zero
        
        var body: some View {
            Text("(\(size.width), \(size.height))")
                .readSize($size)
        }
    }
    
    return Preview()
}
