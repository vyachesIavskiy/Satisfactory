import SwiftUI

struct ItemCell: View {
    var item: Item
    var amountPerMinute: String
    var isOutput: Bool = false
    var isSelected: Bool = false
    var isExtractable: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var itemBackgroundStyle: AnyShapeStyle {
        switch colorScheme {
        case .light: AnyShapeStyle(.background)
        case .dark: AnyShapeStyle(.background.quinary)
            
        @unknown default: AnyShapeStyle(.background)
        }
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
                .padding(8)
                .background(
                    Color("Primary").opacity(isSelected ? 0.2 : 0.0),
                    in: AngledRectangle(cornerRadius: 10)
                )
                .background(
                    .background,
                    in: AngledRectangle(cornerRadius: 10)
                )
                .overlay(
                    Color("Secondary").opacity(0.3),
                    in: AngledBottomLine(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
            
            Text(amountPerMinute)
                .foregroundColor(.white)
                .frame(maxWidth: 50)
        }
        .padding(.bottom, 5)
        .fixedSize()
        .background(
            backgroundColor,
            in: AngledRectangle(cornerRadius: 10)
        )
        .overlay(
            Color("Secondary").opacity(0.3),
            in: AngledRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.5)
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
