import StaticModels

private extension PartLegacy {
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
    static let wire = PartLegacy(id: "wire")
    static let cable = PartLegacy(id: "cable")
    static let quickwire = PartLegacy(id: "quickwire")
    static let aiLimiter = PartLegacy(id: "ai-limiter")
    static let circuitBoard = PartLegacy(id: "circuit-board")
    static let highSpeedConnector = PartLegacy(id: "high-speed-connector")
    
    static let electronicParts = [
        wire,
        cable,
        quickwire,
        aiLimiter,
        circuitBoard,
        highSpeedConnector
    ]
}
