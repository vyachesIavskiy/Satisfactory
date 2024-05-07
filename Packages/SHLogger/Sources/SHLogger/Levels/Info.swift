
extension SHLogger {
    public func info<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _info(message())
    }
    
    @_disfavoredOverload
    public func info(_ message: @autoclosure () -> CustomDebugStringConvertible) {
        _info(message().debugDescription)
    }
    
    @_disfavoredOverload
    public func info(_ message: @autoclosure () -> CustomStringConvertible) {
        _info(message().description)
    }
    
    @_disfavoredOverload
    public func info(_ message: @autoclosure () -> LosslessStringConvertible) {
        _info(message().description)
    }
    
    @_disfavoredOverload
    public func info(_ message: @autoclosure () -> CustomDebugStringConvertible & CustomStringConvertible) {
        // For info messages force description
        _info(message().description)
    }
    
    public func info(_ message: @autoclosure () -> CustomDebugStringConvertible & LosslessStringConvertible) {
        // For info messages force description
        _info(message().description)
    }
    
    // MARK: Shared
    func _info<S: StringProtocol>(_ message: @autoclosure () -> S) {
        _log(level: .info, message())
    }
}
