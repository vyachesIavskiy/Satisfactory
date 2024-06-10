import SHModels
import SHStaticModels

extension Recipe.Static.Legacy.Ingredient {
    init(_ part: Part.Static.Legacy, amount: Double) {
        self.init(id: part.id, amount: amount)
    }
    
    init(_ equipment: Equipment.Static.Legacy, amount: Double) {
        self.init(id: equipment.id, amount: amount)
    }
}
