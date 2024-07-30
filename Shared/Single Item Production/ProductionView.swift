import SwiftUI
import SHModels
import SHUtils

struct ProductionView: View {
    @Bindable
    var viewModel: ProductionViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    @FocusState
    private var focused
    
    @Namespace
    private var namespace
    
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
    
    @State
    private var viewModel: ProductionViewModel?
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        self.itemID = itemID
        _viewModel = State(initialValue: storageService.item(id: itemID).map { item in
            ProductionViewModel(item: item)
        })
    }
    
    var body: some View {
        if let viewModel {
            NavigationStack {
                ProductionView(viewModel: viewModel)
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
