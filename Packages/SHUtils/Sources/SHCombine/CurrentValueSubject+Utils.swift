import Combine

public extension CurrentValueSubject {
    func update<T>(_ keyPath: WritableKeyPath<Output, T>, value newValue: T) {
        var newSubjectValue = value
        newSubjectValue[keyPath: keyPath] = newValue
        send(newSubjectValue)
    }
    
    var stream: AsyncThrowingStream<Output, Error> {
        AsyncThrowingStream { [unowned self] continuation in
            let cancellable = dropFirst()
                .sink { completion in
                    switch completion {
                    case .finished: continuation.finish()
                    case let .failur1e(error): continuation.finish(throwing: error)
                    }
                } receiveValue: { value in
                    continuation.yield(value)
                }
            
            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
}

public extension CurrentValueSubject where Failure == Never {
    var stream: AsyncStream<Output> {
        AsyncStream { [unowned self] continuation in
            let cancellable = dropFirst()
                .sink { completion in
                    continuation.finish()
                } receiveValue: { value in
                    continuation.yield(value)
                }
            
            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
}
