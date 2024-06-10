import SwiftUI
import SHStorage
import SHModels

@Observable
final class ItemRecipesViewModel {
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
        
    let item: any Item
    private let outputRecipes: [Recipe]
    private let byproductRecipes: [Recipe]
    private var pinnedRecipeIDs = Set<String>() {
        didSet {
            buildSections()
        }
    }
    
    var sections = [Section]()
    
    init(item: any Item) {
        @Dependency(\.storageService)
        var storageService
        
        self.item = item
        
        outputRecipes = storageService.recipes(for: item, as: .output).filter { $0.machine != nil }
        byproductRecipes = storageService.recipes(for: item, as: .byproduct).filter { $0.machine != nil }
    }
    
    @MainActor
    func task() async throws {
        for await pinnedRecipeIDs in storageService.pinnedRecipeIDs() {
            try Task.checkCancellation()
            
            self.pinnedRecipeIDs = pinnedRecipeIDs
        }
    }
    
    func sectionHeaderVisible(_ section: Section) -> Bool {
        if case .output = section {
            sections.contains { $0.id != .output && !$0.recipes.isEmpty }
        } else {
            true
        }
    }
    
    func pinsAllowed() -> Bool {
        sections.flatMap(\.recipes).count > 1
    }
    
    func isPinned(_ recipe: Recipe) -> Bool {
        storageService.isRecipePinned(recipe)
    }
    
    func changePinStatus(for recipe: Recipe) {
        storageService.changeRecipePinStatus(recipe)
    }
    
    private func buildSections() {
        let (pinned, output, byproduct) = splitRecipes()
        
        if sections.isEmpty {
            sections = [
                .pinned(pinned),
                .output(output),
                .byproduct(byproduct)
            ]
        } else {
            withAnimation {
                sections[0].recipes = pinned
                sections[1].recipes = output
                sections[2].recipes = byproduct
            }
        }
    }
    
    private typealias RecipesSplit = (pinned: [Recipe], output: [Recipe], byproduct: [Recipe])
    private func splitRecipes() -> RecipesSplit {
        let (pinnedOutput, output) = outputRecipes.reduce(into: ([Recipe](), [Recipe]())) { partialResult, recipe in
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
            (pinnedOutput + pinnedByproduct).sortedByDefault(),
            output.sortedByDefault(),
            byproduct.sortedByDefault()
        )
    }
}

// MARK: - Section
extension ItemRecipesViewModel {
    enum Section: Identifiable, Equatable {
        enum ID {
            case pinned
            case output
            case byproduct
        }
        
        case pinned(_ recipes: [Recipe], expanded: Bool = true)
        case output(_ recipes: [Recipe], expanded: Bool = true)
        case byproduct(_ recipes: [Recipe], expanded: Bool = true)
        
        var id: ID {
            switch self {
            case .pinned: .pinned
            case .output: .output
            case .byproduct: .byproduct
            }
        }
        
        var isEmpty: Bool {
            switch self {
            case let .pinned(recipes, _): recipes.isEmpty
            case let .output(recipes, _): recipes.isEmpty
            case let .byproduct(recipes, _): recipes.isEmpty
            }
        }
        
        var title: String {
            switch self {
            case .pinned: "Pinned"
            case .output: "As primary output"
            case .byproduct: "As byproduct"
            }
        }
        
        var expanded: Bool {
            get {
                switch self {
                case
                    let .pinned(_, expanded),
                    let .output(_, expanded),
                    let .byproduct(_, expanded):
                    expanded
                }
            }
            set {
                switch self {
                case let .pinned(recipes, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .pinned(recipes, expanded: newValue)
                    
                case let .output(recipes, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .output(recipes, expanded: newValue)
                    
                case let .byproduct(recipes, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .byproduct(recipes, expanded: newValue)
                }
            }
        }
        
        var recipes: [Recipe] {
            get {
                switch self {
                case let .pinned(recipes, _): recipes
                case let .output(recipes, _): recipes
                case let .byproduct(recipes, _): recipes
                }
            }
            set {
                switch self {
                case let .pinned(recipes, expanded: expanded):
                    guard recipes != newValue else { return }
                    
                    self = .pinned(newValue, expanded: expanded)
                    
                case let .output(recipes, expanded: expanded):
                    guard recipes != newValue else { return }
                    
                    self = .output(newValue, expanded: expanded)
                    
                case let .byproduct(recipes, expanded: expanded):
                    guard recipes != newValue else { return }
                    
                    self = .byproduct(newValue, expanded: expanded)
                }
            }
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case let (.pinned(lhsRecipes, _), .pinned(rhsRecipes, _)):
                lhsRecipes == rhsRecipes
                
            case let (.output(lhsRecipes, _), .output(rhsRecipes, _)):
                lhsRecipes == rhsRecipes
                
            case let (.byproduct(lhsRecipes, _), .byproduct(rhsRecipes, _)):
                lhsRecipes == rhsRecipes
                
            default:
                false
            }
        }
    }
}
