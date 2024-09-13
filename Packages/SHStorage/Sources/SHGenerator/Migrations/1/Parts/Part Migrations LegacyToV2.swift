import SHModels
import SHStaticModels

extension Migration.IDs {
    init(old: Part.Static.Legacy, new: Part.Static) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Parts {
        static let all =
        oreParts +
        fluidParts +
        gasParts +
        ingotParts +
        standardParts +
        electronicParts +
        compoundsParts +
        biomassParts +
        toolsParts +
        industrialParts +
        communicationParts +
        containerParts +
        packagingParts +
        oilProductsParts +
        consumablesParts +
        ammunitionParts +
        nuclearParts +
        spaceElevatorParts +
        alienRemainsParts +
        powerSlugParts +
        powerShardParts
    }
}
