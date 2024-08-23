import SwiftUI
import SHModels
import SingleItemCalculator

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
    
    convenience init(productionOutput output: SingleItemCalculator.OutputRecipe.OutputIngredient) {
        self.init(
            item: output.item,
            amount: output.amount,
            primaryColor: .sh(.gray50),
            shadowColor: .sh(.gray30)
        )
    }
    
    convenience init(additionalProductionOutput output: SingleItemCalculator.OutputRecipe.OutputIngredient, amount: Double) {
        self.init(
            item: output.item,
            amount: amount,
            primaryColor: .sh(.gray50),
            shadowColor: .sh(.gray30)
        )
    }
    
    convenience init(productionByproduct byproduct: SingleItemCalculator.OutputRecipe.ByproductIngredient) {
        var foregroundStyle = AnyShapeStyle(.background)
        let secondaryStyle: AnyShapeStyle
        let primaryColor: Color
        let shadowColor: Color
        let part = (byproduct.item as? Part)
        let isNaturalResource = part?.isNaturalResource == true
        
        switch part?.form {
        case .solid, nil:
            primaryColor = .sh(.orange)
            shadowColor = .sh(.orange30)
            
            if byproduct.isSelected {
                foregroundStyle = AnyShapeStyle(Gradient(colors: [.sh(.orange30), .sh(.orange)]))
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.orange10), .sh(.orange40)]))
            } else {
                if isNaturalResource {
                    foregroundStyle = AnyShapeStyle(Gradient(stops: [
                        Gradient.Stop(color: .sh(.background1), location: 0),
                        Gradient.Stop(color: .sh(.background1), location: 0.7),
                        Gradient.Stop(color: .sh(.orange50), location: 1)
                    ]))
                }
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.orange10), .sh(.orange50)]))
            }
            
        case .fluid, .gas:
            primaryColor = .sh(.cyan)
            shadowColor = .sh(.cyan30)
            
            if byproduct.isSelected {
                foregroundStyle = AnyShapeStyle(Gradient(colors: [.sh(.cyan30), .sh(.cyan)]))
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.cyan10), .sh(.cyan40)]))
            } else {
                if isNaturalResource {
                    foregroundStyle = AnyShapeStyle(Gradient(stops: [
                        Gradient.Stop(color: .sh(.background1), location: 0),
                        Gradient.Stop(color: .sh(.background1), location: 0.7),
                        Gradient.Stop(color: .sh(.cyan50), location: 1)
                    ]))
                }
                secondaryStyle = AnyShapeStyle(Gradient(colors: [.sh(.cyan10), .sh(.cyan50)]))
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
    
    convenience init(productionInput input: SingleItemCalculator.OutputRecipe.InputIngredient) {
        let foregroundStyle: AnyShapeStyle
        let primaryColor: Color
        let shadowColor: Color
        let part = (input.item as? Part)
        let isNaturalResource = part?.isNaturalResource == true
        
        switch part?.form {
        case .solid, nil:
            primaryColor = .sh(.orange)
            shadowColor = .sh(.orange30)
            
            foregroundStyle = if input.isSelected {
                AnyShapeStyle(Gradient(colors: [.sh(.orange30), .sh(.orange)]))
            } else if isNaturalResource {
                AnyShapeStyle(Gradient(stops: [
                    Gradient.Stop(color: .sh(.background1), location: 0),
                    Gradient.Stop(color: .sh(.background1), location: 0.7),
                    Gradient.Stop(color: .sh(.orange50), location: 1)
                ]))
            } else {
                AnyShapeStyle(.background)
            }
            
        case .fluid, .gas:
            primaryColor = .sh(.cyan)
            shadowColor = .sh(.cyan30)
            
            foregroundStyle = if input.isSelected {
                AnyShapeStyle(Gradient(colors: [.sh(.cyan30), .sh(.cyan60)]))
            } else if isNaturalResource {
                AnyShapeStyle(Gradient(stops: [
                    Gradient.Stop(color: .sh(.background1), location: 0),
                    Gradient.Stop(color: .sh(.background1), location: 0.7),
                    Gradient.Stop(color: .sh(.cyan50), location: 1)
                ]))
            } else {
                AnyShapeStyle(.background)
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
    
    convenience init(productionSecondaryByproduct byproduct: SingleItemCalculator.OutputRecipe.Byproduct, item: any Item) {
        let primaryColors = [
            Color.sh(.yellow40),
            Color.sh(.purple40),
            Color.sh(.turquoise40),
            Color.sh(.magenta40),
            Color.sh(.blue40),
            Color.sh(.green40),
            Color.sh(.lime40),
        ]
        
        let shadowColors = [
            Color.sh(.yellow30),
            Color.sh(.purple30),
            Color.sh(.turquoise30),
            Color.sh(.magenta30),
            Color.sh(.blue30),
            Color.sh(.green30),
            Color.sh(.lime30),
        ]
        
        let foregroundStyleColors = [
            [Color.sh(.yellow20), Color.sh(.yellow40)],
            [Color.sh(.purple20), Color.sh(.purple40)],
            [Color.sh(.turquoise20), Color.sh(.turquoise40)],
            [Color.sh(.magenta20), Color.sh(.magenta40)],
            [Color.sh(.blue20), Color.sh(.blue40)],
            [Color.sh(.green20), Color.sh(.green40)],
            [Color.sh(.lime20), Color.sh(.lime40)],
        ]
        
        let secondaryStyteColors = [
            [Color.sh(.yellow10), Color.sh(.yellow20)],
            [Color.sh(.purple10), Color.sh(.purple20)],
            [Color.sh(.turquoise10), Color.sh(.turquoise20)],
            [Color.sh(.magenta10), Color.sh(.magenta20)],
            [Color.sh(.blue10), Color.sh(.blue20)],
            [Color.sh(.green10), Color.sh(.green20)],
            [Color.sh(.lime10), Color.sh(.lime20)],
        ]
        
        let resolvedIndex = byproduct.index % primaryColors.count
        
        let primaryColor = primaryColors[resolvedIndex]
        let shadowColor = shadowColors[resolvedIndex]
        let foregroundStyle = AnyShapeStyle(Gradient(colors: foregroundStyleColors[resolvedIndex]))
        let secondaryStyle = AnyShapeStyle(Gradient(colors: secondaryStyteColors[resolvedIndex]))
        
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
