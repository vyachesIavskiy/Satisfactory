import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

struct WhatsNewStatisticsPage: View {
    @Dependency(\.storageService)
    private var storageService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            WhatsNewPageTitle("whats-new-statistics-page-title")
            
            Spacer()
            
            WhatsNewPageSubtitle("whats-new-statistics-page-subtitle")
            
            VStack(alignment: .leading, spacing: 16) {
                StatisticsView.ProductionBuildingRow(StatisticsViewModel.Machine(
                    building: storageService.building(id: "building-assembler")!,
                    recipes: [
                        StatisticsViewModel.MachineRecipe(statisticRecipe: StatisticRecipe(
                            recipe: storageService.recipe(id: "recipe-reinforced-iron-plate")!,
                            amount: 10
                        )),
                        StatisticsViewModel.MachineRecipe(statisticRecipe: StatisticRecipe(
                            recipe: storageService.recipe(id: "recipe-smart-plating")!,
                            amount: 5
                        ))
                    ]
                ))
                
                StatisticsView.ItemRow(StatisticsViewModel.Part(statisticPart: StatisticPart(
                    part: storageService.part(id: "part-turbo-motor")!,
                    recipes: [StatisticRecipe(recipe: storageService.recipe(id: "recipe-turbo-motor")!, amount: 2.5)]
                )))
                
                StatisticsView.NaturalResourceRow(StatisticNaturalResource(
                    part: storageService.part(id: "part-water")!,
                    amount: 360
                ))
            }
            
            Spacer()
            
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    WhatsNewStatisticsPage()
}
#endif
