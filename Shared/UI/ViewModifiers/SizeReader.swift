import SwiftUI

struct SizeReader: ViewModifier {
    private struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGSize { .zero }
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
    }
    
    var onChange: (CGSize) -> Void
    
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
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReader(onChange: onChange))
    }
    
    func readSize(_ size: Binding<CGSize>) -> some View {
        modifier(SizeReader { newSize in
            size.wrappedValue = newSize
        })
    }
}

struct SizeReader_Previews: PreviewProvider {
    private struct Preview: View {
        @State private var size = CGSize.zero
        
        var body: some View {
            Text("(\(size.width), \(size.height))")
                .readSize($size)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
