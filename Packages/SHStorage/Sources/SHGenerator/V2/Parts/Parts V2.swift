import SHModels
import SHStaticModels

extension Part.Static {
    init(id: String, category: Category, form: Part.Form, isNaturalResource: Bool = false) {
        self.init(id: id, categoryID: category.id, formID: form.id, isNaturalResource: isNaturalResource)
    }
}

extension V2 {
    enum Parts {
        static let all =
        oreParts +
        fluidParts +
        matterParts +
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
        oilProductParts +
        consumablesParts +
        ammunitionParts +
        nuclearParts +
        quantumTechnologyParts +
        spaceElevatorParts +
        alienRemainsParts +
        powerSlugParts +
        powerShardParts +
        ficsmasParts +
        specialParts
    }
}
