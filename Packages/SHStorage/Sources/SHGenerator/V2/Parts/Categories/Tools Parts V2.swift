import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .tools, form: .solid)
    }
}

extension V2.Parts {
    static let portableMiner = Part.Static(id: "equipment-portable-miner")
    
    static let toolsParts = [
        portableMiner,
    ]
}
