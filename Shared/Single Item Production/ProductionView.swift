import SwiftUI
import SHModels
import SHUtils

struct ProductionView: View {
    @State
    var viewModel: ProductionViewModel
    
    init(item: any Item) {
        _viewModel = State(initialValue: ProductionViewModel(item: item))
    }
    
    init(production: Production) {
        _viewModel = State(initialValue: ProductionViewModel(production: production))
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

private struct _ProductionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            NavigationStack {
                ProductionView(item: item)
            }
        } else {
            Text("There is no item with id '\(itemID)'")
        }
    }
}

#Preview {
    _ProductionPreview(itemID: "part-plastic")
}
#endif

extension String: @retroactive Identifiable {
    public var id: String { self }
}
