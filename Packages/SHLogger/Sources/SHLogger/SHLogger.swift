import OSLog
import XCTestDynamicOverlay

public final class SHLogger {
    private let _logger: os.Logger
    public var isEnabled = true
    
    #if DEBUG
    private(set) var logs = [String]()
    #endif
    
    public init(subsystemName: String, category: String) {
        _logger = os.Logger(subsystem: "com.breath.Satisfactory.\(subsystemName)", category: category)
    }
    
    public func log<S: StringProtocol>(level: OSLogType = .default, _ message: @autoclosure () -> S) {
        _log(level: level, message())
    }
    
    @_disfavoredOverload
    public func log(level: OSLogType = .default, _ message: @autoclosure () -> CustomDebugStringConvertible) {
        _log(level: level, message().debugDescription)
    }
    
    @_disfavoredOverload
    public func log(level: OSLogType = .default, _ message: @autoclosure () -> CustomStringConvertible) {
        _log(level: level, message().description)
    }
    
    @_disfavoredOverload
    public func log(level: OSLogType = .default, _ message: @autoclosure () -> LosslessStringConvertible) {
        _log(level: level, message().description)
    }
    
    @_disfavoredOverload
    public func log(level: OSLogType = .default, _ message: @autoclosure () -> CustomDebugStringConvertible & LosslessStringConvertible) {
        _log(level: level, message().description)
    }
    
    public func log(level: OSLogType = .default, _ message: @autoclosure () -> CustomDebugStringConvertible & CustomStringConvertible) {
        _log(level: level, message().description)
    }
    
    // MARK: Shared
    func _log<S: StringProtocol>(level: OSLogType = .default, _ message: @autoclosure () -> S) {
        guard isEnabled else { return }
        
        let message = "\(message())"
        _logger.log(level: level, "\(message)")
        
        #if DEBUG
        guard _XCTIsTesting else { return }
        
        logs.append(message)
        #endif
    }
    
    #if DEBUG
    func clear() {
        guard _XCTIsTesting else { return }
        
        logs = []
    }
    #else
    @inlinable @inline(__always) func clear() {}
    #endif
}
