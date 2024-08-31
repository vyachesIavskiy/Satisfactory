import SHModels
import SHStaticModels

extension Recipe.Static.Legacy.Ingredient {
    init(_ part: Part.Static.Legacy) {
        self.init(id: part.id)
    }
    
    init(_ equipment: Equipment.Static.Legacy) {
        self.init(id: equipment.id)
    }
}
