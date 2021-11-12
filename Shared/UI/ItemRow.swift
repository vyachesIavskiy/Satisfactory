import SwiftUI

struct ItemRow: View {
    var item: Item
    
    var body: some View {
        HStack(spacing: 10.0) {
            Image(item.name)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(item.name)
        }
    }
}

struct ItemCell: View {
    var item: Item
    var amountPerMinute: String
    var isSelected: Bool
    
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
    
    init(item: Item, amountPerMinute: String, isSelected: Bool = false) {
        self.item = item
        self.amountPerMinute = amountPerMinute
        self.isSelected = isSelected
    }
}

struct ItemRow_Previews: PreviewProvider {
    @StateObject private static var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        ItemRow(item: storage[partID: "iron-plate"]!)
            .previewLayout(.sizeThatFits)
        
        ItemCell(item: storage[partID: "reinforced-iron-plate"]!, amountPerMinute: "10")
            .previewLayout(.sizeThatFits)
    }
}
