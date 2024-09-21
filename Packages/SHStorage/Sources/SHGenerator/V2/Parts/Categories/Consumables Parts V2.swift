import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .consumables, form: .solid)
    }
}

extension V2.Parts {
    static let gasFilter = Part.Static(id: "part-gas-filter")
    static let iodineInfusedFilter = Part.Static(id: "part-iodine-infused-filter")
    
    static let consumablesParts = [
        gasFilter,
        iodineInfusedFilter,
    ]
}
