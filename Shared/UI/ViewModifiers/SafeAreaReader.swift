import SwiftUI

struct SafeAreaReader: ViewModifier {
    private let onChange: @MainActor (EdgeInsets) -> Void
    
    @MainActor
    init(_ onChange: @MainActor @escaping (EdgeInsets) -> Void) {
        self.onChange = onChange
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { g in
                    Color.clear
                        .preference(key: SafeAreaPreferenceKey.self, value: g.safeAreaInsets)
                }
            }
            .onPreferenceChange(SafeAreaPreferenceKey.self) { value in
                onChange(value)
            }
    }
}

private struct SafeAreaPreferenceKey: PreferenceKey {
    static var defaultValue = EdgeInsets()
    
    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {}
}

extension View {
    @MainActor @ViewBuilder
    func readSafeArea(_ onChange: @MainActor @escaping (EdgeInsets) -> Void) -> some View {
        modifier(SafeAreaReader(onChange))
    }
    
    @MainActor @ViewBuilder
    func readSafeArea(_ binding: Binding<EdgeInsets>) -> some View {
        readSafeArea {
            binding.wrappedValue = $0
        }
    }
}

#if DEBUG
#Preview("No safe area") {
    _NoSafeAreaPreview()
}

#Preview("Safe area") {
    _SafeAreaPreview()
}

private struct _NoSafeAreaPreview: View {
    @State
    private var safeAreaInsets = EdgeInsets()
    
    var body: some View {
        Text("\(safeAreaInsets)")
            .multilineTextAlignment(.center)
            .readSafeArea($safeAreaInsets)
            .border(.sh(.green))
    }
}

private struct _SafeAreaPreview: View {
    @State
    private var safeAreaInsets = EdgeInsets()
    
    var body: some View {
        ZStack {
            Color.sh(.orange)
                .readSafeArea($safeAreaInsets)
                .border(.sh(.green))
            
            Text("\(safeAreaInsets)")
                .multilineTextAlignment(.center)
        }
    }
}
#endif
