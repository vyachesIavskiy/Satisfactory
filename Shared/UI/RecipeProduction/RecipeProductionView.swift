import SwiftUI
import SHDependencies
import SHSettings
import SHStorage
import SHModels

@Observable
final class RecipeProductionViewModel {
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
    
    private let gridItem = GridItem(.fixed(62), spacing: 8)
    
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
                HStack(alignment: .top, spacing: 8) {
                    recipeCell(for: viewModel.recipe.output)
                    
                    ForEach(viewModel.recipe.byproducts) { byproduct in
                        recipeCell(for: byproduct)
                    }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    ForEach(viewModel.recipe.input) { input in
                        recipeCell(for: input)
                    }
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 8) {
                    recipeCell(for: viewModel.recipe.output)
                    
                    ForEach(viewModel.recipe.byproducts) { byproduct in
                        recipeCell(for: byproduct)
                    }
                }
                
                LazyVGrid(columns: [gridItem, gridItem], spacing: 8) {
                    ForEach(viewModel.recipe.input) { input in
                        recipeCell(for: input)
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
                recipeRow(for: viewModel.recipe.output)
                
                ForEach(viewModel.recipe.byproducts) { byproduct in
                    recipeRow(for: byproduct)
                }
            }
            .padding(.trailing, 24)
            
            VStack(spacing: 6) {
                ForEach(viewModel.recipe.input) { input in
                    recipeRow(for: input)
                }
            }
            .padding(.leading, 24)
        }
    }
    
    @ViewBuilder 
    private func recipeCell(for ingredient: Recipe.Ingredient) -> some View {
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
    private func recipeRow(for ingredient: Recipe.Ingredient) -> some View {
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
        .clipShape(ItemIconShape(item: ingredient.item, cornerRadius: ingredientValues.cornerRadius))
    }
    
    private func resolvedShapeStyle(for ingredient: Recipe.Ingredient) -> AnyShapeStyle {
        switch ingredient.role {
        case .output:
            return AnyShapeStyle(Color("Colors/Output"))
            
        case .byproduct, .input:
            let part = (ingredient.item as? Part)
            return if part?.isNaturalResource == true {
                AnyShapeStyle(.sh(.midnight))
            } else {
                switch part?.form {
                case .solid, nil:
                    AnyShapeStyle(.sh(.orange))
                case .fluid, .gas:
                    AnyShapeStyle(.sh(.cyan))
                }
            }
        }
    }
    
    private func resolvedAmountBackgroundColor(for ingredient: Recipe.Ingredient) -> Color {
        switch ingredient.role {
        case .output: .sh(.gray)
            
        case .input, .byproduct:
            switch (ingredient.item as? Part)?.form {
            case .solid, nil: .sh(.orange)
            case .fluid, .gas: .sh(.cyan)
            }
        }
    }
    
    private func resolvedAmountByproductBackgroundColor(for ingredient: Recipe.Ingredient) -> Color {
        switch ingredient.role {
        case .output, .input: .clear
        
        case .byproduct:
            switch (ingredient.item as? Part)?.form {
            case .solid, nil: .sh(.orange80)
            case .fluid, .gas: .sh(.cyan80)
            }
        }
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
                color = .gray
                byproductColor = .clear
                
            case .input:
                byproductColor = .clear
                
                if (ingredient.item as? Part)?.isNaturalResource == true {
                    switch form {
                    case .solid, nil:
                        color = .sh(.orange90)
                        
                    case .fluid, .gas:
                        color = .sh(.cyan90)
                    }
                } else {
                    switch form {
                    case .solid, nil:
                        color = .sh(.orange)
                        
                    case .fluid, .gas:
                        color = .sh(.cyan)
                    }
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
            RecipeProductionViewModel(recipe: recipe)
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
