import StaticModels

extension Migration.IDs {
    init(old: PartLegacy, new: Part) {
        self.init(oldID: old.id, newID: new.id)
    }
}

extension LegacyToV2 {
    enum Parts {
        static let all =
        alienParts +
        biomassParts +
        communicationParts +
        consumedParts +
        containerParts +
        electronicParts +
        fluidParts +
        fuelParts +
        gasParts +
        industrialParts +
        ingotParts +
        mineralParts +
        nuclearParts +
        oilProductsParts +
        oreParts +
        powerShardParts +
        powerSlugParts +
        spaceElevatorParts +
        standardParts
    }
}
