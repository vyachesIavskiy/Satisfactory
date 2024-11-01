import SwiftUI
import SHSharedUI

struct RecipeAdjustmentView: View {
    @State
    var viewModel: RecipeAdjustmentViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(viewModel.recipe.recipe.localizedName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    if viewModel.allowAdjustment {
                        ProportionView(viewModel: viewModel.proportionViewModel())
                    }
                    
                    if viewModel.allowDeletion {
                        Button {
                            viewModel.onDelete()
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.shBordered)
                        .tint(.sh(.red))
                    }
                }
            }
            .frame(minHeight: 28)
            
            ZStack {
                RecipeDisplayView(viewModel.recipe)
                    .opacity(viewModel.willBeRemoved ? 0.3 : 1.0)
                    .grayscale(viewModel.willBeRemoved ? 1.0 : 0.0)
                
                if viewModel.willBeRemoved {
                    Text("adjust-recipe-will-be-deleted")
                        .font(.title3)
                        .foregroundStyle(.sh(.red))
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .background {
                            AngledRectangle(cornerRadius: 12)
                                .fill(.sh(.red10))
                                .stroke(.sh(.red), lineWidth: 2 / displayScale)
                        }
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}

#if DEBUG
import SHStorage
import SHModels
import SHSingleItemCalculator

private struct _RecipeAdjustmentPreview: View {
    let recipeID: String
    
    private var outputRecipe: SingleItemCalculator.OutputRecipe? {
        @Dependency(\.storageService)
        var storageService
        
        let recipe = storageService.recipe(id: recipeID)
        
        return recipe.map {
            SingleItemCalculator.OutputRecipe(
                recipe: $0,
                output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                    part: $0.output.part,
                    amount: 20
                ),
                byproducts: $0.byproducts.map {
                    SingleItemCalculator.OutputRecipe.ByproductIngredient(
                        part: $0.part,
                        amount: 20,
                        byproducts: [],
                        isSelected: false
                    )
                },
                inputs: $0.inputs.map {
                    SingleItemCalculator.OutputRecipe.InputIngredient(
                        part: $0.part,
                        amount: 20,
                        byproducts: [],
                        isSelected: false
                    )
                },
                proportion: .fixed(20)
            )
        }
    }
    
    private var viewModel: RecipeAdjustmentViewModel? {
        outputRecipe.map {
            RecipeAdjustmentViewModel(
                recipe: $0,
                itemAmount: 20,
                allowAdjustment: true,
                allowDeletion: true,
                showRecipeProportionTip: true,
                onChange: { _ in },
                onDelete: {}
            )
        }
    }
    
    var body: some View {
        if let viewModel {
            RecipeAdjustmentView(viewModel: viewModel)
        } else {
            Text(verbatim: "There is no recipe with id '\(recipeID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview("Heavy Modular Frame") {
    _RecipeAdjustmentPreview(recipeID: "recipe-heavy-modular-frame")
        .padding()
}
#endif
