import Foundation

extension SHLogger {
    public func fault<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _fault(message())
    }
    
    @_disfavoredOverload
    public func fault(_ message: @autoclosure () -> CustomDebugStringConvertible) {
        _fault(message().debugDescription)
    }
    
    @_disfavoredOverload
    public func fault(_ message: @autoclosure () -> CustomStringConvertible) {
        _fault(message().description)
    }
    
    @_disfavoredOverload
    public func fault(_ message: @autoclosure () -> LosslessStringConvertible) {
        _fault(message().description)
    }
    
    @_disfavoredOverload
    public func fault(_ message: @autoclosure () -> CustomDebugStringConvertible & CustomStringConvertible) {
        // For fault messages force debug description
        _fault(message().debugDescription)
    }
    
    public func fault(_ message: @autoclosure () -> CustomDebugStringConvertible & LosslessStringConvertible) {
        // For fault messages force debug description
        _fault(message().debugDescription)
    }
    
    // MARK: Errors
    @_disfavoredOverload
    public func fault(_ error: @autoclosure () -> Error) {
        _error("\(error())")
    }
    
    public func fault(_ error: @autoclosure () -> LocalizedError) {
        _error("\(error())")
    }
    
    public func fault(_ error: @autoclosure () -> CustomNSError) {
        _error("\(error())")
    }
    
    func _fault<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _log(level: .error, message())
    }
}
