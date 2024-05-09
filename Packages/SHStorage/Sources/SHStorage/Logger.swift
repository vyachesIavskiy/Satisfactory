import SHLogger

extension SHLogger {
    convenience init(category: String) {
        self.init(subsystemName: "SHStorage", category: category)
    }
}
