import Models
import PersistentModels

extension StorageClient {
    final class InMemory {
        var parts: [Part]
        var equipment: [Equipment]
        var buildings: [Building]
        var recipes: [Recipe]
        var factories: [Factory]
        var pins: Pins.Persistent.V2
        
        init(
            parts: [Part] = [Part](),
            equipment: [Equipment] = [Equipment](),
            buildings: [Building] = [Building](),
            recipes: [Recipe] = [Recipe](),
            factories: [Factory] = [Factory](),
            pins: Pins.Persistent.V2 = Pins.Persistent.V2()
        ) {
            self.parts = parts
            self.equipment = equipment
            self.buildings = buildings
            self.recipes = recipes
            self.factories = factories
            self.pins = pins
        }
    }
}
