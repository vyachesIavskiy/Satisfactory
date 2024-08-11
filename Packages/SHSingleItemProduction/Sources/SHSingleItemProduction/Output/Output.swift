import SHModels

extension SHSingleItemProduction {
    public struct Output: Hashable {
        public var outputItems: [OutputItem]
        
        public init(outputItems: [OutputItem] = []) {
            self.outputItems = outputItems
        }
    }
}
