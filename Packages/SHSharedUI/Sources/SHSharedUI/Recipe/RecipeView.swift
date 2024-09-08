import SwiftUI
import SHModels

public struct RecipeView: View {
    private let recipe: Recipe
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    public init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleView
            
            RecipeLayoutView(
                outputViewModel: RecipeIngredientViewModel(
                    ingredient: recipe.output,
                    amount: recipe.amountPerMinute(for: recipe.output)
                ),
                byproductViewModels: recipe.byproducts.map {
                    RecipeIngredientViewModel(
                        ingredient: $0,
                        amount: recipe.amountPerMinute(for: $0)
                    )
                },
                inputViewModels: recipe.inputs.map {
                    RecipeIngredientViewModel(
                        ingredient: $0,
                        amount: recipe.amountPerMinute(for: $0)
                    )
                }
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(recipe.localizedName)
                .fontWeight(.medium)
            
            Spacer()
            
            alternateIndicatorView
        }
        .frame(minHeight: 28)
    }
    
    @MainActor @ViewBuilder
    private var alternateIndicatorView: some View {
        Text("recipe-alternate")
            .font(.caption)
            .fontWeight(.light)
            .foregroundStyle(.sh(.midnight))
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(.sh(.midnight10))
                    .stroke(.sh(.midnight40), lineWidth: 1)
            }
            .foregroundStyle(.sh(.midnight100))
            .opacity(recipe.isDefault ? 0.0 : 1.0)
    }
}

#if DEBUG
import SHStorage

private struct _RecipePreview: View {
    private let recipe: Recipe
    
    init(recipeID: String) {
        @Dependency(\.storageService)
        var storageService
        
        recipe = storageService.recipe(id: recipeID)!
    }
    
    var body: some View {
        RecipeView(recipe)
    }
}

#Preview("Iron Plate") {
    _RecipePreview(recipeID: "recipe-iron-plate")
}
#endif
