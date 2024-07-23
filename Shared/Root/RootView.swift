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
                
            case let .failed(error):
                loadingFailedView(error)
            }
        }
        .showIngredientNames(viewModel.showIngredientNames)
        .task {
            await viewModel.load()
        }
        .task {
            await viewModel.observeSettings()
        }
    }
    
    @MainActor @ViewBuilder
    private func loadingFailedView(_ error: Error) -> some View {
        VStack {
            Text("Failed to load application. Please try again later.")
            
            Button("Show error details") {
                withAnimation {
                    viewModel.showErrorDetails = true
                }
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
