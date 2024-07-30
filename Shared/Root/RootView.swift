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
        VStack {
            Text("Failed to load application. Please try again later.")
            
            Button("Show error details") {
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

#Preview("Root view") {
    RootView()
}
