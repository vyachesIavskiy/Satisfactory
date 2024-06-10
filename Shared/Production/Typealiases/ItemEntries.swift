import SHModels

typealias ItemEntries = [ProductionItemEntry]

extension ItemEntries {
    init(item: some Item) {
        self = [ProductionItemEntry(item: item)]
    }
    
    mutating func add(_ item: some Item) {
        if !contains(item) {
            append(ProductionItemEntry(item: item))
        }
    }
    
    mutating func remove(_ item: some Item) {
        if let index = firstIndex(of: item) {
            remove(at: index)
        }
    }
}
