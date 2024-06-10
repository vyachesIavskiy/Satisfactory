import SHModels
import SHPersistentModels

extension Configuration {
    init(_ v2: Configuration.Persistent.V2) {
        self.init(version: v2.version)
    }
}

extension Configuration.Persistent.V2 {
    init(_ configuration: Configuration) {
        self.init(version: configuration.version)
    }
}
