import Foundation

enum OreExtractionRate: Double, Codable, CaseIterable {
    case impure = 30
    case normal = 60
    case pure = 120
    
    enum CodingKeys: String, CodingKey {
        case impure
        case normal
        case pure
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .impure: try container.encode(rawValue, forKey: .impure)
        case .normal: try container.encode(rawValue, forKey: .normal)
        case .pure: try container.encode(rawValue, forKey: .pure)
        }
    }
}

enum FluidExctractionRate: Double, Codable, CaseIterable {
    case impure = 60
    case normal = 120
    case pure = 240
    
    enum CodingKeys: String, CodingKey {
        case impure
        case normal
        case pure
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .impure: try container.encode(rawValue, forKey: .impure)
        case .normal: try container.encode(rawValue, forKey: .normal)
        case .pure: try container.encode(rawValue, forKey: .pure)
        }
    }
}

enum GasExtractionRate: Double, Codable, CaseIterable {
    case impure = 30
    case normal = 60
    case pure = 120
    
    enum CodingKeys: String, CodingKey {
        case impure
        case normal
        case pure
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .impure: try container.encode(rawValue, forKey: .impure)
        case .normal: try container.encode(rawValue, forKey: .normal)
        case .pure: try container.encode(rawValue, forKey: .pure)
        }
    }
}

struct ExtractionRate: Codable {
    var oreExctractionRates: [OreExtractionRate]
    var fluidExctractionRates: [FluidExctractionRate]
    var gasExtractionRates: [GasExtractionRate]
}

let ExtractionRates = ExtractionRate(
    oreExctractionRates: OreExtractionRate.allCases,
    fluidExctractionRates: FluidExctractionRate.allCases,
    gasExtractionRates: GasExtractionRate.allCases
)
