import SwiftUI

struct SheetsDemo: View {
    @GestureState
    private var dragTranslation = CGSize.zero
    
    var body: some View {
        ZStack {
//            Color.sh(.orange)
//                .ignoresSafeArea()
            
            Text("\(dragTranslation)")
                .frame(maxHeight: .infinity, alignment: .top)
            
            content
                .frame(maxWidth: .infinity)
                .frame(height: 200 - dragTranslation.height)
                .background {
                    AngledRectangle(cornerRadius: 12, corners: .topLeft)
                        .foregroundStyle(.background)
                        .ignoresSafeArea()
                }
                .shadow(color: .sh(.midnight), radius: 4, y: -2)
                .gesture(
                    DragGesture()
                        .updating($dragTranslation) { value, state, _ in
                            state = value.translation
                        }
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    @MainActor @ViewBuilder
    private var content: some View {
        VStack {
            Text("Content")
        }
    }
}

#if DEBUG
#Preview("Demo") {
    SheetsDemo()
}
#endif
