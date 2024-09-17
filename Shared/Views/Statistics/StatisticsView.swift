import SwiftUI
import SHSharedUI
import SHModels

struct StatisticsView: View {
    @State
    private var viewModel: StatisticsViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    init(viewModel: StatisticsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24, pinnedViews: .sectionHeaders) {
                    machinesSection
                        .padding(.horizontal, 20)
                    
                    itemsSection
                        .padding(.horizontal, 20)
                    
                    naturalResoucesSection
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 30)
                }
            }
            .animation(.default, value: viewModel.machinesSection)
            .animation(.default, value: viewModel.itemsSection)
            .animation(.default, value: viewModel.naturalResourcesSection)
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("general-done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var itemsSection: some View {
        if !viewModel.itemsSection.items.isEmpty {
            Section(isExpanded: $viewModel.itemsSection.expanded) {
                VStack(spacing: 16) {
                    ForEach($viewModel.itemsSection.items) { $item in
                        StatisticsView.ItemRow($item)
                    }
                }
            } header: {
                SectionHeader("statistics-items-section-name", expanded: $viewModel.itemsSection.expanded)
                    .background(.background)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var naturalResoucesSection: some View {
        if !viewModel.naturalResourcesSection.naturalResources.isEmpty {
            Section(isExpanded: $viewModel.naturalResourcesSection.expanded) {
                VStack(spacing: 16) {
                    ForEach(viewModel.naturalResourcesSection.naturalResources) { naturalResource in
                        NaturalResourceRow(naturalResource)
                    }
                }
            } header: {
                SectionHeader(
                    "statistics-natural-resources-section-name",
                    expanded: $viewModel.naturalResourcesSection.expanded
                )
                .background(.background)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var machinesSection: some View {
        if !viewModel.machinesSection.machines.isEmpty {
            Section(isExpanded: $viewModel.machinesSection.expanded) {
                VStack(spacing: 16) {
                    ForEach($viewModel.machinesSection.machines) { $machine in
                        ProductionBuildingRow(productionBuilding: $machine)
                    }
                }
            } header: {
                SectionHeader(expanded: $viewModel.machinesSection.expanded) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("statistics-production-buildings-section-name")
                        
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                                .foregroundStyle(.sh(viewModel.machinesSection.expanded ? .cyan : .gray))
                            
                            Text(viewModel.machinesSection.powerConsumptionString)
                        }
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.sh(viewModel.machinesSection.expanded ? .midnight : .gray))
                    }
                }
                .background(.background)
            }
        }
    }
}

#if DEBUG
import SHStorage

#Preview("Plastic") {
    StatisticsView(
        viewModel: StatisticsViewModel(
            production: Production(
                id: UUID(),
                name: "Plastic",
                creationDate: Date(),
                assetName: "part-plastic",
                content: .singleItem(singleItemContentPlastic())
            )
        )
    )
}

#Preview("HMF") {
    StatisticsView(
        viewModel: StatisticsViewModel(
            production: Production(
                id: UUID(),
                name: "HMF",
                creationDate: Date(),
                assetName: "part-heavy-modular-frame",
                content: .singleItem(singleItemContentHMFProduction())
            )
        )
    )
}

private func singleItemContentPlastic() -> Production.Content.SingleItem {
    @Dependency(\.storageService)
    var storageService
    
    let plastic = storageService.part(id: "part-plastic")!
    let rubber = storageService.part(id: "part-rubber")!
    let fuel = storageService.part(id: "part-fuel")!
    let hor = storageService.part(id: "part-heavy-oil-residue")!
    
    let water = storageService.part(id: "part-water")!
    let crudeOil = storageService.part(id: "part-crude-oil")!
    
    let recycledPlasticRecipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
    let recycledRubberRecipe = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
    let residualRubberRecipe = storageService.recipe(id: "recipe-residual-rubber")!
    let dilutedFuelRecipe = storageService.recipe(id: "recipe-alternate-diluted-fuel")!
    let horRecipe = storageService.recipe(id: "recipe-alternate-heavy-oil-residue")!
    
    var production = Production.Content.SingleItem(part: plastic, amount: 90)
    production.statistics = Statistics(
        parts: [
            StatisticPart(part: plastic, recipes: [
                StatisticRecipe(recipe: recycledPlasticRecipe, amount: 90)
            ]),
            StatisticPart(part: rubber, recipes: [
                StatisticRecipe(recipe: recycledRubberRecipe, amount: 46.6666),
                StatisticRecipe(recipe: residualRubberRecipe, amount: 10)
            ]),
            StatisticPart(part: fuel, recipes: [
                StatisticRecipe(recipe: dilutedFuelRecipe, amount: 80)
            ]),
            StatisticPart(part: hor, recipes: [
                StatisticRecipe(recipe: horRecipe, amount: 40)
            ])
        ],
        naturalResources: [
            StatisticNaturalResource(part: water, amount: 100),
            StatisticNaturalResource(part: crudeOil, amount: 30)
        ]
    )
    
    return production
}

