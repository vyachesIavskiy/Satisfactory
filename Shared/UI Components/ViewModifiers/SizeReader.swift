import SwiftUI
import SHUtils

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
    // MARK: Size
    @ViewBuilder
    func readSize(_ onChange: @escaping (CGSize) -> Void) -> some View {
        modifier(SizeReader(onChange: onChange))
    }
    
    @ViewBuilder
    func readSize(_ size: Binding<CGSize>) -> some View {
        readSize { size.wrappedValue = $0 }
    }
    
    @ViewBuilder
    func readSize(_ size: Binding<CGSize?>) -> some View {
        readSize { size.wrappedValue = $0 }
    }
    
    // MARK: Max Size
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
        VStack(spacing: 24) {
            Text("The size of this text will be read and prompted below")
                .multilineTextAlignment(.center)
                .border(.orange, width: 1)
                .readSize($size)
            
            Text("[w: \(size.width.formatted(.shNumber)), h: \(size.height.formatted(.shNumber))]")
                .foregroundStyle(.orange)
        }
    }
}

private struct _MaxSizeReaderPreview: View {
    @State private var size1 = CGSize.zero
    @State private var size2 = CGSize.zero
    @State private var maxSize = CGSize.zero
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Small text in orange border")
                .multilineTextAlignment(.center)
                .border(.orange, width: 1)
                .provideMaxSize()
                .readSize($size1)
            
            Text("Bigger test in red border that will hold a couple of additional words to represent bigger UI control")
                .multilineTextAlignment(.center)
                .border(.red, width: 2)
                .provideMaxSize()
                .readSize($size2)
            
            HStack {
                Text("[w: \(size1.width.formatted(.shNumber)), h: \(size1.height.formatted(.shNumber))]")
                    .foregroundStyle(.orange)
                
                Text("[w: \(size2.width.formatted(.shNumber)), h: \(size2.height.formatted(.shNumber))]")
                    .foregroundStyle(.red)
            }
            
            Text("Max: [w: \(maxSize.width.formatted(.shNumber)), h: \(maxSize.height.formatted(.shNumber))]")
                .foregroundStyle(size1 == maxSize ? .orange : .red)
                .bold()
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
