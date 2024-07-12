import SHModels
import SwiftUI

struct RecipeIngredientRowView: View {
    let viewModel: RecipeIngredientViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(viewModel.item.id)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(.horizontal, 4)
                
                Text(viewModel.item.localizedName)
                    .font(.callout)
                    .minimumScaleFactor(0.7)
                    .lineLimit(2)
            }

            HStack(spacing: 4) {
                ForEach(Array(viewModel.amountViewModels().enumerated()), id: \.offset) { _, viewModel in
                    RecipeIngredientAmountView(viewModel: viewModel)
                }
            }
        }
    }
}

#if DEBUG
#Preview("Display Output") {
    _DisplayIngredientPreview(role: .output)
}

#Preview("Display Byproduct") {
    _DisplayIngredientPreview(role: .byproduct)
}

#Preview("Display Input") {
    _DisplayIngredientPreview(role: .input)
}

#Preview("Production Output") {
    _ProductionIngredientPreview(role: .output)
}

#Preview("Production Byproduct") {
    _ProductionIngredientPreview(role: .byproduct)
}

#Preview("Production Input") {
    _ProductionIngredientPreview(role: .input)
}

#Preview("Production Output (1 byproduct)") {
    _ProductionIngredientPreview(role: .output, byproductCount: 1)
}

#Preview("Production Byproduct (1 byproduct)") {
    _ProductionIngredientPreview(role: .byproduct, byproductCount: 1)
}

#Preview("Production Input (1 byproduct)") {
    _ProductionIngredientPreview(role: .input, byproductCount: 1)
}

#Preview("Production Output (2 byproduct)") {
    _ProductionIngredientPreview(role: .output, byproductCount: 2)
}

#Preview("Production Byproduct (2 byproduct)") {
    _ProductionIngredientPreview(role: .byproduct, byproductCount: 2)
}

#Preview("Production Input (2 byproduct)") {
    _ProductionIngredientPreview(role: .input, byproductCount: 2)
}

private struct _DisplayIngredientPreview: View {
    let role: Recipe.Ingredient.Role
    
    var body: some View {
        VStack {
            ingredient(form: .solid)
            
            ingredient(form: .fluid)
            
            ingredient(form: .gas)
        }
    }
    
    @ViewBuilder
    private func ingredient(form: Part.Form) -> some View {
        HStack(spacing: 48) {
            switch form {
            case .solid:
                Text("Solid")
                
            case .fluid:
                Text("Fluid")
                
            case .gas:
                Text("Gas")
            }
            
            RecipeIngredientRowView(
                viewModel: RecipeIngredientViewModel(
                    displayIngredient: displayIngredient(role: role, form: form),
                    amount: 10
                )
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}

private struct _ProductionIngredientPreview: View {
    enum Role {
        case output
        case byproduct
        case input
    }
    
    let role: Role
    let byproductCount: Int
    
    init(role: Role, byproductCount: Int = 0) {
        self.role = role
        self.byproductCount = byproductCount
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unselected")
                .padding(.vertical)
            
            VStack {
                ingredient(form: .solid, selected: false)
                
                ingredient(form: .fluid, selected: false)
                
                ingredient(form: .gas, selected: false)
            }
            
            Text("Selected")
                .padding(.vertical)
            
            VStack {
                ingredient(form: .solid, selected: true)
                
                ingredient(form: .fluid, selected: true)
                
                ingredient(form: .gas, selected: true)
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func ingredient(form: Part.Form, selected: Bool) -> some View {
        HStack(spacing: 48) {
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
                RecipeIngredientViewModel(
                    productionOutput: productionIngredient(
                        form: form,
                        selected: selected,
                        byproductCount: byproductCount
                    )
                )
                
            case .byproduct:
                RecipeIngredientViewModel(
                    productionByproduct: productionIngredient(
                        form: form,
                        selected: selected,
                        byproductCount: byproductCount
                    )
                )
                
            case .input:
                RecipeIngredientViewModel(
                    productionInput: productionIngredient(
                        form: form,
                        selected: selected,
                        byproductCount: byproductCount
                    )
                )
            }
            
            RecipeIngredientRowView(viewModel: viewModel)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private func part(form: Part.Form) -> Part {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return Part(id: id, category: .special, progressionIndex: 0, form: form)
}

private func displayIngredient(role: Recipe.Ingredient.Role, form: Part.Form) -> Recipe.Ingredient {
    Recipe.Ingredient(role: role, item: part(form: form), amount: 10)
}

private func productionIngredient(form: Part.Form, selected: Bool, byproductCount: Int = 0) -> SingleItemProduction.Output.Recipe.OutputIngredient {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return SingleItemProduction.Output.Recipe.OutputIngredient(
        item: Part(id: id, category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: (0..<byproductCount).map {
            SingleItemProduction.Output.Recipe.Byproduct(index: $0, amount: 10)
        },
        isSelected: selected
    )
}

private func productionIngredient(form: Part.Form, selected: Bool, byproductCount: Int = 0) -> SingleItemProduction.Output.Recipe.InputIngredient {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return SingleItemProduction.Output.Recipe.InputIngredient(
        producingProductID: nil,
        item: Part(id: id, category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: (0..<byproductCount).map {
            SingleItemProduction.Output.Recipe.Byproduct(index: $0, amount: 10)
        },
        isSelected: selected
    )
}

private func productionSecondaryByproduct(index: Int) -> SingleItemProduction.Output.Recipe.Byproduct {
    SingleItemProduction.Output.Recipe.Byproduct(index: index, amount: 10)
}
#endif