private func singleItemContentHMFProduction() -> Production.Content.SingleItem {
    @Dependency(\.storageService)
    var storageService
    
    let hmf = storageService.part(id: "part-heavy-modular-frame")!
    let modularFrame = storageService.part(id: "part-modular-frame")!
    let encasedIndustrialBeam = storageService.part(id: "part-encased-industrial-beam")!
    let steelPipe = storageService.part(id: "part-steel-pipe")!
    let concrete = storageService.part(id: "part-concrete")!
    let reinforcedIronPlate = storageService.part(id: "part-reinforced-iron-plate")!
    let ironRod = storageService.part(id: "part-iron-rod")!
    let steelIngot = storageService.part(id: "part-steel-ingot")!
    let ironPlate = storageService.part(id: "part-iron-plate")!
    let screw = storageService.part(id: "part-screw")!
    let ironIngot = storageService.part(id: "part-iron-ingot")!
    
    let limestone = storageService.part(id: "part-limestone")!
    let coal = storageService.part(id: "part-coal")!
    let ironOre = storageService.part(id: "part-iron-ore")!
    
    let heavyEncasedFrameRecipe = storageService.recipe(id: "recipe-alternate-heavy-encased-frame")!
    let modularFrameRecipe = storageService.recipe(id: "recipe-modular-frame")!
    let encasedIndustrialBeamRecipe = storageService.recipe(id: "recipe-encased-industrial-beam")!
    let steelPipeRecipe = storageService.recipe(id: "recipe-steel-pipe")!
    let concreteRecipe = storageService.recipe(id: "recipe-concrete")!
    let ripRecipe = storageService.recipe(id: "recipe-reinforced-iron-plate")!
    let ironRodRecipe = storageService.recipe(id: "recipe-iron-rod")!
    let solidSteelIngotRecipe = storageService.recipe(id: "recipe-alternate-solid-steel-ingot")!
    let ironPlateRecipe = storageService.recipe(id: "recipe-iron-plate")!
    let castScrewRecipe = storageService.recipe(id: "recipe-alternate-cast-screw")!
    let ironIngotRecipe = storageService.recipe(id: "recipe-iron-ingot")!
    
    var production = Production.Content.SingleItem(part: hmf, amount: 12)
    production.statistics = Statistics(
        parts: [
            StatisticPart(part: hmf, recipes: [
                StatisticRecipe(recipe: heavyEncasedFrameRecipe, amount: 12)
            ]),
            StatisticPart(part: modularFrame, recipes: [
                StatisticRecipe(recipe: modularFrameRecipe, amount: 32)
            ]),
            StatisticPart(part: encasedIndustrialBeam, recipes: [
                StatisticRecipe(recipe: encasedIndustrialBeamRecipe, amount: 40)
            ]),
            StatisticPart(part: steelPipe, recipes: [
                StatisticRecipe(recipe: steelPipeRecipe, amount: 424)
            ]),
            StatisticPart(part: concrete, recipes: [
                StatisticRecipe(recipe: concreteRecipe, amount: 288)
            ]),
            StatisticPart(part: reinforcedIronPlate, recipes: [
                StatisticRecipe(recipe: ripRecipe, amount: 48)
            ]),
            StatisticPart(part: ironRod, recipes: [
                StatisticRecipe(recipe: ironRodRecipe, amount: 192)
            ]),
            StatisticPart(part: steelIngot, recipes: [
                StatisticRecipe(recipe: solidSteelIngotRecipe, amount: 636)
            ]),
            StatisticPart(part: ironPlate, recipes: [
                StatisticRecipe(recipe: ironPlateRecipe, amount: 288)
            ]),
            StatisticPart(part: screw, recipes: [
                StatisticRecipe(recipe: castScrewRecipe, amount: 576)
            ]),
            StatisticPart(part: ironIngot, recipes: [
                StatisticRecipe(recipe: ironIngotRecipe, amount: 1192)
            ])
        ],
        naturalResources: [
            StatisticNaturalResource(part: limestone, amount: 864),
            StatisticNaturalResource(part: coal, amount: 424),
            StatisticNaturalResource(part: ironOre, amount: 1192)
        ]
    )
    
    return production
}
#endif
