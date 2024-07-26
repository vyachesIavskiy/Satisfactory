import SwiftUI
import SHStorage
import SHModels

@Observable
final class InitialRecipeSelectionViewModel {
    // MARK: Ignored properties
    let item: any Item
    let onRecipeSelected: @MainActor (Recipe) -> Void
    
    private let outputRecipes: [Recipe]
    private let byproductRecipes: [Recipe]
    
    @MainActor @ObservationIgnored
    private var pinnedRecipeIDs: Set<String> {
        didSet {
            buildSections()
        }
    }
    
    // MARK: Observed properties
    @MainActor
    var sections = [Section]()
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    init(item: any Item, onRecipeSelected: @MainActor @escaping (Recipe) -> Void) {
        @Dependency(\.storageService)
        var storageService
        
        self.item = item
        self.onRecipeSelected = onRecipeSelected
        
        outputRecipes = storageService
            .recipes(for: item, as: .output)
            .filter { $0.machine != nil }
        
        byproductRecipes = storageService
            .recipes(for: item, as: .byproduct)
            .filter { $0.machine != nil }
        
        pinnedRecipeIDs = storageService.pinnedRecipeIDs(for: item, as: [.output, .byproduct])
        observeStorage()

        buildSections()
    }
    
    @MainActor
    func sectionHeaderVisible(_ section: Section) -> Bool {
        switch section.id {
        case .product:
            sections.contains { $0.id != .product && !$0.recipes.isEmpty }
            
        default:
            true
        }
    }
    
    @MainActor
    func pinsAllowed() -> Bool {
        sections.flatMap(\.recipes).count > 1
    }
    
    @MainActor
    func isPinned(_ recipe: Recipe) -> Bool {
        storageService.isPinned(recipe)
    }
    
    @MainActor
    func changePinStatus(for recipe: Recipe) {
        storageService.changePinStatus(for: recipe)
    }
}

private extension InitialRecipeSelectionViewModel {
    func observeStorage() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            for await pinnedRecipeIDs in storageService.streamPinnedRecipeIDs(for: item, as: [.output, .byproduct]) {
                guard !Task.isCancelled else { break }
                
                self.pinnedRecipeIDs = pinnedRecipeIDs
            }
        }
    }
    
    @MainActor
    func buildSections() {
        let (pinned, product, byproduct) = splitRecipes()
        
        if sections.isEmpty {
            sections = [
                .pinned(pinned),
                .product(product),
                .byproduct(byproduct)
            ]
        } else {
            withAnimation {
                sections[id: .pinned]?.recipes = pinned
                sections[id: .product]?.recipes = product
                sections[id: .byproduct]?.recipes = byproduct
            }
        }
    }
    
    typealias RecipesSplit = (pinned: [Recipe], product: [Recipe], byproduct: [Recipe])
    
    @MainActor
    func splitRecipes() -> RecipesSplit {
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
            (pinnedProduct + pinnedByproduct).sortedByDefault(),
            product.sortedByDefault(),
            byproduct.sortedByDefault()
        )
    }
}

// MARK: - Section
extension InitialRecipeSelectionViewModel {
    struct Section: Identifiable, Equatable {
        enum ID {
            case pinned
            case product
            case byproduct
        }
        
        let id: ID
        var recipes: [Recipe]
        var expanded: Bool
        
        var title: String {
            switch id {
            case .pinned: "Pinned"
            case .product: "Product"
            case .byproduct: "Byproduct"
            }
        }
        
        private init(id: ID, recipes: [Recipe]) {
            self.id = id
            self.recipes = recipes
            self.expanded = true
        }
        
        static func pinned(_ recipes: [Recipe]) -> Self {
            Section(id: .pinned, recipes: recipes)
        }
        
        static func product(_ recipes: [Recipe]) -> Self {
            Section(id: .product, recipes: recipes)
        }
        
        static func byproduct(_ recipes: [Recipe]) -> Self {
            Section(id: .byproduct, recipes: recipes)
        }
    }
}
