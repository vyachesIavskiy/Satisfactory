import SwiftUI

struct ItemCell: View {
    var item: Item
    var amountPerMinute: String
    var isSelected: Bool = false
    
    var body: some View {
        Image(item.imageName)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding([.top, .leading, .trailing], 4)
            .padding(.bottom, 6)
            .frame(width: 70, height: 70)
            .background(
                .thinMaterial
            )
            .background(
                isSelected ? Color.orange : Color.clear
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

struct ItemCellPreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
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
    }
}
