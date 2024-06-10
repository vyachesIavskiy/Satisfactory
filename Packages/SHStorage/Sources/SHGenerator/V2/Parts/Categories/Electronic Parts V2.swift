import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .electronics, form: .solid)
    }
}

extension V2.Parts {
    static let wire = Part.Static(id: "part-wire")
    static let cable = Part.Static(id: "part-cable")
    static let quickwire = Part.Static(id: "part-quickwire")
    static let aiLimiter = Part.Static(id: "part-ai-limiter")
    static let circuitBoard = Part.Static(id: "part-circuit-board")
    static let highSpeedConnector = Part.Static(id: "part-high-speed-connector")
    
    static let electronicParts = [
        wire,
        cable,
        quickwire,
        aiLimiter,
        circuitBoard,
        highSpeedConnector
    ]
}
