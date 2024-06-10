import SHModels

struct ProductionItemEntry {
    var item: any Item
    var recipeEntries = [ProductionRecipeEntry]()
    
    var amount: Double {
        recipeEntries.reduce(0) { $0 + $1.amounts.actualAmount }
    }
}

extension ProductionItemEntry: Identifiable {
    var id: String { item.id }
}

extension Array<ProductionItemEntry> {
    func first(of item: some Item) -> Element? {
        first { $0.id == item.id }
    }
    
    func firstIndex(of item: some Item) -> Int? {
        firstIndex { $0.id == item.id }
    }
}

extension Sequence<ProductionItemEntry> {
    func contains(_ item: some Item) -> Bool {
        contains { $0.item.id == item.id }
    }
}
