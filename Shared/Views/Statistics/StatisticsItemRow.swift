import SwiftUI
import SHSharedUI
import SHUtils

extension StatisticsView {
    struct ItemRow: View {
        @Binding
        var item: StatisticsViewModel.Item
        
        private var name: String {
            item.statisticItem.item.localizedName
        }
        
        private var valueString: String {
            item.statisticItem.amount.formatted(.shNumber())
        }
        
        init(_ item: Binding<StatisticsViewModel.Item>) {
            self._item = item
        }
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    ListRowIconItem(item.statisticItem.item)
                    
                    if item.expandable {
                        Button {
                            _item.wrappedValue.recipesExpanded.toggle()
                        } label: {
                            itemRowContent
                                .contentShape(.interaction, Rectangle())
                        }
                        .buttonStyle(.plain)
                    } else {
                        itemRowContent
                    }
                }
                
                if item.recipesExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(item.statisticItem.recipes) { recipe in
                            HStack(alignment: .firstTextBaseline) {
                                Text(recipe.recipe.localizedName)
                                
                                Spacer()
                                
                                Text(AttributedString(recipe.amount.formatted(.shNumber())))
                                    .foregroundStyle(.sh(.midnight))
                            }
                        }
                    }
                    .font(.caption)
                    .padding(.leading, 64)
                    .padding(.bottom, 4)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(.default.speed(0.5)),
                            removal: .opacity.animation(.default.speed(3))
                        )
                    )
                }
            }
            .addListGradientSeparator(leadingPadding: 64)
            .fixedSize(horizontal: false, vertical: true)
        }
        
        @MainActor @ViewBuilder
        private var itemRowContent: some View {
            if item.expandable {
                VStack(spacing: 4) {
                    HStack {
                        Text(name)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(valueString)
                            .font(.callout)
                            .foregroundStyle(.sh(.midnight))
                    }
                    
                    HStack {
                        Text(item.subtitle)
                            .font(.caption)
                            .opacity(item.recipesExpanded ? 0 : 1)
                            .animation(.default.speed(2), value: item.recipesExpanded)
                        
                        Spacer()
                        
                        ExpandArrow(item.recipesExpanded)
                            .stroke(lineWidth: item.recipesExpanded ? 0.5 : 1)
                            .foregroundStyle(.sh(item.recipesExpanded ? .midnight30 : .midnight))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 16)
                    }
                }
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .fontWeight(.semibold)
                        
                        Text(item.subtitle)
                            .font(.caption)
                            .opacity(item.recipesExpanded ? 0 : 1)
                            .animation(.default.speed(2), value: item.recipesExpanded)
                    }
                    
                    Spacer()
                    
                    Text(valueString)
                        .font(.callout)
                        .foregroundStyle(.sh(.midnight))
                }
            }
        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ItemRowPreview: View {
    @State
    private var viewModelItem: StatisticsViewModel.Item
    
    init(itemID: String, recipes: [String : Double]) {
        @Dependency(\.storageService)
        var storageService
        
        _viewModelItem = State(initialValue: StatisticsViewModel.Item(statisticItem: StatisticItem(
            item: storageService.item(id: itemID)!,
            recipes: recipes.map {
                StatisticRecipe(
                    recipe: storageService.recipe(id: $0.key)!,
                    amount: $0.value
                )
        })))
    }
    
    var body: some View {
        StatisticsView.ItemRow($viewModelItem)
    }
}

#Preview("Item Row (1 recipe)") {
    _ItemRowPreview(itemID: "part-iron-plate", recipes: [
        "recipe-iron-plate": 40
    ])
}

#Preview("Item Row (2 recipes)") {
    _ItemRowPreview(itemID: "part-iron-plate", recipes: [
        "recipe-iron-plate": 40,
        "recipe-alternate-steel-coated-plate": 12
    ])
}
#endif
