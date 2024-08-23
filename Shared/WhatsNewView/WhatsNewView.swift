import SwiftUI
import SHModels
import SHStorage
import SingleItemCalculator

/// What's new screen presented on a first launch of the app when it's updated.
/// A new approach for what's new screen presents only the most recent what's new information with each update.
/// There is no way to re-visit this view anyhow other than on a first launch of the app.
/// Because of this this view can be completely static and can change it's layout with each new version.
struct WhatsNewView: View {
    @Dependency(\.storageService)
    private var storageService
        
    @State
    private var selectedPageIndex = 0
    
    let didFinish: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.sh(.orange20), .sh(.orange10), .sh(.orange10), .sh(.orange20)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            TabView(selection: $selectedPageIndex) {
                page1View
                    .tag(0)
                
                page2View
                    .tag(1)
                
                page3View
                    .tag(2)
                
                page4View
                    .tag(3)
                
                page5View
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: selectedPageIndex == 4 ? .never : .always))
        }
    }
    
    @MainActor @ViewBuilder
    private var page1View: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Welcome to Satisfactory Helper 2.0")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            Group {
                Text("・ New design")
                Text("・ New production calculator")
                Text("・ New Factories tab")
                Text("・ New Statistics")
            }
            .fontWeight(.medium)
            .foregroundStyle(.sh(.midnight50))
        }
        .padding(20)
    }
    
    @MainActor @ViewBuilder
    private var page2View: some View {
        let item = storageService.item(id: "part-heavy-modular-frame")
        let recipe = storageService.recipe(id: "recipe-alumina-solution")
        
        VStack {
            pageTitleText("A completely new design")
                .frame(maxHeight: .infinity)
            
            contentBox {
                if let item {
                    NewProductionView.ItemRow(item)
                        .padding(.horizontal, 10)
                }
                
                if let recipe {
                    RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe))
                        .padding(.horizontal, 10)
                }
            }
            
            Color.clear
                .frame(maxHeight: .infinity)
        }
        .padding(.vertical, 20)
    }
    
    @MainActor @ViewBuilder
    private var page3View: some View {
        VStack {
            pageTitleText("New production calculator")
            
            ScrollView {
                contentBox {
                    ProductView(
                        viewModel: ProductViewModel(
                            product: plasticOutputItem,
                            selectedByproduct: nil,
                            canPerformAction: { _ in false },
                            performAction: { _ in }
                        )
                    )
                    
                    ProductView(
                        viewModel: ProductViewModel(
                            product: rubberOutputItem,
                            selectedByproduct: nil,
                            canPerformAction: { _ in false },
                            performAction: { _ in }
                        )
                    )
                }
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .padding(.vertical, 20)
    }
    
    @MainActor @ViewBuilder
    private var page4View: some View {
        VStack {
            pageTitleText("Organise your productions with new Factories tab")
                .frame(maxHeight: .infinity)
            
            contentBox {
                FactoryRowView(
                    factory: Factory(
                        id: UUID(),
                        name: "Legacy",
                        asset: .legacy,
                        productionIDs: [UUID(), UUID(), UUID()]
                    )
                )
                
                FactoryRowView(
                    factory: Factory(
                        id: UUID(),
                        name: "Starter factory",
                        asset: .abbreviation,
                        productionIDs: [UUID(), UUID()]
                    )
                )
                
                FactoryRowView(
                    factory: Factory(
                        id: UUID(),
                        name: "Steel factory",
                        asset: .assetCatalog(name: "part-encased-industrial-beam"),
                        productionIDs: [UUID(), UUID(), UUID(), UUID(), UUID()]
                    )
                )
            }
            
            Color.clear
                .frame(maxHeight: .infinity)
        }
        .padding(.vertical, 20)
    }
    
    @MainActor @ViewBuilder
    private var page5View: some View {
        VStack {
            pageTitleText("All new statistics design which shows even more information")
                .frame(maxHeight: .infinity)
            
            contentBox {
                StatisticsView.ItemRow(.constant(StatisticsViewModel.Item(statisticItem: StatisticItem(
                    item: storageService.item(id: "part-turbo-motor")!,
                    recipes: [StatisticRecipe(recipe: storageService.recipe(id: "recipe-turbo-motor")!, amount: 2.5)]
                ))))
                
                StatisticsView.NaturalResourceRow(StatisticNaturalResource(
                    item: storageService.item(id: "part-water")!,
                    amount: 360
                ))
                
                StatisticsView.ProductionBuildingRow(productionBuilding: .constant(StatisticsViewModel.Machine(
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
                )))
            }
            
            Button {
                didFinish()
            } label: {
                Text("Close")
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.shBordered)
            .tint(.sh(.orange70))
            .shButtonCornerRadius(8)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(.vertical, 20)
    }
    
    @MainActor @ViewBuilder
    private func pageTitleText(_ title: String) -> some View {
        Text(title)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
            .frame(minHeight: 120)
    }
    
    @MainActor @ViewBuilder
    private func contentBox<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            content()
                .padding(.horizontal, 10)
        }
        .padding(.vertical, 20)
        .background(
            AngledRectangle(cornerRadius: 12)
                .foregroundStyle(.sh(.midnight10).opacity(0.1))
                .shadow(color: .sh(.midnight40), radius: 12)
        )
        .padding(.horizontal, 10)
    }
    
    private var plasticOutputItem: SingleItemCalculator.OutputItem {
        let plastic = storageService.item(id: "part-plastic")!
        let rubber = storageService.item(id: "part-rubber")!
        let fuel = storageService.item(id: "part-fuel")!
        let recipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
        
        return SingleItemCalculator.OutputItem(
            item: plastic,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                        item: plastic,
                        amount: 90,
                        additionalAmounts: [23.333333]
                    ),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: rubber,
                            amount: 56.666666,
                            byproducts: [],
                            isSelected: true
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: fuel,
                            amount: 56.666666,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .auto
                )
            ]
        )
    }
    
    private var rubberOutputItem: SingleItemCalculator.OutputItem {
        let rubber = storageService.item(id: "part-rubber")!
        let plastic = storageService.item(id: "part-plastic")!
        let fuel = storageService.item(id: "part-fuel")!
        let polymerResin = storageService.item(id: "part-polymer-resin")!
        let water = storageService.item(id: "part-water")!
        
        let recipe1 = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
        let recipe2 = storageService.recipe(id: "recipe-residual-rubber")!
        
        return SingleItemCalculator.OutputItem(
            item: plastic,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe1,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(item: rubber, amount: 56.666666),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: plastic,
                            amount: 23.333333,
                            byproducts: [],
                            isSelected: true
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: fuel,
                            amount: 23.333333,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .auto
                ),
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe2,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(item: rubber, amount: 10),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: polymerResin,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: water,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .fixed(10)
                )
            ]
        )
    }
}

#if DEBUG
#Preview("What's new") {
    WhatsNewView(didFinish: { })
}
#endif