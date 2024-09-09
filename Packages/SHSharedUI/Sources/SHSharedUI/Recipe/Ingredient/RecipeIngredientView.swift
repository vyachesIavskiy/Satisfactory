import SwiftUI
import SHSettings

public struct RecipeIngredientView: View {
    private let viewModel: RecipeIngredientViewModel
    
    @Environment(\.showIngredientNames)
    private var showIngredientNames
    
    private var iconSpacing: Double {
        showIngredientNames ? 12.0 : 0.0
    }
    
    private var iconSize: Double {
        showIngredientNames ? 40 : 48
    }
    
    public init(viewModel: RecipeIngredientViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: iconSpacing) {
            VStack(spacing: 0) {
                Image(viewModel.item.id)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .padding(4)
                
                if showIngredientNames {
                    Text(viewModel.item.localizedName)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .minimumScaleFactor(0.7)
                        .frame(width: 80, height: 50)
                }
            }

            VStack(spacing: -2) {
                ForEach(Array(viewModel.amountViewModels.enumerated()), id: \.offset) { index, viewModel in
                    RecipeIngredientAmountView(viewModel: viewModel)
                        .offset(x: 4 * Double(index))
                }
            }
        }
    }
}
