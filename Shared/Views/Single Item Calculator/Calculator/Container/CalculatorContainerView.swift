import SwiftUI
import SHModels
import SHUtils

struct SingleItemCalculatorContainerView: View {
    @State
    private var viewModel: SingleItemCalculatorContainerViewModel
    
    init(part: Part) {
        _viewModel = State(initialValue: SingleItemCalculatorContainerViewModel(part: part))
    }
    
    init(production: Production) {
        _viewModel = State(initialValue: SingleItemCalculatorContainerViewModel(production: production))
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initialRecipeSelection(let viewModel):
                SingleItemCalculatorInitialRecipeSelectionView(viewModel: viewModel)
                
            case .calculation(let viewModel):
                SingleItemCalculatorView(viewModel: viewModel)
            }
        }
        #if os(iOS)
        .toolbar(.hidden, for: .bottomBar, .tabBar)
        #endif
        .navigationBarTitleDisplayMode(.inline)
        .animation(.default, value: viewModel.state)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        SingleItemCalculatorContainerView(part: part(id: "part-plastic"))
    }
}
#endif
