import SHLogger

extension SHLogger {
    init(level: Level = .info, category: String) {
        self.init(level: level, subsystemName: "SHStorage", category: category)
    }
}
