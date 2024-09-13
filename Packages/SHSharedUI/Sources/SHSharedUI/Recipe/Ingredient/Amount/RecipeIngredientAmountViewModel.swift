import SwiftUI
import SHModels

@Observable
public final class RecipeIngredientAmountViewModel {
    let part: Part
    let amount: Double
    let foregroundStyle: AnyShapeStyle
    let secondaryStyle: AnyShapeStyle?
    let primaryColor: Color
    let shadowColor: Color
    
    var cornerRadius: Double {
        switch part.form {
        case .solid: 5.0
        case .fluid, .gas, .matter: 10.0
        }
    }
    
    public convenience init(recipeIngredient ingredient: Recipe.Ingredient, amount: Double) {
        let primaryColor: Color
        let shadowColor: Color
        var secondaryStyle: AnyShapeStyle?
        let form = ingredient.part.form
        
        switch ingredient.role {
        case .output:
            primaryColor = .sh(.gray50)
            shadowColor = .sh(.gray30)
            
        case .byproduct:
            switch form {
            case .solid:
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.orange10), .sh(.orange50)]))
                
            case .fluid, .gas, .matter:
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.cyan10), .sh(.cyan50)]))
            }
            
        case .input:
            switch form {
            case .solid:
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
                
            case .fluid, .gas, .matter:
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
            }
        }
        
        self.init(
            part: ingredient.part,
            amount: amount,
            secondaryStyle: secondaryStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    public init(
        part: Part,
        amount: Double,
        foregroundStyle: AnyShapeStyle = AnyShapeStyle(.background),
        secondaryStyle: AnyShapeStyle? = nil,
        primaryColor: Color,
        shadowColor: Color
    ) {
        self.part = part
        self.amount = amount
        self.foregroundStyle = foregroundStyle
        self.secondaryStyle = secondaryStyle
        self.primaryColor = primaryColor
        self.shadowColor = shadowColor
    }
}
