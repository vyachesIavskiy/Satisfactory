
extension LegacyToV2.Parts {
    static let portableMiner = Migration.IDs(oldID: Legacy.Equipment.portableMiner.id, newID: V2.Parts.portableMiner.id)
    
    static let toolsParts = [
        portableMiner,
    ]
}
