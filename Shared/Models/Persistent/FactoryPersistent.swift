import Foundation

struct FactoryPersistent {
    var id: UUID
    var name: String
    var image: ImageFormat
    var productionIDs: [UUID]
    
    enum ImageFormat: Codable {
        case text(String)
        case asset(String)
    }
}

extension FactoryPersistent: PersistentStoragable {
    static var domain: String { "Factories" }
    var filename: String { "factory-\(id)" }
}

extension FactoryPersistent.ImageFormat {
    init(_ imageFormat: Factory.ImageFormat) {
        self = switch imageFormat {
        case let .text(text): .text(text)
        case let .asset(imageName): .asset(imageName)
        }
    }
}

extension Factory.ImageFormat {
    init(_ imageFormat: FactoryPersistent.ImageFormat) {
        self = switch imageFormat {
        case let .text(text): .text(text)
        case let .asset(imageName): .asset(imageName)
        }
    }
}
