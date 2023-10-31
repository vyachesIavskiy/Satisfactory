import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .electronics, form: .solid)
    }
}

extension V2.Parts {
    static let wire = Part(id: "part-wire")
    static let cable = Part(id: "part-cable")
    static let quickwire = Part(id: "part-quickwire")
    static let aiLimiter = Part(id: "part-ai-limiter")
    static let circuitBoard = Part(id: "part-circuit-board")
    static let highSpeedConnector = Part(id: "part-high-speed-connector")
    
    static let electronicParts = [
        wire,
        cable,
        quickwire,
        aiLimiter,
        circuitBoard,
        highSpeedConnector
    ]
}
