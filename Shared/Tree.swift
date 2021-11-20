import Foundation

struct Tree<Element> {
    var element: Element
    
    var children = [Tree]()
    
    mutating func add(child: Tree) {
        children.append(child)
    }
    
    mutating func add(child: Tree, where predicate: (Tree) -> Bool) {
        if predicate(self) {
            children.append(child)
        } else {
            children.enumerated().forEach { index, _ in
                children[index].add(child: child, where: predicate)
            }
        }
    }
    
    mutating func removeChild(where predicate: (Tree) -> Bool) {
        if let index = children.firstIndex(where: predicate) {
            children.remove(at: index)
        }
    }
    
    mutating func apply(where predicate: (Tree) -> Bool, transform: (inout Tree) -> Void) {
        if predicate(self) {
            transform(&self)
        }
        
        children.enumerated().forEach { (index, _) in
            children[index].apply(where: predicate, transform: transform)
        }
    }
    
    mutating func apply(_ transform: (inout Tree) -> Void) {
        transform(&self)
        
        children.enumerated().forEach { (index, _) in
            children[index].apply(transform)
        }
    }
}

extension Tree: Equatable where Element: Equatable {}
extension Tree: Hashable where Element: Hashable {}
extension Tree: Identifiable where Element: Identifiable {
    var id: some Hashable { element.id }
}

extension Tree where Element: Equatable {
    func find(_ value: Element) -> Tree? {
        if self.element == value {
            return self
        }
        
        for child in children {
            if let found = child.find(value) {
                return found
            }
        }
        
        return nil
    }
    
    mutating func remove(_ value: Element) {
        func predicate(_ tree: Tree) -> Bool {
            tree.element == value
        }
        
        if let index = children.firstIndex(where: predicate) {
            children.remove(at: index)
        }
    }
    
    mutating func apply(to tree: Tree, modification: (inout Tree) -> Void) {
        if self == tree {
            modification(&self)
        }
        
        children.enumerated().forEach { (index, _) in
            children[index].apply(to: tree, modification: modification)
        }
    }
}

private struct Queue<Value> {
    var elements = [Value]()
    
    var isEmpty: Bool { elements.isEmpty }
    
    mutating func enqueue(_ value: Value) {
        elements.append(value)
    }
    
    mutating func dequeue() -> Value? {
        isEmpty ? nil : elements.removeFirst()
    }
}

extension Tree {
    enum IteratorStrategy {
        case depth
        case level
    }
    
    func forEach(strategy: IteratorStrategy, _ visit: (Tree) throws -> Void) rethrows {
        switch strategy {
        case .depth:
            try forEachDepth(visit)
        case .level:
            try forEachLevel(visit)
        }
    }
    
    private func forEachDepth(_ visit: (Tree) throws -> Void) rethrows {
        try visit(self)
        try children.forEach {
            try $0.forEachDepth(visit)
        }
    }
    
    private func forEachLevel(_ visit: (Tree) throws -> Void) rethrows {
        try visit(self)
        var queue = Queue<Self>()
        children.forEach {
            queue.enqueue($0)
        }
        
        while let tree = queue.dequeue() {
            try visit(tree)
            tree.children.forEach {
                queue.enqueue($0)
            }
        }
    }
    
    func map<Result>(strategy: IteratorStrategy, _ transform: (Tree) throws -> Result) rethrows -> [Result] {
        switch strategy {
        case .depth:
            return try mapDepth(transform)
        case .level:
            return try mapLevel(transform)
        }
    }
    
    private func mapDepth<Result>(_ transform: (Self) throws -> Result) rethrows -> [Result] {
        var result = [Result]()
        try forEachDepth { tree in
            result.append(try transform(tree))
        }
        return result
    }
    
    private func mapLevel<Result>(_ transform: (Tree) throws -> Result) rethrows -> [Result] {
        var result = [Result]()
        try forEachLevel { tree in
            result.append(try transform(tree))
        }
        return result
    }
    
    func reduce<Result>(strategy: IteratorStrategy, _ initialResult: Result, _ nextPartialResult: (Result, Self) throws -> Result) rethrows -> Result {
        switch strategy {
        case .depth:
            return try reduceDepth(initialResult, nextPartialResult)
        case .level:
            return try reduceLevel(initialResult, nextPartialResult)
        }
    }
    
    private func reduceDepth<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Self) throws -> Result) rethrows -> Result {
        var result = initialResult
        try forEachDepth { tree in
            result = try nextPartialResult(result, tree)
        }
        return result
    }
    
    private func reduceLevel<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Self) throws -> Result) rethrows -> Result {
        var result = initialResult
        try forEachLevel { tree in
            result = try nextPartialResult(result, tree)
        }
        return result
    }
    
    func reduce<Result>(strategy: IteratorStrategy, into initialResult: Result, _ updateAccumulatingResult: (inout Result, Self) throws -> Void) rethrows -> Result {
        switch strategy {
        case .depth:
            return try reduceDepth(into: initialResult, updateAccumulatingResult)
        case .level:
            return try reduceLevel(into: initialResult, updateAccumulatingResult)
        }
    }
    
    private func reduceDepth<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Self) throws -> Void) rethrows -> Result {
        var result = initialResult
        try forEachDepth { tree in
            try updateAccumulatingResult(&result, tree)
        }
        return result
    }
    
    private func reduceLevel<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Self) throws -> Void) rethrows -> Result {
        var result = initialResult
        try forEachLevel { tree in
            try updateAccumulatingResult(&result, tree)
        }
        return result
    }
}

extension Tree {
    var array: [Self] {
        var result = [Self]()
        forEachDepth { tree in
            result.append(tree)
        }
        return result
    }
    
    var arrayLevels: [Self] {
        var result = [Self]()
        forEachLevel { tree in
            result.append(tree)
        }
        return result
    }
}
