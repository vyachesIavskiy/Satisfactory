import Foundation
import SHModels

// MARK: Static
extension Extraction {
    public struct Static: Codable {
        public let buildingID: String
        public let naturalResourceIDs: [String]
        public let rates: [Rate]
        
        public init(buildingID: String, naturalResourceIDs: [String], rates: [Rate]) {
            self.buildingID = buildingID
            self.naturalResourceIDs = naturalResourceIDs
            self.rates = rates
        }
    }
    
    public init(
        _ extraction: Static,
        buildingProvider: (_ buildingID: String) throws -> Building,
        partProvider: (_ partID: String) throws -> Part
    ) throws {
        try self.init(
            building: buildingProvider(extraction.buildingID),
            naturalResources: extraction.naturalResourceIDs.map(partProvider),
            rates: extraction.rates.map(Extraction.Rate.init)
        )
    }
}

// MARK: Static rate
extension Extraction.Static {
    public struct Rate: Codable {
        public let purityID: String
        public let amount: Double
        
        public init(purityID: String, amount: Double) {
            self.purityID = purityID
            self.amount = amount
        }
    }
}

// MARK: Static inits
private extension Extraction.Rate {
    init(_ rate: Extraction.Static.Rate) throws {
        try self.init(
            purity: Extraction.Purity(purityID: rate.purityID),
            amount: rate.amount
        )
    }
}

private extension Extraction.Purity {
    init(purityID id: String) throws {
        self = switch id {
        case Self.impure.id: .impure
        case Self.normal.id: .normal
        case Self.pure.id: .pure
            
        default: throw Error.invalidID(id)
        }
    }
}

// MARK: Errors
private extension Extraction.Purity {
    enum Error: LocalizedError {
        case invalidID(String)
        
        var errorDescription: String? {
            switch self {
            case let .invalidID(id): "Failed to initialized NaturalResourceExtraction.Purity with ID '\(id)'"
            }
        }
    }
}
