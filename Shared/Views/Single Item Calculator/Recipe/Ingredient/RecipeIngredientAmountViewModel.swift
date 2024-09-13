import SwiftUI
import SHSharedUI
import SHModels
import SHSingleItemCalculator

extension RecipeIngredientAmountViewModel {
    convenience init(productionOutput output: SingleItemCalculator.OutputRecipe.OutputIngredient) {
        self.init(
            part: output.part,
            amount: output.amount,
            primaryColor: .sh(.gray50),
            shadowColor: .sh(.gray30)
        )
    }
    
    convenience init(additionalProductionOutput output: SingleItemCalculator.OutputRecipe.OutputIngredient, amount: Double) {
        self.init(
            part: output.part,
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
        let part = byproduct.part
        let isNaturalResource = part.isNaturalResource == true
        
        switch part.form {
        case .solid:
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
            
        case .fluid, .gas, .matter:
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
            part: part,
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
        let part = input.part
        let isNaturalResource = part.isNaturalResource == true
        
        switch part.form {
        case .solid:
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
            
        case .fluid, .gas, .matter:
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
            part: part,
            amount: input.amount,
            foregroundStyle: foregroundStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
    
    convenience init(productionSecondaryByproduct byproduct: SingleItemCalculator.OutputRecipe.Byproduct, part: Part) {
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
            part: part,
            amount: byproduct.amount,
            foregroundStyle: foregroundStyle,
            secondaryStyle: secondaryStyle,
            primaryColor: primaryColor,
            shadowColor: shadowColor
        )
    }
}
