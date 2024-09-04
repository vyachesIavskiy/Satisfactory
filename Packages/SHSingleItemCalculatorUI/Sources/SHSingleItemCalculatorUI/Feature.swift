import SwiftUI
import SHModels

public enum SHSingleItemCalculator {
    @MainActor
    public static func itemSelection(itemSelected: @escaping @MainActor (any Item) -> Void) -> some View {
        let viewModel = ItemSelectionViewModel(itemSelected: itemSelected)
        return ItemSelectionView(viewModel: viewModel)
    }
    
    @MainActor
    public static func newProduction(_ item: any Item) -> some View {
        CalculatorContainerView(item: item)
    }
    
    @MainActor
    public static func editProduction(_ production: SingleItemProduction) -> some View {
        CalculatorContainerView(production: production)
    }
}
