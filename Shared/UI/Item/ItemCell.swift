import SwiftUI
import Storage
import Models
import TCA

struct ItemCell: View {
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
        VStack(spacing: 4) {
            Image(item.id)
                .resizable()
                .frame(width: 54, height: 54)
                .padding(6)
                .background(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 8).stroke(lineWidth: 1)
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
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding([.horizontal, .top], 4)
        .padding(.bottom, 5)
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
    @Dependency(\.storageClient) private static var storageClient
    
    static var previews: some View {
        ItemCell(
            item: storageClient.partWithID("reinforced-iron-plate")!,
            amountPerMinute: "10"
        )
        .previewDisplayName("Unselected")
        
        ItemCell(
            item: storageClient.partWithID("reinforced-iron-plate")!,
            amountPerMinute: "10",
            isSelected: true
        )
        .previewDisplayName("Selected")
    }
}
