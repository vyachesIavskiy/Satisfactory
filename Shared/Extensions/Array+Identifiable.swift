
extension Array where Element: Identifiable {
    subscript(id id: Element.ID) -> Element? {
        get {
            first { $0.id == id }
        }
        set {
            if let newValue, let index = firstIndex(where: { $0.id == id }) {
                self[index] = newValue
            }
        }
    }
}
