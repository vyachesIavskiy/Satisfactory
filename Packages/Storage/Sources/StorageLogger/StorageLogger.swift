
@_exported import OSLog

public enum LoggerCategory: String {
    case generator = "Generator"
    case persistent = "Persistent Storage"
    case persistentLegacy = "Persistent Storage Legacy"
    case persistentV2 = "Persistent Storage V2"
    case persistence = "Persistence"
    case `static` = "Static Storage"
    case fileManager = "File Manager"
    case storage = "Storage"
}

public extension Logger {
    init(category: LoggerCategory) {
        self.init(subsystem: "com.breath.Satisfactory.Storage", category: category.rawValue)
    }
}
