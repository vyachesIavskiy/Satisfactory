import SwiftUI

protocol DataProviderProtocol {
    var version: Int { get async }
    var parts: [PartNetwork] { get async }
    var equipments: [EquipmentNetwork] { get async }
    var buildings: [BuildingNetwork] { get async }
    var recipes: [RecipeNetwork] { get async }
}

// MARK: - Environment
struct DataProviderEnvironmentKey: EnvironmentKey {
    static var defaultValue: DataProviderProtocol = BundleDataProvider()
}

extension EnvironmentValues {
    var dataProvider: DataProviderProtocol {
        get { self[DataProviderEnvironmentKey.self] }
        set { self[DataProviderEnvironmentKey.self] = newValue }
    }
}
// MARK: -

final class NetworkDataProvider: DataProviderProtocol {
    var version: Int {
        get async {
            1
        }
    }
    
    var parts: [PartNetwork] {
        get async {
            []
        }
    }
    
    var equipments: [EquipmentNetwork] {
        get async {
            []
        }
    }
    
    var buildings: [BuildingNetwork] {
        get async {
            []
        }
    }
    
    var recipes: [RecipeNetwork] {
        get async {
            []
        }
    }
}

final class BundleDataProvider: DataProviderProtocol {
    var version: Int {
        get async {
            Bundle.main.version.version
        }
    }
    
    var parts: [PartNetwork] {
        get async {
            Bundle.main.parts
        }
    }
    
    var equipments: [EquipmentNetwork] {
        get async {
            Bundle.main.equipments
        }
    }
    
    var buildings: [BuildingNetwork] {
        get async {
            Bundle.main.buildings
        }
    }
    
    var recipes: [RecipeNetwork] {
        get async {
            Bundle.main.recipes
        }
    }
}
