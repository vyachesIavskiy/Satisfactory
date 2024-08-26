import SwiftUI
import SHModels
import SHUtils

struct SingleItemProductionView: View {
    @State
    var viewModel: SingleItemProductionViewModel
    
    init(item: any Item) {
        _viewModel = State(initialValue: SingleItemProductionViewModel(item: item))
    }
    
    init(production: SingleItemProduction) {
        _viewModel = State(initialValue: SingleItemProductionViewModel(production: production))
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initialRecipeSelection(let viewModel):
                InitialRecipeSelectionView(viewModel: viewModel)
                
            case .calculation(let viewModel):
                CalculationView(viewModel: viewModel)
            }
        }
        .toolbar(.hidden, for: .bottomBar, .tabBar)
        .animation(.default, value: viewModel.state)
    }
}

#if DEBUG
import SHStorage

private struct _SingleItemProductionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            NavigationStack {
                SingleItemProductionView(item: item)
            }
        } else {
            Text("There is no item with id '\(itemID)'")
        }
    }
}

#Preview {
    _SingleItemProductionPreview(itemID: "part-plastic")
}
#endif
