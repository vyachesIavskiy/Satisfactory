import Models
import StaticModels

private extension Part.Static.Legacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.electronics.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let wire = Part.Static.Legacy(id: "wire")
    static let cable = Part.Static.Legacy(id: "cable")
    static let quickwire = Part.Static.Legacy(id: "quickwire")
    static let aiLimiter = Part.Static.Legacy(id: "ai-limiter")
    static let circuitBoard = Part.Static.Legacy(id: "circuit-board")
    static let highSpeedConnector = Part.Static.Legacy(id: "high-speed-connector")
    
    static let electronicParts = [
        wire,
        cable,
        quickwire,
        aiLimiter,
        circuitBoard,
        highSpeedConnector
    ]
}
