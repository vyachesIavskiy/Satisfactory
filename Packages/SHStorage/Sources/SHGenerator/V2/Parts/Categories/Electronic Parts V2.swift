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
    static let circuitBoard = Part.Static(id: "part-circuit-board")
    static let quickwire = Part.Static(id: "part-quickwire")
    static let aiLimiter = Part.Static(id: "part-ai-limiter")
    static let highSpeedConnector = Part.Static(id: "part-high-speed-connector")
    static let reanimatedSAM = Part.Static(id: "part-reanimated-sam")
    static let samFluctuator = Part.Static(id: "part-sam-fluctuator")
    static let singularityCell = Part.Static(id: "part-singularity-cell")
    
    static let electronicParts = [
        wire,
        cable,
        circuitBoard,
        quickwire,
        aiLimiter,
        highSpeedConnector,
        reanimatedSAM,
        samFluctuator,
        singularityCell
    ]
}
