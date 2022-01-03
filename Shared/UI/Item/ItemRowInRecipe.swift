import SwiftUI

struct ItemRowInRecipe: View {
    var item: Item
    var amountPerMinute: String
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 10.0) {
            Image(item.imageName)
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
            isSelected ? Color.orange : Color.clear
        )
    }
}

struct ItemRowInRecipePreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
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
