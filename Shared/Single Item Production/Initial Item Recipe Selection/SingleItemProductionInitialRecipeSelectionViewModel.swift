import SwiftUI
import SHStorage
import SHModels

@Observable
final class SingleItemProductionInitialRecipeSelectionViewModel {
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
        
        pinnedRecipeIDs = storageService.pinnedRecipeIDs(for: item, as: [.output, .byproduct])
        buildSections()
        
        Task { @MainActor [weak self] in
            for await pinnedRecipeIDs in storageService.streamPinnedRecipeIDs(for: item, as: [.output, .byproduct]) {
                guard !Task.isCancelled else { break }
                
                self?.pinnedRecipeIDs = pinnedRecipeIDs
            }
        }
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
    
    @MainActor
    private func buildSections() {
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
    
    private typealias RecipesSplit = (pinned: [Recipe], product: [Recipe], byproduct: [Recipe])
    
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
            (pinnedProduct + pinnedByproduct).sortedByDefault(),
            product.sortedByDefault(),
            byproduct.sortedByDefault()
        )
    }
}

// MARK: - Section
extension SingleItemProductionInitialRecipeSelectionViewModel {
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
