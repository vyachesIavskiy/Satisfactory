import SwiftUI

struct RootView: View {
    let viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.loadingState {
            case .loading:
                ProgressView()
                
            case .loaded:
                TabsView(viewModel: TabsViewModel())
                
            case let .failed(error):
                loadingFailedView(error)
            }
        }
        .task {
            await viewModel.load()
        }
    }
    
    @ViewBuilder
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
            }
        }
        .padding()
    }
}

#Preview("Root view") {
    RootView()
}
