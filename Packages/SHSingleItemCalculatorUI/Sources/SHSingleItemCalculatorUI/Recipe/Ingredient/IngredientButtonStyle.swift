import SwiftUI
import SHSharedUI
import SHModels

struct RecipeIngredientButtonStyle: ButtonStyle {
    @Environment(\.isEnabled)
    private var isEnabled
    
    private let item: any Item
    
    private var foregroundColor: Color {
        if (item as? Part)?.form == .solid {
            .sh(.orange80)
        } else {
            .sh(.cyan80)
        }
    }
    
    private var backgroundColor: Color {
        if (item as? Part)?.form == .solid {
            .sh(.orange10)
        } else {
            .sh(.cyan10)
        }
    }
    
    private var backgroundShape: some Shape {
        if (item as? Part)?.form == .solid {
            AnyShape(AngledRectangle(cornerRadius: 8))
        } else {
            AnyShape(UnevenRoundedRectangle(bottomLeadingRadius: 10, topTrailingRadius: 10))
        }
    }
    
    init(_ item: any Item) {
        self.item = item
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .disabledStyle(!isEnabled)
            .background(
                configuration.isPressed ? backgroundColor : .clear,
                in: backgroundShape
            )
    }
}

extension ButtonStyle where Self == RecipeIngredientButtonStyle {
    static func shIngredient(_ item: any Item) -> Self {
        RecipeIngredientButtonStyle(item)
    }
}
