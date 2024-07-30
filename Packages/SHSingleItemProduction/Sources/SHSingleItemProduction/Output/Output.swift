import SHModels

extension SHSingleItemProduction {
    public struct Output {
        public var outputItems: [OutputItem]
        public var unselectedItems: [any Item]
        public var hasByproducts: Bool
        
        public init(outputItems: [OutputItem], unselectedItems: [any Item], hasByproducts: Bool) {
            self.outputItems = outputItems
            self.unselectedItems = unselectedItems
            self.hasByproducts = hasByproducts
        }
    }
}

extension SHSingleItemProduction.Output: Hashable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.outputItems == rhs.outputItems &&
        lhs.unselectedItems.map(\.id) == rhs.unselectedItems.map(\.id) &&
        lhs.hasByproducts == rhs.hasByproducts
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(outputItems)
        hasher.combine(unselectedItems.map(\.id))
        hasher.combine(hasByproducts)
    }
}
