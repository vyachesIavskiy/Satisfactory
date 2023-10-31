import StaticModels
import Models

extension StaticModels.Part {
    init(id: String, category: Models.Category, form: Models.Part.Form, isNaturalResource: Bool = false) {
        self.init(id: id, categoryID: category.id, formID: form.id, isNaturalResource: isNaturalResource)
    }
}

extension V2 {
    enum Parts {
        static var all =
        alienParts +
        biomassParts +
        communicationParts +
        consumedParts +
        containerParts +
        electronicParts +
        ficsmasParts +
        fluidParts +
        fuelParts +
        gasParts +
        industrialParts +
        ingotParts +
        mineralParts +
        nuclearParts +
        oilProductParts +
        oreParts +
        powerShardParts +
        powerSlugParts +
        quantumTechnologyParts +
        spaceElevatorParts +
        specialParts +
        standardParts
    }
}
