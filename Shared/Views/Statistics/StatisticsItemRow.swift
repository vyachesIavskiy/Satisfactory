import SwiftUI
import SHSharedUI
import SHUtils

extension StatisticsView {
    struct ItemRow: View {
        @Binding
        var part: StatisticsViewModel.Part
        
        private var name: String {
            part.statisticPart.part.localizedName
        }
        
        private var valueString: String {
            part.statisticPart.amount.formatted(.shNumber())
        }
        
        init(_ part: Binding<StatisticsViewModel.Part>) {
            self._part = part
        }
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    ListRowIconItem(part.statisticPart.part)
                    
                    if part.expandable {
                        Button {
                            _part.wrappedValue.recipesExpanded.toggle()
                        } label: {
                            itemRowContent
                                .contentShape(.interaction, Rectangle())
                        }
                        .buttonStyle(.plain)
                    } else {
                        itemRowContent
                    }
                }
                
                if part.recipesExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(part.statisticPart.recipes) { recipe in
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
            if part.expandable {
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
                        Text(part.subtitle)
                            .font(.caption)
                            .opacity(part.recipesExpanded ? 0 : 1)
                            .animation(.default.speed(2), value: part.recipesExpanded)
                        
                        Spacer()
                        
                        ExpandArrow(part.recipesExpanded)
                            .stroke(lineWidth: part.recipesExpanded ? 0.5 : 1)
                            .foregroundStyle(.sh(part.recipesExpanded ? .midnight30 : .midnight))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 16)
                    }
                }
            } else {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .fontWeight(.semibold)
                        
                        Text(part.subtitle)
                            .font(.caption)
                            .opacity(part.recipesExpanded ? 0 : 1)
                            .animation(.default.speed(2), value: part.recipesExpanded)
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
    private var viewModelItem: StatisticsViewModel.Part
    
    init(partID: String, recipes: [String : Double]) {
        @Dependency(\.storageService)
        var storageService
        
        _viewModelItem = State(initialValue: StatisticsViewModel.Part(statisticPart: StatisticPart(
            part: storageService.part(id: partID)!,
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
