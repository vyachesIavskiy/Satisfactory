import OSLog

public struct SHLogger {
    public enum Level: Int, Equatable, Comparable {
        case debug
        case trace
        case notice
        case log
        case info
        case warning
        case error
        case critical
        case fault
        
        public static func < (lhs: Self, rhs: Self) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
        
        public static var `default`: Self { .info }
    }
    
    public var level: Level
    
    private let _logger: Logger
    
    public init(level: Level = .default, subsystemName: String, category: String) {
        self.level = level
        self._logger = Logger(subsystem: "com.breath.SatisfactoryHelper.\(subsystemName)", category: category)
    }
    
    public func callAsFunction(scope: Level = .info, _ handler: (Logger) -> Void) {
        if scope >= level {
            handler(_logger)
        }
    }
}
