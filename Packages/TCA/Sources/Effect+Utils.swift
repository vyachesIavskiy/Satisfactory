import ComposableArchitecture

public extension Effect where Action: BindableAction {
    static func assign<T: Equatable>(
        _ keyPath: WritableKeyPath<Action.State, BindingState<T>>,
        from updates: AsyncStream<T>,
        priority: TaskPriority? = nil
    ) -> Effect<Action> {
        return .run(priority: priority) { send in
            for await value in updates {
                await send(.set(keyPath, value))
            }
        }
    }
}
