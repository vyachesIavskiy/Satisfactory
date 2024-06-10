import SwiftUI
import SHModels

struct RecipeProductionGroupView: View {
    let item: any Item
    let recipes: [Recipe]
    
    private var amount: Double {
        1.0
    }
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Namespace
    private var namespace
    
    @ScaledMetric(relativeTo: .body)
    private var titleSpacing = 8.0
    
    @ScaledMetric(relativeTo: .body)
    private var groupSpacing = 12.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: groupSpacing) {
            if recipes.count > 1 {
                HStack {
                    Text(item.localizedName)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.sh(.midnight40))
                    
                    Spacer()
                    
                    Text(amount, format: .fractionFromZeroToFour)
                        .fontWeight(.bold)
                        .foregroundStyle(.sh(.midnight))
                }
            }
            
            ForEach(recipes) { recipe in
                VStack(alignment: .leading, spacing: titleSpacing) {
                    HStack {
                        Text(recipe.localizedName)
                        
                        if recipes.count > 1 {
                            Spacer()
                            
                            calculationModeView()
                        }
                    }
                    .fontWeight(.medium)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    RecipeProductionView(viewModel: RecipeProductionViewModel(entry: ProductionRecipeEntry(item: recipe.output.item, recipe: recipe, amounts: (10.0, 20.0))))
                        .matchedGeometryEffect(id: recipe.id, in: namespace)
                }
                .padding(.horizontal, recipes.count > 1 ? 16 : 0)
            }
        }
        .background(.background, in: AngledRectangle(cornerRadius: 12).inset(by: -12))
        .contentShape(.interaction, Rectangle())
        .contentShape(.contextMenuPreview, AngledRectangle(cornerRadius: 12).inset(by: -12))
    }
    
    @ViewBuilder
    private func calculationModeView() -> some View {
        HStack {
            Group {
                Image(systemName: "textformat.123")
                
                Image(systemName: "percent")
            }
            .font(.caption)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .frame(minWidth: 30, maxHeight: .infinity)
            .background(
                .sh(.midnight),
                in: AngledRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2 / displayScale)
            )
            .foregroundStyle(.sh(.midnight))
        }
    }
}

#if DEBUG
import SHStorage

private struct _RecipeProductionGroupPreview: View {
    let itemID: String
    let recipeIDs: [String]
    
    var item: (any Item)? {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: itemID)
    }
    
    var recipes: [Recipe] {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes(for: itemID, as: .output).filter { recipeIDs.contains($0.id) }
    }
    
    var body: some View {
        if let item {
            RecipeProductionGroupView(item: item, recipes: recipes)
                .padding()
        } else {
            Text("'\(itemID)' not found")
                .multilineTextAlignment(.center)
                .foregroundStyle(.red)
        }
    }
}

#Preview("1 recipe") {
    _RecipeProductionGroupPreview(itemID: "part-iron-plate", recipeIDs: ["recipe-iron-plate"])
}

#Preview("2 recipes") {
    _RecipeProductionGroupPreview(itemID: "part-iron-plate", recipeIDs: [
        "recipe-iron-plate",
        "recipe-alternate-coated-iron-plate"
    ])
}
#endif
