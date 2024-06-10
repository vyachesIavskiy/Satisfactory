import SwiftUI

struct ItemRowInRecipe: View {
    var item: Item
    var amountPerMinute: String
    var isOutput: Bool = false
    var isSelected: Bool = false
    var isExtractable: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var selectionGradient: Gradient {
        if isSelected {
            return .itemSelection
        }
        
        if isExtractable {
            return .itemExtractable
        }
        
        return .empty
    }
    
    private var itemBackgroundColor: AnyShapeStyle {
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
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(item.imageName)
                    .resizable()
                    .frame(width: 46, height: 46)
                    .padding(5)
                
                Text(item.name)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .vertical], 4)
            .padding(.trailing, 8)
            .background(
                Color("Primary").opacity(isSelected ? 0.2 : 0.0),
                in: AngledRectangle(cornerRadius: 10)
            )
            .background(
                itemBackgroundColor,
                in: AngledRectangle(cornerRadius: 10)
            )
            .overlay(
                Color("Secondary").opacity(0.3),
                in: AngledBottomLine(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            )
            .fixedSize(horizontal: false, vertical: true)
            
            Text(amountPerMinute)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
        }
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

#if DEBUG
#Preview("Variant 1") {
    let storage: Storage = PreviewStorage()
    
    return VStack(spacing: 30) {
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25"
        )
        
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isOutput: true
        )
        
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isExtractable: true
        )
        
        ItemRowInRecipe(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isSelected: true
        )
    }
    .padding()
}

struct ItemRowInRecipe2: View {
    var item: Item
    var amountPerMinute: String
    var isOutput: Bool = false
    var isSelected: Bool = false
    var isExtractable: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    private var itemBackgroundColor: AnyShapeStyle {
        switch colorScheme {
        case .light: AnyShapeStyle(.background)
        case .dark: AnyShapeStyle(.background.quinary)
            
        @unknown default: AnyShapeStyle(.background)
        }
    }
    
    private var backgroundColor: Color {
        if isOutput {
            Color("Output")
        } else if isExtractable {
            Color("Secondary").opacity(0.65)
        } else {
            Color("Primary")
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            Image(item.imageName)
                .resizable()
                .frame(width: 35, height: 35)
                .padding(.vertical, 5)
                .padding(.leading, 10)
            
            Text(item.name)
            
            Spacer()
            
            Text(amountPerMinute)
                .font(.headline)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 16)
        }
        .background(
            Color("Primary").opacity(isSelected ? 0.35 : 0.0),
            in: AngledRectangle(cornerRadius: 10)
        )
        .overlay(
            backgroundColor,
            in: AngledRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
        )
    }
}

#Preview("Variant 2") {
    let storage: Storage = PreviewStorage()
    
    return VStack(spacing: 30) {
        ItemRowInRecipe2(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25"
        )
        
        ItemRowInRecipe2(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isOutput: true
        )
        
        ItemRowInRecipe2(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isExtractable: true
        )
        
        ItemRowInRecipe2(
            item: storage[partID: "heavy-modular-frame"]!,
            amountPerMinute: "25",
            isSelected: true
        )
    }
    .padding()
}
#endif
