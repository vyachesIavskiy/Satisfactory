import SwiftUI
import SHDependencies
import SHSettings
import SHStorage
import SHModels

@Observable
final class RecipeProductionViewModel {
    let entry: ProductionRecipeEntry
    private(set) var viewMode: ViewMode
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    var settingsService
    
    init(entry: ProductionRecipeEntry) {
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        self.entry = entry
        self.viewMode = settings().viewMode
    }
    
    @MainActor
    func observeViewMode() async {
        for await viewMode in settingsService.settings().map(\.viewMode) {
            guard !Task.isCancelled else { break }
            
            if self.viewMode != viewMode {
                self.viewMode = viewMode
            }
        }
    }
}

struct RecipeProductionView: View {
    @Bindable var viewModel: RecipeProductionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    private let gridItem = GridItem(.adaptive(minimum: 80), spacing: 8, alignment: .top)
    
    var body: some View {
        ZStack {
            switch viewModel.viewMode {
            case .icon:
                iconBody
                
            case .row:
                rowBody
            }
        }
        .task {
            await viewModel.observeViewMode()
        }
    }
    
    @ViewBuilder
    private var iconBody: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 24) {
                HStack(alignment: .top, spacing: 12) {
                    ingredientIconView(for: viewModel.entry.recipe.output)
                    
                    ForEach(viewModel.entry.recipe.byproducts) { byproduct in
                        ingredientIconView(for: byproduct)
                    }
                }
                
                HStack(alignment: .top, spacing: 12) {
                    ForEach(viewModel.entry.recipe.input) { input in
                        ingredientIconView(for: input)
                    }
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 12) {
                    ingredientIconView(for: viewModel.entry.recipe.output)
                    
                    ForEach(viewModel.entry.recipe.byproducts) { byproduct in
                        ingredientIconView(for: byproduct)
                    }
                }
                
                LazyVGrid(columns: [gridItem, gridItem], spacing: 12) {
                    ForEach(viewModel.entry.recipe.input) { input in
                        ingredientIconView(for: input)
                    }
                }
                .fixedSize()
            }
        }
    }
    
    @ViewBuilder
    private var rowBody: some View {
        VStack(spacing: 12) {
            VStack(spacing: 6) {
                ingredientRowView(for: viewModel.entry.recipe.output)
                
                ForEach(viewModel.entry.recipe.byproducts) { byproduct in
                    ingredientRowView(for: byproduct)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing, 24)
            
            VStack(spacing: 6) {
                ForEach(viewModel.entry.recipe.input) { input in
                    ingredientRowView(for: input)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.leading, 24)
        }
    }
    
    @ViewBuilder 
    private func ingredientIconView(for ingredient: Recipe.Ingredient) -> some View {
        let ingredientValues = IngredientValues(from: ingredient)

        VStack(spacing: 0) {
            Image(ingredient.item.id)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(5)
            
            Text(viewModel.entry.actualAmount(for: ingredient.item), format: .fractionFromZeroToFour)
                .multilineTextAlignment(.center)
                .font(.callout)
                .fontWeight(.medium)
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .frame(width: 80)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background {
                    ZStack {
                        ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                            .fill(ingredientValues.color)
                            .padding(-4 / displayScale)
                            .blur(radius: 3)
                            .inverseMask {
                                ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                            }
                        
                        ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                            .fill(.background)
                        
                        RecipeByproductShape()
                            .foregroundStyle(ingredientValues.byproductColor)
                            .clipShape(ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius))
                    }
                }
        }
    }
    
    @ViewBuilder 
    private func ingredientRowView(for ingredient: Recipe.Ingredient) -> some View {
        let ingredientValues = IngredientValues(from: ingredient)
        
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                HStack {
                    Image(ingredient.item.id)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(5)
                    
                    Text(ingredient.item.localizedName)
                        .font(.callout)
                    
                    Spacer()
                }
                .overlay {
                    Rectangle()
                        .fill(ingredientValues.color)
                        .frame(height: 2 / displayScale)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.trailing, 12)
                }
                
                Text(viewModel.entry.actualAmount(for: ingredient.item), format: .fractionFromZeroToFour)
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                    .frame(width: 80)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background {
                        ZStack {
                            ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                                .fill(ingredientValues.color)
                                .padding(-4 / displayScale)
                                .blur(radius: 3)
                                .inverseMask {
                                    ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                                }
                            
                            ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                                .fill(.background)
                            
                            RecipeByproductShape()
                                .foregroundStyle(ingredientValues.byproductColor)
                                .clipShape(ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius))
                        }
                    }
            }
        }
        .frame(maxWidth: 350)
    }
}

private extension RecipeProductionView {
    struct IngredientValues {
        var color: Color
        var byproductColor: Color
        var cornerRadius: Double
        
        init(from ingredient: Recipe.Ingredient) {
            let form = (ingredient.item as? Part)?.form
            
            switch ingredient.role {
            case .output:
                color = .sh(.gray50)
                byproductColor = .clear
                
            case .input:
                byproductColor = .clear
                
                switch form {
                case .solid, nil:
                    color = .sh(.orange50)
                    
                case .fluid, .gas:
                    color = .sh(.cyan50)
                }
                
            case .byproduct:
                switch form {
                case .solid, nil:
                    color = .sh(.orange50)
                    byproductColor = .sh(.orange20)
                    
                case .fluid, .gas:
                    color = .sh(.cyan50)
                    byproductColor = .sh(.cyan20)
                }
            }
            
            switch form {
            case .solid, nil:
                cornerRadius = 8
                
            case .fluid, .gas:
                cornerRadius = 12
            }
        }
    }
}

#if DEBUG
struct _RecipeProductionPreview: View {
    let viewMode: ViewMode
    
    @Dependency(\.storageService.recipes)
    private var storedRecipes
    
    var recipes: [Recipe] {
        [
            storedRecipes().first(id: "recipe-iron-ingot"),
            storedRecipes().first(id: "recipe-reinforced-iron-plate"),
            storedRecipes().first(id: "recipe-crystal-oscillator"),
            storedRecipes().first(id: "recipe-plastic"),
            storedRecipes().first(id: "recipe-diluted-fuel"),
            storedRecipes().first(id: "recipe-non-fissile-uranium"),
            storedRecipes().first(id: "recipe-alternate-heavy-oil-residue")
        ].compactMap { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(recipes) { recipe in
                    RecipeProductionView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
    }
    
    func viewModel(for recipe: Recipe) -> RecipeProductionViewModel {
        withDependencies {
            $0.settingsService.currentSettings = {
                Settings(viewMode: viewMode)
            }
            $0.settingsService.settings = {
                AsyncStream { Settings(viewMode: viewMode) }
            }
        } operation: {
            RecipeProductionViewModel(entry: ProductionRecipeEntry(
                item: recipe.output.item,
                recipe: recipe,
                amounts: (20.0, 125.8125)
            ))
        }
    }
}

#Preview("Recipe Production View (Icon)") {
    _RecipeProductionPreview(viewMode: .icon)
}

#Preview("Recipe Production View (Row)") {
    _RecipeProductionPreview(viewMode: .row)
}
#endif
