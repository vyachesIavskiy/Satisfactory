import SwiftUI

struct ItemRow: View {
    @EnvironmentObject private var storage: Storage
    
    private var productionChains: [ProductionChain] {
        storage.productionChains.filter { $0.item.id == item.id }
    }
    
    var item: Item
    var showAmountOfProductionChains = false
    
    var body: some View {
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(item.name)
            
            Spacer()
            
            if !productionChains.isEmpty && showAmountOfProductionChains {
                HStack(spacing: 2) {
                    Text("\(productionChains.count)")
                        .fontWeight(.semibold)
                    
                    Image(systemName: "scale.3d")
                }
                .foregroundColor(.white)
                .padding(3)
                .background(Color.orange)
                .cornerRadius(6)
            }
        }
    }
}

struct ItemRowPreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemRow(item: storage[partID: "iron-plate"]!)
            .previewLayout(.sizeThatFits)
            .environmentObject(storage)
    }
}
