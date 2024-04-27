import SwiftUI

private struct SizeReader: ViewModifier {
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

private struct MaxSizeProvider: ViewModifier {
    fileprivate struct PreferenceKey: SwiftUI.PreferenceKey {
        static let defaultValue = CGSize.zero
        
        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            let nextValue = nextValue()
            value.width = max(value.width, nextValue.width)
            value.height = max(value.height, nextValue.height)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: PreferenceKey.self, value: proxy.size)
                }
            }
    }
}

extension View {
    @ViewBuilder
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReader(onChange: onChange))
    }
    
    @ViewBuilder
    func readSize(_ size: Binding<CGSize>) -> some View {
        readSize { size.wrappedValue = $0 }
    }
    
    @ViewBuilder
    func provideMaxSize() -> some View {
        modifier(MaxSizeProvider())
    }
    
    @ViewBuilder
    func readMaxSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        onPreferenceChange(MaxSizeProvider.PreferenceKey.self, perform: onChange)
    }
    
    @ViewBuilder
    func readMaxSize(_ size: Binding<CGSize>) -> some View {
        readMaxSize { size.wrappedValue = $0 }
    }
}

#if DEBUG
private struct _SizeReaderPreview: View {
    @State private var size = CGSize.zero
    
    var body: some View {
        Text("(\(size.width), \(size.height))")
            .readSize($size)
    }
}

private struct _MaxSizeReaderPreview: View {
    @State private var size1 = CGSize.zero
    @State private var size2 = CGSize.zero
    @State private var maxSize = CGSize.zero
    
    var body: some View {
        VStack {
            Text("Text 1 size is (\(size1.width), \(size1.height))")
                .provideMaxSize()
                .readSize($size1)
            
            Text("Text 2 should be bigger with it's size is (\(size2.width), \(size2.height))")
                .provideMaxSize()
                .readSize($size2)
            
            Text("Max size is (\(maxSize.width), \(maxSize.height))")
        }
        .readMaxSize($maxSize)
    }
}

#Preview("Read size") {
    _SizeReaderPreview()
}

#Preview("Read max size") {
    _MaxSizeReaderPreview()
}
#endif
