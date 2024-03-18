import SwiftUI
import Storage
import Models
import TCA

struct ItemRowInRecipe: View {
    var item: any Item
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
            HStack(spacing: 8) {
                Image(item.id)
                    .resizable()
                    .frame(width: 46, height: 46)
                    .padding(5)
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
                
                Text(item.localizedName)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding([.leading, .vertical], 4)
            .padding(.trailing, 8)
            .background(
                Color("Secondary").opacity(0.3),
                in: AngledRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.25)
            )
            .background(
                .background.opacity(0.9),
                in: AngledRectangle(cornerRadius: 10)
            )
            .fixedSize(horizontal: false, vertical: true)
            
            Text(amountPerMinute)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical, 4)
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
    @Dependency(\.storageClient) private static var storageClient
    
    static var previews: some View {
        ItemRowInRecipe(
            item: storageClient.partWithID("heavy-modular-frame")!,
            amountPerMinute: "25"
        )
        .previewLayout(.sizeThatFits)
        
        ItemRowInRecipe(
            item: storageClient.partWithID("heavy-modular-frame")!,
            amountPerMinute: "25",
            isSelected: true
        )
        .previewLayout(.sizeThatFits)
    }
}
