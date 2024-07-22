import SwiftUI
import SHStorage
import SHModels

@Observable
final class ItemRecipesViewModel {
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
        
    let item: any Item
    let onRecipeSelected: @MainActor (Recipe) -> Void
    
    private let outputRecipes: [Recipe]
    private let byproductRecipes: [Recipe]
    
    @MainActor
    private var pinnedRecipeIDs: Set<String> {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    var sections = [Section]()
    
    @MainActor
    init(
        item: any Item,
        filterOutRecipeIDs: [String] = [],
        onRecipeSelected: @MainActor @escaping (Recipe) -> Void
    ) {
        @Dependency(\.storageService)
        var storageService
        
        self.item = item
        self.onRecipeSelected = onRecipeSelected
        
        outputRecipes = storageService
            .recipes(for: item, as: .output)
            .filter { $0.machine != nil && !filterOutRecipeIDs.contains($0.id) }
        
        byproductRecipes = storageService
            .recipes(for: item, as: .byproduct)
            .filter { $0.machine != nil && !filterOutRecipeIDs.contains($0.id) }
        
        pinnedRecipeIDs = storageService.pins().recipeIDs
        buildSections()
    }
    
    @MainActor
    func observeStorage() async {
        for await pinnedRecipeIDs in storageService.streamPins().map(\.recipeIDs) {
            guard !Task.isCancelled else { break }
            
            self.pinnedRecipeIDs = pinnedRecipeIDs
        }
    }
    
    @MainActor
    func sectionHeaderVisible(_ section: Section) -> Bool {
        if case .product = section {
            sections.contains { $0.id != .product && !$0.recipes.isEmpty }
        } else {
            true
        }
    }
    
    @MainActor
    func pinsAllowed() -> Bool {
        sections.flatMap(\.recipes).count > 1
    }
    
    @MainActor
    func isPinned(_ recipe: Recipe) -> Bool {
        storageService.isRecipePinned(recipe)
    }
    
    @MainActor
    func changePinStatus(for recipe: Recipe) {
        storageService.changeRecipePinStatus(recipe)
    }
    
    @MainActor
    private func buildSections() {
        let (product, byproduct) = splitRecipes()
        
        if sections.isEmpty {
            sections = [
                .product(product),
                .byproduct(byproduct)
            ]
        } else {
            withAnimation {
                sections[0].recipes = product
                sections[1].recipes = byproduct
            }
        }
    }
    
    private typealias RecipesSplit = (product: [Recipe], byproduct: [Recipe])
    
    @MainActor
    private func splitRecipes() -> RecipesSplit {
        let (pinnedProduct, product) = outputRecipes.reduce(into: ([Recipe](), [Recipe]())) { partialResult, recipe in
            if pinnedRecipeIDs.contains(recipe.id) {
                partialResult.0.append(recipe)
            } else {
                partialResult.1.append(recipe)
            }
        }
        
        let (pinnedByproduct, byproduct) = byproductRecipes.reduce(into: ([Recipe](), [Recipe]())) { partialResult, recipe in
            if pinnedRecipeIDs.contains(recipe.id) {
                partialResult.0.append(recipe)
            } else {
                partialResult.1.append(recipe)
            }
        }
        
        return (
            pinnedProduct.sortedByDefault() + product.sortedByDefault(),
            pinnedByproduct.sortedByDefault() + byproduct.sortedByDefault()
        )
    }
}

// MARK: - Section
extension ItemRecipesViewModel {
    enum Section: Identifiable, Equatable {
        enum ID {
            case product
            case byproduct
        }
        
        case product(_ recipes: [Recipe], expanded: Bool = true)
        case byproduct(_ recipes: [Recipe], expanded: Bool = true)
        
        var id: ID {
            switch self {
            case .product: .product
            case .byproduct: .byproduct
            }
        }
        
        var isEmpty: Bool {
            switch self {
            case let .product(recipes, _): recipes.isEmpty
            case let .byproduct(recipes, _): recipes.isEmpty
            }
        }
        
        var title: String {
            switch self {
            case .product: "Product"
            case .byproduct: "Byproduct"
            }
        }
        
        var expanded: Bool {
            get {
                switch self {
                case
                    let .product(_, expanded),
                    let .byproduct(_, expanded):
                    expanded
                }
            }
            set {
                switch self {
                case let .product(recipes, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .product(recipes, expanded: newValue)
                    
                case let .byproduct(recipes, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .byproduct(recipes, expanded: newValue)
                }
            }
        }
        
        var recipes: [Recipe] {
            get {
                switch self {
                case let .product(recipes, _): recipes
                case let .byproduct(recipes, _): recipes
                }
            }
            set {
                switch self {
                case let .product(recipes, expanded: expanded):
                    guard recipes != newValue else { return }
                    
                    self = .product(newValue, expanded: expanded)
                    
                case let .byproduct(recipes, expanded: expanded):
                    guard recipes != newValue else { return }
                    
                    self = .byproduct(newValue, expanded: expanded)
                }
            }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.product(lhsRecipes, _), .product(rhsRecipes, _)):
                lhsRecipes == rhsRecipes
                
            case let (.byproduct(lhsRecipes, _), .byproduct(rhsRecipes, _)):
                lhsRecipes == rhsRecipes
                
            default:
                false
            }
        }
    }
}
