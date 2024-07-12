import SwiftUI

struct RecipeAdjustmentView: View {
    @Bindable
    var viewModel: RecipeAdjustmentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(viewModel.recipe.model.localizedName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 8) {
                    if viewModel.allowAdjustment {
                        ProductionProportionView($viewModel.proportion, totalAmount: viewModel.recipe.output.amount)
                    }
                    
                    if viewModel.allowDeletion {
                        Button {
                            viewModel.onDelete()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.shTinted)
                        .tint(.sh(.red))
                    }
                }
            }
            .frame(minHeight: 24)
            
            SingleItemProductionRecipeDisplayView(
                viewModel: SingleItemProductionRecipeDisplayViewModel(
                    recipe: viewModel.recipe
                )
            )
        }
    }
}
