import StaticModels

extension RecipeLegacy.Ingredient {
    init(_ part: PartLegacy, amount: Double) {
        self.init(id: part.id, amount: amount)
    }
    
    init(_ equipment: EquipmentLegacy, amount: Double) {
        self.init(id: equipment.id, amount: amount)
    }
}
