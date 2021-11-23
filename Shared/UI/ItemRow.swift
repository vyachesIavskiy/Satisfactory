import SwiftUI

struct ItemRow: View {
    @EnvironmentObject private var storage: Storage
    
    private var productionChains: [ProductionChain] {
        storage.productionChains.filter { $0.item.id == item.id }
    }
    
    var item: Item
    var showAmountOfProductionChains = false
    
    var body: some View {
        HStack(spacing: 10.0) {
            Image(item.name)
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

struct ItemCell: View {
    var item: Item
    var amountPerMinute: String
    var isSelected: Bool = false
    
    var body: some View {
        Image(item.name)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding([.top, .leading, .trailing], 4)
            .padding(.bottom, 6)
            .frame(width: 70, height: 70)
            .background(
                .thinMaterial
            )
            .background(
                isSelected ? Color.green : Color.clear
            )
            .cornerRadius(6)
            .overlay(
                VStack {
                    Spacer()
                    
                    Text(amountPerMinute)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .frame(width: 70)
                        .background(Color.orange)
                        .cornerRadius(3)
                }
            )
    }
}

struct ItemRowInRecipe: View {
    var item: Item
    var amountPerMinute: String
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 10.0) {
            Image(item.name)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(item.name)
            
            Spacer()
            
            Text(amountPerMinute)
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.trailing, 4)
        }
        .padding(8)
        .background(.thinMaterial)
        .background(
            isSelected ? Color.green : Color.clear
        )
    }
}

struct ItemRow_Previews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemRow(item: storage[partID: "iron-plate"]!)
            .previewLayout(.sizeThatFits)
            .environmentObject(storage)
        
        ItemCell(
            item: storage[partID: "reinforced-iron-plate"]!,
            amountPerMinute: "10"
        )
            .previewLayout(.sizeThatFits)
        
        ItemCell(
            item: storage[partID: "reinforced-iron-plate"]!,
            amountPerMinute: "10",
            isSelected: true
        )
            .previewLayout(.sizeThatFits)
        
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25"
        )
            .previewLayout(.sizeThatFits)
        
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isSelected: true
        )
            .previewLayout(.sizeThatFits)
    }
}
