import SwiftUI

struct NavigationBar<Content: View, Buttons: View>: View {
    private let content: Content
    private let buttons: Buttons
    
    @MainActor
    init(
        @ViewBuilder content: @MainActor () -> Content,
        @ViewBuilder buttons: @MainActor () -> Buttons
    ) {
        self.content = content()
        self.buttons = buttons()
    }
    
    @MainActor
    init(@ViewBuilder content: @MainActor () -> Content) where Buttons == EmptyView {
        self.init {
            content()
        } buttons: {
            EmptyView()
        }

    }
    
    var body: some View {
        VStack {
            buttons
            
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .foregroundStyle(.sh(.gray10))
                .ignoresSafeArea(edges: .top)
                .shadow(color: .sh(.midnight20), radius: 2, y: 2)
        }
    }
}

#if DEBUG
#Preview("Navigation bar") {
    _NavigationBarPreview {
        NavigationBar {
            Text("Hello, world!")
        } buttons: {
            HStack {
                Button("Cancel") {}
                    .buttonStyle(.toolbar(role: .cancel))
                
                Spacer()
                
                Button("Done") {}
                    .buttonStyle(.toolbar(role: .confirm))
            }
        }
    }
}

#Preview("Navigation bar (Content only)") {
    _NavigationBarPreview {
        NavigationBar {
            Text("Hello, world!")
        }
    }
}

private struct _NavigationBarPreview<NavigationBar: View>: View {
    private let navigationBar: NavigationBar
    
    @GestureState
    private var offset = 0.0
    
    @MainActor
    init(@ViewBuilder navigationBar: @MainActor () -> NavigationBar) {
        self.navigationBar = navigationBar()
    }
    
    var body: some View {
        ZStack {
            navigationBar
                .offset(y: offset)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(
            DragGesture()
                .updating($offset) { value, state, _ in
                    state = value.translation.height
                }
        )
    }
}
#endif
