import SwiftUI
import SHSettings
import SHModels

@Observable
final class RecipeDisplayViewModel {
    let recipe: Recipe
    private(set) var viewMode: ViewMode
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    var settingsService
    
    init(recipe: Recipe) {
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        self.recipe = recipe
        self.viewMode = settings().viewMode
    }
    
    @MainActor
    func observeViewMode() async {
        @Dependency(\.settingsService.settings)
        var settings
        
        for await viewMode in settingsService.settings().map(\.viewMode) {
            guard !Task.isCancelled else { break }
            
            if self.viewMode != viewMode {
                self.viewMode = viewMode
            }
        }
    }
}

struct RecipeDisplayView: View {
    let viewModel: RecipeDisplayViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var titleSpacing = 8.0
    
    private let gridItem = GridItem(.adaptive(minimum: 60, maximum: 80), spacing: 8)
    
    var body: some View {
        VStack(alignment: .leading, spacing: titleSpacing) {
            HStack {
                Text(viewModel.recipe.localizedName)
                    .fontWeight(.medium)
                
                Spacer()
                
                if !viewModel.recipe.isDefault {
                    alternateIndicatorView
                }
            }
            
            switch viewModel.viewMode {
            case .icon: iconBody
            case .row: rowBody
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: AngledRectangle(cornerRadius: 12).inset(by: -8))
        .contentShape(.interaction, Rectangle())
        .contentShape(.contextMenuPreview, AngledRectangle(cornerRadius: 12).inset(by: -8))
        .task {
            await viewModel.observeViewMode()
        }
    }
    
    @ViewBuilder
    private var iconBody: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 24) {
                HStack(alignment: .top, spacing: 8) {
                    ingredientIconView(for: viewModel.recipe.output)
                    
                    ForEach(viewModel.recipe.byproducts) { byproduct in
                        ingredientIconView(for: byproduct)
                    }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    ForEach(viewModel.recipe.input) { input in
                        ingredientIconView(for: input)
                    }
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 8) {
                    ingredientIconView(for: viewModel.recipe.output)
                    
                    ForEach(viewModel.recipe.byproducts) { byproduct in
                        ingredientIconView(for: byproduct)
                    }
                }
                
                LazyVGrid(columns: [gridItem, gridItem], spacing: 8) {
                    ForEach(viewModel.recipe.input) { input in
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
                ingredientRowView(for: viewModel.recipe.output)
                
                ForEach(viewModel.recipe.byproducts) { byproduct in
                    ingredientRowView(for: byproduct)
                }
            }
            .padding(.trailing, 24)
            
            VStack(spacing: 6) {
                ForEach(viewModel.recipe.input) { input in
                    ingredientRowView(for: input)
                }
            }
            .padding(.leading, 24)
        }
    }
    
    @ViewBuilder
    private var alternateIndicatorView: some View {
        Text("Alternate")
            .font(.footnote)
            .fontWeight(.light)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .overlay {
                AngledRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2 / displayScale)
            }
            .foregroundStyle(.sh(.midnight))
    }
    
    @ViewBuilder
    private func ingredientIconView(for ingredient: Recipe.Ingredient) -> some View {
        let ingredientValues = IngredientValues(from: ingredient)
        
        ZStack {
            ZStack {
                ingredientValues.color
                
                RecipeByproductShape()
                    .foregroundStyle(ingredientValues.byproductColor)
            }
            .inverseMask {
                ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius - 2 / displayScale)
                    .padding(4 / displayScale)
                    .inverseMask {
                        Text(viewModel.recipe.amountPerMinute(for: ingredient), format: .fractionFromZeroToFour)
                            .frame(maxWidth: 50)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Rectangle()
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
            }
            
            VStack(spacing: 0) {
                ZStack {
                    // Selection style goes here
                    
                    Image(ingredient.item.id)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(6)
                        .background(
                            .background,
                            in: ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius)
                        )
                }
                
                Text(viewModel.recipe.amountPerMinute(for: ingredient), format: .fractionFromZeroToFour)
                    .foregroundColor(.white)
                    .frame(maxWidth: 50)
                    .padding(.vertical, 2)
                    .frame(maxWidth: .infinity)
            }
            .padding(4 / displayScale)
        }
        .fixedSize()
        .clipShape(ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius))
    }
    
    @ViewBuilder
    private func ingredientRowView(for ingredient: Recipe.Ingredient) -> some View {
        let ingredientValues = IngredientValues(from: ingredient)
        
        ZStack {
            ZStack {
                ingredientValues.color
                
                RecipeByproductShape()
                    .foregroundStyle(ingredientValues.byproductColor)
            }
            .inverseMask {
                ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius - (2 / displayScale))
                    .inset(by: 4 / displayScale)
                    .inverseMask {
                        Rectangle()
                            .frame(height: 8)
                            .padding(4 / displayScale)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    }
            }
            
            ZStack {
                // Selection styles here
                
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(ingredient.item.id)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .alignmentGuide(.firstTextBaseline) { d in
                            d[VerticalAlignment.center] + 8
                        }
                        .padding(.vertical, 6)
                        .padding(.leading, 10)
                    
                    Text(ingredient.item.localizedName)
                    
                    Spacer()
                    
                    Text(viewModel.recipe.amountPerMinute(for: ingredient), format: .fractionFromZeroToFour)
                        .font(.headline)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 16)
                }
            }
            .padding(.bottom, 8)
        }
        .fixedSize(horizontal: false, vertical: true)
        .clipShape(ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius))
    }
}

private extension RecipeDisplayView {
    struct IngredientValues {
        var color: Color
        var byproductColor: Color
        var cornerRadius: Double
        
        init(from ingredient: Recipe.Ingredient) {
            let form = (ingredient.item as? Part)?.form
            
            switch ingredient.role {
            case .output:
                color = .gray
                byproductColor = .clear
                
            case .input:
                byproductColor = .clear
                
                switch form {
                case .solid, nil:
                    color = .sh(.orange)
                    
                case .fluid, .gas:
                    color = .sh(.cyan)
                }
                
            case .byproduct:
                switch form {
                case .solid, nil:
                    color = .sh(.orange)
                    byproductColor = .sh(.orange80)
                    
                case .fluid, .gas:
                    color = .sh(.cyan)
                    byproductColor = .sh(.cyan80)
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
import SHStorage

private struct _RecipeDisplayViewPreview: View {
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
                    RecipeDisplayView(viewModel: viewModel(for: recipe))
                }
            }
            .padding(.horizontal)
        }
    }
    
    func viewModel(for recipe: Recipe) -> RecipeDisplayViewModel {
        withDependencies {
            $0.settingsService.currentSettings = {
                Settings(viewMode: viewMode)
            }
            $0.settingsService.settings = {
                AsyncStream { Settings(viewMode: viewMode) }
            }
        } operation: {
            RecipeDisplayViewModel(recipe: recipe)
        }
    }
}

#Preview("Recipe Display View (Icon)") {
    _RecipeDisplayViewPreview(viewMode: .icon)
}

#Preview("Recipe Display View (Row)") {
    _RecipeDisplayViewPreview(viewMode: .row)
}
#endif
