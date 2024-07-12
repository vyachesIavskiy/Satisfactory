
extension Array {
    mutating func merge(
        with other: [Element],
        predicate: (_ lhs: Element, _ rhs: Element) -> Bool,
        merging: ((_ lhs: inout Element, _ rhs: Element) -> Void)? = nil
    ) {
        for element in other {
            if let index = firstIndex(where: { predicate($0, element) }) {
                merging?(&self[index], element)
            } else {
                append(element)
            }
        }
    }
}
