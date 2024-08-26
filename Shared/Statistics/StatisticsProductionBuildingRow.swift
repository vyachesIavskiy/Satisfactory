import SwiftUI

extension StatisticsView {
    struct ProductionBuildingRow: View {
        @Binding
        var productionBuilding: StatisticsViewModel.Machine
        
        @Environment(\.displayScale)
        private var displayScale
        
        var body: some View {
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    ListRowIcon(item: productionBuilding.building)
                    
                    if productionBuilding.expandable {
                        Button {
                            productionBuilding.recipesExpanded.toggle()
                        } label: {
                            productionBuildingRowContent
                                .contentShape(.interaction, Rectangle())
                        }
                        .buttonStyle(.plain)
                    } else {
                        productionBuildingRowContent
                    }
                }
                
                if productionBuilding.recipesExpanded {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(productionBuilding.recipes) { recipe in
                            HStack(spacing: 12) {
                                Image(recipe.recipe.output.item.id)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(4)
                                    .background {
                                        AngledRectangle(cornerRadius: 4).inset(by: 1 / displayScale)
                                            .fill(.sh(.gray20))
                                            .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
                                    }
                                
                                HStack(alignment: .firstTextBaseline) {
                                    Text(recipe.recipe.localizedName)
                                    
                                    Spacer()
                                    
                                    Text(recipe.valueString)
                                        .foregroundStyle(.sh(.midnight))
                                }
                            }
                        }
                    }
                    .font(.caption)
                    .padding(.leading, 24)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(.default.speed(0.5)),
                            removal: .opacity.animation(.default.speed(3))
                        )
                    )
                }
            }
            .padding(.bottom, 4)
            .addListGradientSeparator(leadingPadding: 64)
            .fixedSize(horizontal: false, vertical: true)
        }
        
        @MainActor @ViewBuilder
        private var productionBuildingRowContent: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(productionBuilding.building.localizedName)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(productionBuilding.valueString)
                        .font(.callout)
                        .foregroundStyle(.sh(.midnight))
                }
                
                if productionBuilding.shouldDisplayPowerConsumption {
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundStyle(.sh(.cyan))
                        
                        Text(productionBuilding.powerValueString)
                    }
                    .font(.footnote)
                }
                
                HStack {
                    Text(productionBuilding.subtitle)
                        .font(.caption)
                        .opacity(productionBuilding.recipesExpanded ? 0 : 1)
                        .animation(.default.speed(2), value: productionBuilding.recipesExpanded)
                    
                    Spacer()
                    
                    if productionBuilding.expandable {
                        ExpandArrow(productionBuilding.recipesExpanded)
                            .stroke(lineWidth: productionBuilding.recipesExpanded ? 0.5 : 1)
                            .foregroundStyle(.sh(productionBuilding.recipesExpanded ? .midnight30 : .midnight))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 16)
                    }
                }
            }
        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ProductionBuildingRowPreview: View {
    @State
    private var viewModelProductionBuilding: StatisticsViewModel.Machine
    
    init(buildingID: String, recipes: [String: Double]) {
        @Dependency(\.storageService)
        var storageService
        
        let building = storageService.building(id: buildingID)!
        
        _viewModelProductionBuilding = State(initialValue: StatisticsViewModel.Machine(
            building: building,
            recipes: recipes.map {
                StatisticsViewModel.MachineRecipe(statisticRecipe: StatisticRecipe(
                    recipe: storageService.recipe(id: $0.key)!,
                    amount: $0.value
                ))
            }
        ))
    }
    
    var body: some View {
        StatisticsView.ProductionBuildingRow(productionBuilding: $viewModelProductionBuilding)
    }
}

#Preview("1 recipe") {
    _ProductionBuildingRowPreview(buildingID: "building-constructor", recipes: [
        "recipe-iron-plate": 20
    ])
}

#Preview("2 recipes") {
    _ProductionBuildingRowPreview(buildingID: "building-constructor", recipes: [
        "recipe-iron-plate": 20,
        "recipe-wire": 60
    ])
}
#endif
