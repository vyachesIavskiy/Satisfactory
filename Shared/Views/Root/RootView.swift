import SwiftUI

struct RootView: View {
    @State
    private var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
                
            case .loaded:
                TabsView()
                    .task {
                        await viewModel.observeSettings()
                    }
                
            case let .failed(error):
                loadingFailedView(error)
            }
        }
        .showIngredientNames(viewModel.showIngredientNames)
        .task {
            await viewModel.load()
        }
    }
    
    @MainActor @ViewBuilder
    private func loadingFailedView(_ error: Error) -> some View {
        VStack(spacing: 60) {
            Text("root-failed-to-load-application")
                .font(.title3)
                .multilineTextAlignment(.center)
            
            Button("root-show-error-details") {
                viewModel.showErrorDetails = true
            }
            
            if viewModel.showErrorDetails {
                Text(error.localizedDescription)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding()
        .animation(.default, value: viewModel.showErrorDetails)
    }
}

#if DEBUG
#Preview("Root view") {
    RootView()
}
#endif
