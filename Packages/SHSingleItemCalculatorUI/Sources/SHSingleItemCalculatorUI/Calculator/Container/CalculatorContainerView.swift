import SwiftUI
import SHModels
import SHUtils

struct CalculatorContainerView: View {
    @State
    var viewModel: CalculatorContainerViewModel
    
    init(item: any Item) {
        _viewModel = State(initialValue: CalculatorContainerViewModel(item: item))
    }
    
    init(production: SingleItemProduction) {
        _viewModel = State(initialValue: CalculatorContainerViewModel(production: production))
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initialRecipeSelection(let viewModel):
                InitialRecipeSelectionView(viewModel: viewModel)
                
            case .calculation(let viewModel):
                CalculatorView(viewModel: viewModel)
            }
        }
        #if os(iOS)
        .toolbar(.hidden, for: .bottomBar, .tabBar)
        #endif
        .animation(.default, value: viewModel.state)
    }
}

#if DEBUG
import SHStorage

private struct _CalculatorContainerPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            NavigationStack {
                CalculatorContainerView(item: item)
            }
        } else {
            Text(verbatim: "There is no item with id '\(itemID)'")
        }
    }
}

#Preview {
    _CalculatorContainerPreview(itemID: "part-plastic")
}
#endif
