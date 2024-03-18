
extension LegacyToV2.Parts {
    static let wire = Migration.IDs(old: Legacy.Parts.wire, new: V2.Parts.wire)
    static let cable = Migration.IDs(old: Legacy.Parts.cable, new: V2.Parts.cable)
    static let quickwire = Migration.IDs(old: Legacy.Parts.quickwire, new: V2.Parts.quickwire)
    static let aiLimiter = Migration.IDs(old: Legacy.Parts.aiLimiter, new: V2.Parts.aiLimiter)
    static let circuitBoard = Migration.IDs(old: Legacy.Parts.circuitBoard, new: V2.Parts.circuitBoard)
    static let highSpeedConnector = Migration.IDs(old: Legacy.Parts.highSpeedConnector, new: V2.Parts.highSpeedConnector)
    
    static let electronicParts = [
        wire,
        cable,
        quickwire,
        aiLimiter,
        circuitBoard,
        highSpeedConnector
    ]
}
