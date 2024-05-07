import Foundation

extension SHLogger {
    public func error<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _error(message())
    }
    
    @_disfavoredOverload
    public func error(_ message: @autoclosure () -> CustomDebugStringConvertible) {
        _error(message().debugDescription)
    }
    
    @_disfavoredOverload
    public func error(_ message: @autoclosure () -> CustomStringConvertible) {
        _error(message().description)
    }
    
    @_disfavoredOverload
    public func error(_ message: @autoclosure () -> LosslessStringConvertible) {
        _error(message().description)
    }
    
    @_disfavoredOverload
    public func error(_ message: @autoclosure () -> CustomDebugStringConvertible & CustomStringConvertible) {
        // For error messages force debug description
        _error(message().debugDescription)
    }
    
    public func error(_ message: @autoclosure () -> CustomDebugStringConvertible & LosslessStringConvertible) {
        // For error messages force debug description
        _error(message().debugDescription)
    }
    
    // MARK: Errors
    public func error(_ error: @autoclosure () -> Error) {
        _error("\(error())")
    }
    
    public func error(_ error: @autoclosure () -> LocalizedError) {
        _error("\(error())")
    }
    
    public func error(_ error: @autoclosure () -> CustomNSError) {
        _error("\(error())")
    }
    
    // MARK: Shared
    func _error<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _log(level: .error, message())
    }
}
