import Foundation

struct Recipe: Identifiable {
    struct RecipePartOld: Hashable, Identifiable {
        let item: Item
        let amount: Double
        
        var id: String {
            item.id
        }
        
        fileprivate var recipeDuration = 0
        
        var productionRecipes: [Recipe] { item.recipes }
        
        var amountPerMinute: Double {
            amount * (60 / Double(recipeDuration))
        }
        
        init(item: Item, amount: Double) {
            self.item = item
            self.amount = amount
        }
        
        static func == (lhs: Recipe.RecipePartOld, rhs: Recipe.RecipePartOld) -> Bool {
            lhs.item.id == rhs.item.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(item.id)
        }
        
        func amountPerMinute(with duration: Int) -> Double {
            Double(amount) * (60 / Double(duration))
        }
    }
    
    let id: String
    let name: String
    private(set) var input: [RecipePartOld]
    private(set) var output: [RecipePartOld]
    let machines: [Building]
    let duration: Int
    let isDefault: Bool
    var isFavorite: Bool {
        get {
            UserDefaults.standard.bool(forKey: id)
        }
        set {
            if newValue {
                UserDefaults.standard.set(newValue, forKey: id)
            } else {
                UserDefaults.standard.removeObject(forKey: id)
            }
        }
    }
    
    var canBeInitial: Bool {
        input.reduce(true) { partialResult, input in
            partialResult && (input.item as? Part)?.rawResource == true
        }
    }
    
    init(
        id: String,
        name: String,
        input: [RecipePartOld],
        output: [RecipePartOld],
        machines: [Building],
        duration: Int,
        isDefault: Bool
    ) {
        self.id = id
        self.name = name
        self.input = input
        self.output = output
        self.machines = machines
        self.duration = duration
        self.isDefault = isDefault
        
        self.input.enumerated().forEach { (index, _) in
            self.input[index].recipeDuration = duration
        }
        
        self.output.enumerated().forEach { (index, _) in
            self.output[index].recipeDuration = duration
        }
    }
    
    func inputAmountsPerMinute(for item: Item, with desiredProductionPerMinute: Double) -> [(Item, Double)] {
        let multiplier = desiredProductionPerMinute / (output.first { $0.item.id == item.id }?.amountPerMinute ?? 1)
        return input.map { ($0.item, $0.amountPerMinute * multiplier) }
    }
}

extension Recipe: Hashable {
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

extension Recipe: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        let output = output.map { "\($0.amountPerMinute.formatted(.fractionFromZeroToFour))/min \($0.item.name)" }.joined(separator: "\n")
        let input = input.map { "\($0.amountPerMinute.formatted(.fractionFromZeroToFour))/min \($0.item.name)" }.joined(separator: "\n")
        
        return """
        \(name)
        
        \(output)
        ----------------------------------
        \(input)
        """
    }
}
