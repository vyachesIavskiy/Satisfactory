import Foundation
import SHModels
import SHSingleItemProduction

enum SHProduction {
    case singleItem(Production)
//    case fromResources(Production)
//    case power(Production)
    
    var id: UUID {
        switch self {
        case let .singleItem(production): production.id
        }
    }
    
    var name: String {
        switch self {
        case let .singleItem(production): production.name
        }
    }
    
//    var image: Image ???
}
