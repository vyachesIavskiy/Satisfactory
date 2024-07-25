import SHModels

extension SHSingleItemProduction {
    public struct Output {
        public var products: [OutputItem]
        public var unselectedItems: [any Item]
        public var hasByproducts: Bool
        
        public init(products: [OutputItem], unselectedItems: [any Item], hasByproducts: Bool) {
            self.products = products
            self.unselectedItems = unselectedItems
            self.hasByproducts = hasByproducts
        }
    }
}

extension SHSingleItemProduction.Output: Equatable {
    public static func == (lhs: SHSingleItemProduction.Output, rhs: SHSingleItemProduction.Output) -> Bool {
        lhs.products == rhs.products &&
        lhs.unselectedItems.map(\.id) == rhs.unselectedItems.map(\.id) &&
        lhs.hasByproducts == rhs.hasByproducts
    }
}
