import SwiftUI
import SHUtils

struct RecipeIngredientAmountView: View {
    let viewModel: RecipeIngredientAmountViewModel
    
    var body: some View {
        Text(viewModel.amount, format: .shNumber())
            .multilineTextAlignment(.center)
            .font(.callout)
            .fontWeight(.medium)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .padding(.horizontal, 6)
            .frame(minWidth: 80, maxWidth: 100, minHeight: 24)
            .fixedSize(horizontal: true, vertical: false)
            .background {
                ZStack {
                    ItemIconShape(part: viewModel.part, cornerRadius: viewModel.cornerRadius)
                        .fill(viewModel.foregroundStyle)
                        .shadow(color: viewModel.shadowColor, radius: 2, y: 1)
                    
                    if let secondaryStyle = viewModel.secondaryStyle {
                        RecipeByproductShape()
                            .foregroundStyle(secondaryStyle)
                            .clipShape(ItemIconShape(part: viewModel.part, cornerRadius: viewModel.cornerRadius))
                    }
                    
                    ItemIconShape(part: viewModel.part, cornerRadius: viewModel.cornerRadius)
                        .stroke(viewModel.primaryColor, lineWidth: 1)
                }
            }
    }
}
