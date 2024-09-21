import SHModels
import SHStaticModels

extension Extraction.Static {
    init(building: Building.Static, naturalResources: [Part.Static], rates: [Extraction.Rate]) {
        self.init(
            buildingID: building.id,
            naturalResourceIDs: naturalResources.map(\.id),
            rates: rates.map {
                Extraction.Static.Rate(purityID: $0.purity.id, amount: $0.amount)
            }
        )
    }
}

extension V2 {
    enum Extractions {
        static let all =
        minerExtractions +
        waterExtractions +
        oilExtractions +
        resourceWellExtractions
    }
}
