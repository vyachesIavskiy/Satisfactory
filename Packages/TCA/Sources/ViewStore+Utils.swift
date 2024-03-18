import ComposableArchitecture

public extension ViewStore {
    func action(_ action: ViewAction) -> () -> Void {
        { self.send(action) }
    }
}
