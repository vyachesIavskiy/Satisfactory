import SwiftUI
import SHSharedUI

extension StatisticsView {
    struct ProductionBuildingRow: View {
        private let productionBuilding: StatisticsViewModel.Machine
        
        @Environment(\.displayScale)
        private var displayScale
        
        init(_ productionBuilding: StatisticsViewModel.Machine) {
            self.productionBuilding = productionBuilding
        }
        
        var body: some View {
            VStack(spacing: 8) {
                HStack(spacing: 12) {
                    ListRowIconItem(productionBuilding.building)
                    
                    productionBuildingRowContent
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(productionBuilding.recipes) { recipe in
                        HStack(spacing: 12) {
                            Image(recipe.recipe.output.part.id)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(5)
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
                .font(.callout)
                .padding(.leading, 12)
                .transition(
                    .asymmetric(
                        insertion: .opacity.animation(.default.speed(0.5)),
                        removal: .opacity.animation(.default.speed(3))
                    )
                )
            }
            .addListGradientSeparator(leadingPadding: 64)
            .fixedSize(horizontal: false, vertical: true)
        }
        
        @MainActor @ViewBuilder
        private var productionBuildingRowContent: some View {
            HStack {
                Text(productionBuilding.building.localizedName)
                    .fontWeight(.medium)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text(productionBuilding.intAmount, format: .number)
                        .font(.callout)
                        .foregroundStyle(.sh(.midnight))
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .foregroundStyle(.sh(.cyan))
                        
                        Text(productionBuilding.subtitle)
                    }
                    .font(.footnote)
                    .foregroundStyle(.sh(.midnight))
                    .opacity(0.7)
                }
            }
            .addListGradientSeparator(colors: [.sh(.midnight30), .sh(.midnight10)], lineWidth: 1)
        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ProductionBuildingRowPreview: View {
    private var viewModelProductionBuilding: StatisticsViewModel.Machine
    
    init(buildingID: String, recipes: [String: Double]) {
        @Dependency(\.storageService)
        var storageService
        
        let building = storageService.building(id: buildingID)!
        
        viewModelProductionBuilding = StatisticsViewModel.Machine(
            building: building,
            recipes: recipes.map {
                StatisticsViewModel.MachineRecipe(statisticRecipe: StatisticRecipe(
                    recipe: storageService.recipe(id: $0.key)!,
                    amount: $0.value
                ))
            }
        )
    }
    
    var body: some View {
        StatisticsView.ProductionBuildingRow(viewModelProductionBuilding)
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
