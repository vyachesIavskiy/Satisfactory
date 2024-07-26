import SwiftUI
import SHModels
import SHSingleItemProduction

@Observable
final class RecipeIngredientAmountViewModel {
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
    
    convenience init(recipeIngredient ingredient: Recipe.Ingredient, amount: Double) {
        let primaryColor: Color
        let shadowColor: Color
        var secondaryStyle: AnyShapeStyle?
        let form = (ingredient.item as? Part)?.form
        
        switch ingredient.role {
        case .output:
            primaryColor = .sh(.gray40)
            shadowColor = .sh(.gray30)
            
        case .byproduct:
            switch form {
            case .solid, nil:
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
                secondaryStyle = AnyShapeStyle(.sh(.orange20).gradient)
                
            case .fluid, .gas:
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
                secondaryStyle = AnyShapeStyle(.sh(.cyan20).gradient)
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
    
    convenience init(productionOutput output: SHSingleItemProduction.OutputRecipe.OutputIngredient) {
        self.init(
            item: output.item,
            amount: output.amount,
            primaryColor: .sh(.gray40),
            shadowColor: .sh(.gray30)
        )
    }
    
    convenience init(productionByproduct byproduct: SHSingleItemProduction.OutputRecipe.OutputIngredient) {
        var foregroundStyle = AnyShapeStyle(.background)
        let secondaryStyle: AnyShapeStyle
        let primaryColor: Color
        let shadowColor: Color
        
        switch (byproduct.item as? Part)?.form {
        case .solid, nil:
            primaryColor = .sh(.orange)
            shadowColor = .sh(.orange30)
            
            if byproduct.isSelected {
                foregroundStyle = AnyShapeStyle(.sh(.orange30).gradient)
                secondaryStyle = AnyShapeStyle(.sh(.orange20))
            } else {
                secondaryStyle = AnyShapeStyle(.sh(.orange20).gradient)
            }
            
        case .fluid, .gas:
            primaryColor = .sh(.cyan)
            shadowColor = .sh(.cyan30)
            
            if byproduct.isSelected {
                foregroundStyle = AnyShapeStyle(.sh(.cyan30).gradient)
                secondaryStyle = AnyShapeStyle(.sh(.cyan20))
            } else {
                secondaryStyle = AnyShapeStyle(.sh(.cyan20).gradient)
            }
        }
        
        self.init(
            item: byproduct.item,
            amount: byproduct.amount,
            foregroundStyle: foregroundStyle,
            secondaryStyle: secondaryStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    convenience init(productionInput input: SHSingleItemProduction.OutputRecipe.InputIngredient) {
        let foregroundStyle: AnyShapeStyle
        let primaryColor: Color
        let shadowColor: Color
        let part = (input.item as? Part)
        let isNaturalResource = part?.isNaturalResource == true
        
        switch part?.form {
        case .solid, nil:
            if isNaturalResource {
                primaryColor = .sh(.orange80)
                shadowColor = .sh(.orange20)
            } else {
                primaryColor = .sh(.orange)
                shadowColor = .sh(.orange30)
            }
            
            if input.isSelected {
                foregroundStyle = AnyShapeStyle(.sh(.orange30).gradient)
            } else if isNaturalResource {
                foregroundStyle = AnyShapeStyle(.sh(.orange10).gradient)
            } else {
                foregroundStyle = AnyShapeStyle(.background)
            }
            
        case .fluid, .gas:
            if isNaturalResource {
                primaryColor = .sh(.gray80)
                shadowColor = .sh(.gray20)
            } else {
                primaryColor = .sh(.cyan)
                shadowColor = .sh(.cyan30)
            }
            
            if input.isSelected {
                foregroundStyle = AnyShapeStyle(.sh(.cyan30).gradient)
            } else if isNaturalResource {
                foregroundStyle = AnyShapeStyle(.sh(.cyan10).gradient)
            } else {
                foregroundStyle = AnyShapeStyle(.background)
            }
        }
        
        self.init(
            item: input.item,
            amount: input.amount,
            foregroundStyle: foregroundStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    convenience init(productionSecondaryByproduct byproduct: SHSingleItemProduction.OutputRecipe.Byproduct, item: any Item) {
        let foregroundColors = [
            Color.sh(.blue30),
            .sh(.magenta30),
            .sh(.purple30),
            .sh(.yellow30)
        ]
        
        let secondaryColors = [
            Color.sh(.blue20),
            .sh(.magenta20),
            .sh(.purple20),
            .sh(.yellow20)
        ]
        
        let primaryColors = [
            Color.sh(.blue),
            .sh(.magenta),
            .sh(.purple),
            .sh(.yellow)
        ]
        
        let shadowColors = [
            Color.sh(.blue30),
            .sh(.magenta30),
            .sh(.purple30),
            .sh(.yellow30)
        ]
        
        let resolvedIndex = byproduct.index % primaryColors.count
        
        let foregroundStyle = AnyShapeStyle(foregroundColors[resolvedIndex].gradient)
        let secondaryStyle = AnyShapeStyle(secondaryColors[resolvedIndex])
        let primaryColor = primaryColors[resolvedIndex]
        let shadowColor = shadowColors[resolvedIndex]
        
        self.init(
            item: item,
            amount: byproduct.amount,
            foregroundStyle: foregroundStyle,
            secondaryStyle: secondaryStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    private init(
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
