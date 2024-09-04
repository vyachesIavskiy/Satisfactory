import SwiftUI
import SHModels

@Observable
public final class RecipeIngredientAmountViewModel {
    let item: any Item
    let amount: Double
    let foregroundStyle: AnyShapeStyle
    let secondaryStyle: AnyShapeStyle?
    let primaryColor: Color
    let shadowColor: Color
    
    var cornerRadius: Double {
        switch (item as? Part)?.form {
        case .solid, nil: 5.0
        case .fluid, .gas: 10.0
        }
    }
    
    public convenience init(recipeIngredient ingredient: Recipe.Ingredient, amount: Double) {
        let primaryColor: Color
        let shadowColor: Color
        var secondaryStyle: AnyShapeStyle?
        let form = (ingredient.item as? Part)?.form
        
        switch ingredient.role {
        case .output:
            primaryColor = .sh(.gray50)
            shadowColor = .sh(.gray30)
            
        case .byproduct:
            switch form {
            case .solid, nil:
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.orange10), .sh(.orange50)]))
                
            case .fluid, .gas:
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.cyan10), .sh(.cyan50)]))
            }
            
        case .input:
            switch form {
            case .solid, nil:
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
                
            case .fluid, .gas:
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
            }
        }
        
        self.init(
            item: ingredient.item,
            amount: amount,
            secondaryStyle: secondaryStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    public init(
        item: any Item,
        amount: Double,
        foregroundStyle: AnyShapeStyle = AnyShapeStyle(.background),
        secondaryStyle: AnyShapeStyle? = nil,
        primaryColor: Color,
        shadowColor: Color
    ) {
        self.item = item
        self.amount = amount
        self.foregroundStyle = foregroundStyle
        self.secondaryStyle = secondaryStyle
        self.primaryColor = primaryColor
        self.shadowColor = shadowColor
    }
}
