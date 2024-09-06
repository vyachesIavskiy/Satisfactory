import SwiftUI
import SHModels
import SHUtils

struct SingleItemCalculatorContainerView: View {
    @State
    var viewModel: SingleItemCalculatorContainerViewModel
    
    init(item: any Item) {
        _viewModel = State(initialValue: SingleItemCalculatorContainerViewModel(item: item))
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
                SingleItemCalculatorContainerView(item: item)
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
