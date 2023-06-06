import SwiftUI

struct ItemRowInRecipe: View {
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
        VStack(spacing: 0) {
            HStack(spacing: 7) {
                Image(item.imageName)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(3)
                    .background(
                        Color("Secondary").opacity(0.3),
                        in: AngledRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
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
                
                Text(item.name)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding([.leading, .vertical], 3)
            .padding(.trailing, 7)
            .background(
                Color("Secondary").opacity(0.3),
                in: AngledRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.5)
            )
            .background(
                .background.opacity(0.9),
                in: AngledRectangle(cornerRadius: 10)
            )
            .fixedSize(horizontal: false, vertical: true)
            
            Text(amountPerMinute)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical, 2)
                .padding(.horizontal, 10)
        }
        .background(
            Color("Secondary").opacity(0.3),
            in: AngledRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.5)
        )
        .background(
            backgroundColor,
            in: AngledRectangle(cornerRadius: 10)
        )
        .frame(maxWidth: 250)
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
