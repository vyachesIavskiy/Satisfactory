import Foundation

struct VersionPersistent: Codable {
    let version: Int
}

extension VersionPersistent: PersistentStoragable {
    static var domain: String { "" }
    var filename: String { "version" }
}
