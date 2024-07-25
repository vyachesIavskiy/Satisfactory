import SwiftUI
import SHModels
import SHSingleItemProduction
import SHUtils

struct RecipeIngredientAmountView: View {
    let viewModel: RecipeIngredientAmountViewModel
    
    var body: some View {
        Text(viewModel.amount, format: .shNumber)
            .multilineTextAlignment(.center)
            .font(.callout)
            .fontWeight(.medium)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .padding(.horizontal, 6)
            .frame(minWidth: 80, maxWidth: 100, minHeight: 24)
            .fixedSize(horizontal: true, vertical: false)
            .background {
                ZStack {
                    ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius)
                        .fill(viewModel.foregroundStyle)
                        .shadow(color: viewModel.shadowColor, radius: 2, y: 1)
                    
                    if let secondaryStyle = viewModel.secondaryStyle {
                        RecipeByproductShape()
                            .foregroundStyle(secondaryStyle)
                            .clipShape(ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius))
                    }
                    
                    ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius)
                        .stroke(viewModel.primaryColor, lineWidth: 1)
                }
            }
    }
}

#if DEBUG
#Preview("Recipe - Output") {
    _RecipeIngredientAmountPreview(role: .output)
}

#Preview("Recipe - Byproduct") {
    _RecipeIngredientAmountPreview(role: .byproduct)
}

#Preview("Recipe - Input") {
    _RecipeIngredientAmountPreview(role: .input)
}

#Preview("Production Recipe - Output") {
    _ProductionRecipeIngredientAmountPreview(role: .output)
}

#Preview("Production Recipe - Byproduct") {
    _ProductionRecipeIngredientAmountPreview(role: .byproduct)
}

#Preview("Production Recipe - Input") {
    _ProductionRecipeIngredientAmountPreview(role: .input)
}

#Preview("Production Recipe - Secondary byproduct (Index 0)") {
    _ProductionRecipeIngredientAmountPreview(role: .secondaryByproduct, index: 0)
}

#Preview("Production Recipe - Secondary byproduct (Index 1)") {
    _ProductionRecipeIngredientAmountPreview(role: .secondaryByproduct, index: 1)
}

private struct _RecipeIngredientAmountPreview: View {
    let role: Recipe.Ingredient.Role
    
    var body: some View {
        HStack {
            ingredientAmount(form: .solid)
            
            ingredientAmount(form: .fluid)
            
            ingredientAmount(form: .gas)
        }
    }
    
    @ViewBuilder
    private func ingredientAmount(form: Part.Form) -> some View {
        VStack {
            switch form {
            case .solid:
                Text("Solid")
                
            case .fluid:
                Text("Fluid")
                
            case .gas:
                Text("Gas")
            }
            
            RecipeIngredientAmountView(
                viewModel: RecipeIngredientAmountViewModel(
                    recipeIngredient: ingredient(role: role, form: form),
                    amount: 100
                )
            )
        }
    }
}

private struct _ProductionRecipeIngredientAmountPreview: View {
    enum Role {
        case output
        case byproduct
        case input
        case secondaryByproduct
    }
    
    let role: Role
    let index: Int?
    
    init(role: Role, index: Int? = nil) {
        self.role = role
        self.index = index
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unselected")
                .padding(.vertical)
            
            HStack {
                ingredientAmount(form: .solid, selected: false)
                
                ingredientAmount(form: .fluid, selected: false)
                
                ingredientAmount(form: .gas, selected: false)
            }
            
            Text("Selected")
                .padding(.vertical)
            
            HStack {
                ingredientAmount(form: .solid, selected: true)
                
                ingredientAmount(form: .fluid, selected: true)
                
                ingredientAmount(form: .gas, selected: true)
            }
        }
    }
    
    @ViewBuilder
    private func ingredientAmount(form: Part.Form, selected: Bool) -> some View {
        VStack {
            switch form {
            case .solid:
                Text("Solid")
                
            case .fluid:
                Text("Fluid")
                
            case .gas:
                Text("Gas")
            }
            
            let viewModel = switch role {
            case .output:
                RecipeIngredientAmountViewModel(productionOutput: productionIngredient(form: form, selected: selected))
                
            case .byproduct:
                RecipeIngredientAmountViewModel(productionByproduct: productionIngredient(form: form, selected: selected))
                
            case .input:
                RecipeIngredientAmountViewModel(productionInput: productionIngredient(form: form, selected: selected))
                
            case .secondaryByproduct:
                RecipeIngredientAmountViewModel(
                    productionSecondaryByproduct: productionSecondaryByproduct(index: index ?? 0),
                    item: part(form: form)
                )
            }
            
            RecipeIngredientAmountView(viewModel: viewModel)
        }
    }
}

private func part(form: Part.Form) -> Part {
    Part(id: "preview-part", category: .special, progressionIndex: 0, form: form)
}

private func ingredient(role: Recipe.Ingredient.Role, form: Part.Form) -> Recipe.Ingredient {
    Recipe.Ingredient(
        role: role,
        item: part(form: form),
        amount: 0
    )
}

private func productionIngredient(form: Part.Form, selected: Bool) -> SHSingleItemProduction.OutputRecipe.OutputIngredient {
    SHSingleItemProduction.OutputRecipe.OutputIngredient(
        item: Part(id: "preview-part", category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: [],
        isSelected: selected
    )
}

private func productionIngredient(form: Part.Form, selected: Bool) -> SHSingleItemProduction.OutputRecipe.InputIngredient {
    SHSingleItemProduction.OutputRecipe.InputIngredient(
        producingProductID: nil,
        item: Part(id: "preview-part", category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: [],
        isSelected: selected
    )
}

private func productionSecondaryByproduct(index: Int) -> SHSingleItemProduction.OutputRecipe.Byproduct {
    SHSingleItemProduction.OutputRecipe.Byproduct(index: index, amount: 10)
}
#endif
