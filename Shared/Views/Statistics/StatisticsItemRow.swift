import SwiftUI
import SHSharedUI
import SHUtils

extension StatisticsView {
    struct ItemRow: View {
        private let part: StatisticsViewModel.Part
        
        private var name: String {
            part.statisticPart.part.localizedName
        }
        
        private var valueString: String {
            part.statisticPart.amount.formatted(.shNumber())
        }
        
        init(_ part: StatisticsViewModel.Part) {
            self.part = part
        }
        
        var body: some View {
            HStack(spacing: 12) {
                ListRowIconItem(part.statisticPart.part)
                    .frame(maxHeight: .infinity, alignment: .top)
                
                itemRowContent
            }
            .addListGradientSeparator(leadingPadding: 64)
            .fixedSize(horizontal: false, vertical: true)
        }
        
        @MainActor @ViewBuilder
        private var itemRowContent: some View {
            let titleView = Text(name)
                .fontWeight(.medium)
            
            let valueView = Text(valueString)
                .font(.callout)
                .foregroundStyle(.sh(.midnight))
            
            if part.statisticPart.recipes.count > 1 {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        titleView
                        
                        Spacer()
                        
                        valueView
                    }
                    .padding(.vertical, 6)
                    .addListGradientSeparator(colors: [.sh(.midnight30), .sh(.midnight10)], lineWidth: 1)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(part.statisticPart.recipes) { recipe in
                            HStack(alignment: .firstTextBaseline) {
                                Text(recipe.recipe.localizedName)
                                
                                Spacer()
                                
                                Text(recipe.amount, format: .shNumber())
                                    .foregroundStyle(.sh(.midnight))
                            }
                        }
                    }
                    .font(.footnote)
                    .padding(.bottom, 4)
                }
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        titleView
                        
                        Text(part.statisticPart.recipes[0].recipe.localizedName)
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    valueView
                }
            }
        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ItemRowPreview: View {
    private let viewModelItem: StatisticsViewModel.Part
    
    init(partID: String, recipes: [String : Double]) {
        @Dependency(\.storageService)
        var storageService
        
        viewModelItem = StatisticsViewModel.Part(statisticPart: StatisticPart(
            part: storageService.part(id: partID)!,
            recipes: recipes.map {
                StatisticRecipe(
                    recipe: storageService.recipe(id: $0.key)!,
                    amount: $0.value
                )
        }))
    }
    
    var body: some View {
        StatisticsView.ItemRow(viewModelItem)
    }
}

#Preview("Item Row (1 recipe)") {
    _ItemRowPreview(partID: "part-iron-plate", recipes: [
        "recipe-iron-plate": 40
    ])
}

#Preview("Item Row (2 recipes)") {
    _ItemRowPreview(partID: "part-iron-plate", recipes: [
        "recipe-iron-plate": 40,
        "recipe-alternate-steel-coated-plate": 12
    ])
}
#endif
