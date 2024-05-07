
extension SHLogger {
    public func debug<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _debug(message())
    }
    
    @_disfavoredOverload
    public func debug(_ message: @autoclosure () -> CustomDebugStringConvertible) {
        _debug(message().debugDescription)
    }
    
    @_disfavoredOverload
    public func debug(_ message: @autoclosure () -> CustomStringConvertible) {
        _debug(message().description)
    }
    
    @_disfavoredOverload
    public func debug(_ message: @autoclosure () -> LosslessStringConvertible) {
        _debug(message().description)
    }
    
    @_disfavoredOverload
    public func debug(_ message: @autoclosure () -> CustomDebugStringConvertible & CustomStringConvertible) {
        // For debug messages force debug description
        _debug(message().debugDescription)
    }
    
    public func debug(_ message: @autoclosure () -> CustomDebugStringConvertible & LosslessStringConvertible) {
        // For debug messages force debug description
        _debug(message().debugDescription)
    }
    
    // MARK: Shared
    func _debug<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _log(level: .debug, message())
    }
}
