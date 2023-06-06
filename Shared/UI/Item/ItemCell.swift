import SwiftUI

struct ItemCell: View {
    var item: Item
    var amountPerMinute: String
    var isOutput: Bool = false
    var isSelected: Bool = false
    var isExtractable: Bool = false
    
    private var selectionGradient: Gradient {
        if isSelected {
            return .itemSelection
        }
        
        if isExtractable {
            return .itemExtractable
        }
        
        return .empty
    }
    
    private var backgroundColor: Color {
        if isOutput {
            return Color("Output")
        }
        
        return Color("Primary")
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Image(item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(5)
                .background(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 8).stroke(lineWidth: 1.5)
                )
                .background(
                    LinearGradient(
                        gradient: selectionGradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    in: AngledRectangle(cornerRadius: 8)
                )
                .background(
                    .background,
                    in: AngledRectangle(cornerRadius: 8)
                )
            
            Text(amountPerMinute)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 15)
        }
        .padding([.horizontal, .top], 3)
        .padding(.bottom, 4)
        .fixedSize()
        .background(
            Color("Secondary").opacity(0.3),
            in: AngledRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.5)
        )
        .background(
            backgroundColor,
            in: AngledRectangle(cornerRadius: 10)
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
        .previewDisplayName("Unselected")
        
        ItemCell(
            item: storage[partID: "reinforced-iron-plate"]!,
            amountPerMinute: "10",
            isSelected: true
        )
        .previewDisplayName("Selected")
    }
}
