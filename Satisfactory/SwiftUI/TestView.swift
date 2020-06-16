import SwiftUI

struct TestView: View {
    var recipes: [Recipe] {
        let rip = Storage.shared[partName: "Reinforced Iron Plate"]!.id
        let screw = Storage.shared[partName: "Screw"]!.id
        let ironPlate = Storage.shared[partName: "Iron Plate"]!.id
        let ironRod = Storage.shared[partName: "Iron Rod"]!.id
        let ironIngot = Storage.shared[partName: "Iron Ingot"]!.id
        
        return [
            Storage.shared[recipesFor: rip][0],
            Storage.shared[recipesFor: screw][0],
            Storage.shared[recipesFor: ironPlate][0],
            Storage.shared[recipesFor: ironRod][0],
            Storage.shared[recipesFor: ironIngot][0]
        ]
    }
    
    var production: [Recipe: Int] {
        calculateProduction(item: Storage.shared[partName: "Reinforced Iron Plate"]!.id, amount: 1, selectedRecipes: recipes)
    }
    
    var body: some View {
        List {
            ForEach(Array(production.keys), id: \.self) { key in
                Text("It's needed \(self.production[key]!) of \(Storage.shared[buildingId: key.machine]!.name) that produce \(key.output[0].item.name)")
            }
        }
    }
}

#if DEBUG
struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
#endif
