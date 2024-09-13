import SwiftUI
import SHModels
import SHUtils

struct SingleItemCalculatorContainerView: View {
    @State
    private var viewModel: SingleItemCalculatorContainerViewModel
    
    init(part: Part) {
        _viewModel = State(initialValue: SingleItemCalculatorContainerViewModel(part: part))
    }
    
    init(production: SingleItemProduction) {
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
        .animation(.default, value: viewModel.state)
    }
}

#if DEBUG
#Preview {
    SingleItemCalculatorContainerView(part: part(id: "part-plastic"))
}
#endif
