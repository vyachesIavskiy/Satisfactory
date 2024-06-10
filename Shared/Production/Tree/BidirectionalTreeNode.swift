final class BidirectionalTreeNode<Element> {
    var element: Element
    var leaves: [BidirectionalTreeNode<Element>]
    weak var parent: BidirectionalTreeNode<Element>?
    
    init(element: Element, parent: BidirectionalTreeNode<Element>? = nil) {
        self.element = element
        self.parent = parent
        leaves = []
    }
    
    func leaf(contains predicate: (Element) -> Bool) -> Bool {
        leaves.contains { predicate($0.element) }
    }
    
    func firstIndex(where predicate: (Element) -> Bool) -> Int? {
        leaves.firstIndex { predicate($0.element) }
    }
    
    func first(where predicate: (Element) -> Bool) -> BidirectionalTreeNode<Element>? {
        leaves.first { predicate($0.element) }
    }
    
    func add(element: Element) {
        leaves.append(BidirectionalTreeNode(element: element, parent: self))
    }
    
    func removeAll(where predicate: (Element) -> Bool) {
        leaves.removeAll { predicate($0.element) }
    }
    
    typealias NextPartialResult<Value> = (_ partialResult: Value, _ element: Element) -> Value
    func reduce<Value>(_ initialValue: Value, nextPartialResult: NextPartialResult<Value>) -> Value {
        reduce(node: self, currentResult: initialValue, nextPartialResult: nextPartialResult)
    }
    
    typealias UpdatingAccumulatingResult<Value> = (_ accumulatingResult: inout Value, _ element: Element) -> Void
    func reduce<Value>(into value: Value, updatingAccumulatingResult: UpdatingAccumulatingResult<Value>) -> Value {
        var result = value
        reduce(node: self, into: &result, updatingAccumulatingResult: updatingAccumulatingResult)
        return result
    }
}

private extension BidirectionalTreeNode {
    func reduce<Value>(
        node: BidirectionalTreeNode<Element>,
        currentResult: Value,
        nextPartialResult: NextPartialResult<Value>
    ) -> Value {
        var result = nextPartialResult(currentResult, node.element)
        for leaf in node.leaves {
            result = reduce(node: leaf, currentResult: result, nextPartialResult: nextPartialResult)
        }
        
        return result
    }
    
    func reduce<Value>(
        node: BidirectionalTreeNode<Element>,
        into currentResult: inout Value,
        updatingAccumulatingResult: UpdatingAccumulatingResult<Value>
    ) {
        updatingAccumulatingResult(&currentResult, node.element)
        for leaf in node.leaves {
            reduce(node: leaf, into: &currentResult, updatingAccumulatingResult: updatingAccumulatingResult)
        }
    }
}
