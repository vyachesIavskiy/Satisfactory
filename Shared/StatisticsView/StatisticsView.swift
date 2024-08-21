import SwiftUI
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
                    itemsSection
                        .padding(.horizontal, 20)
                    
                    naturalResoucesSection
                        .padding(.horizontal, 20)
                    
                    machinesSection
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 30)
                }
            }
            .animation(.default, value: viewModel.itemsSection)
            .animation(.default, value: viewModel.naturalResourcesSection)
            .animation(.default, value: viewModel.machinesSection)
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
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
                        itemView($item)
                    }
                }
            } header: {
                SHSectionHeader("Item statistics", expanded: $viewModel.itemsSection.expanded)
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
                        naturalResourceView(naturalResource)
                    }
                }
            } header: {
                SHSectionHeader("Natural resources", expanded: $viewModel.naturalResourcesSection.expanded)
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
                        machineView($machine)
                    }
                }
            } header: {
                SHSectionHeader(expanded: $viewModel.machinesSection.expanded) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Machine statistics")
                        
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                            
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

    
    @MainActor @ViewBuilder
    private func itemView(_ _item: Binding<StatisticsViewModel.Item>) -> some View {
        let item = _item.wrappedValue
        let name = item.statisticItem.item.localizedName
        let valueString = AttributedString(item.statisticItem.amount.formatted(.shNumber))
        
        VStack(spacing: 4) {
            HStack(spacing: 12) {
                ItemRowIcon(item.statisticItem.item)
                
                let itemRowView = itemRowContent(
                    title: name,
                    valueString: valueString,
                    subtitle: item.subtitle,
                    expandable: item.expandable,
                    expanded: _item.recipesExpanded
                )
                
                if item.expandable {
                    Button {
                        _item.wrappedValue.recipesExpanded.toggle()
                    } label: {
                        itemRowView
                            .contentShape(.interaction, Rectangle())
                    }
                    .buttonStyle(.plain)
                } else {
                    itemRowView
                }
            }
            
            if item.recipesExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(item.statisticItem.recipes) { recipe in
                        HStack(alignment: .firstTextBaseline) {
                            Text(recipe.recipe.localizedName)
                            
                            Spacer()
                            
                            Text(AttributedString(recipe.amount.formatted(.shNumber)))
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
    }
    
    @MainActor @ViewBuilder
    private func naturalResourceView(_ naturalResource: StatisticNaturalResource) -> some View {
        HStack(spacing: 12) {
            ItemRowIcon(naturalResource.item)
            
            HStack {
                titleText(naturalResource.item.localizedName)
                
                Spacer()
                
                valueText(naturalResource.amount.formatted(.shNumber))
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor @ViewBuilder
    private func machineView(_ _machine: Binding<StatisticsViewModel.Machine>) -> some View {
        let machine = _machine.wrappedValue
        
        VStack(spacing: 4) {
            HStack(spacing: 12) {
                ItemRowIcon(machine.building)
                
                let rowContentView = productionBuildingRowContent(
                    title: machine.building.localizedName,
                    valueString: machine.valueString,
                    subtitle: machine.subtitle,
                    powerConsumptionValueString: machine.powerValueString,
                    expandable: machine.expandable,
                    expanded: _machine.recipesExpanded
                )
                
                if machine.expandable {
                    Button {
                        _machine.recipesExpanded.wrappedValue.toggle()
                    } label: {
                        rowContentView
                            .contentShape(.interaction, Rectangle())
                    }
                    .buttonStyle(.plain)
                } else {
                    rowContentView
                }
            }
            
            if machine.recipesExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(machine.recipes) { recipe in
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
    }
    
    @MainActor @ViewBuilder
    private func itemRowContent(
        title: String,
        valueString: AttributedString,
        subtitle: String,
        expandable: Bool,
        expanded: Binding<Bool>
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                titleText(title)
                
                subtitleText(subtitle)
                    .opacity(expanded.wrappedValue ? 0 : 1)
                    .animation(.default.speed(2), value: expanded.wrappedValue)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                valueText(valueString)
                
                if expandable {
                    expandArrow(expanded.wrappedValue)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func productionBuildingRowContent(
        title: String,
        valueString: AttributedString,
        subtitle: String,
        powerConsumptionValueString: String,
        expandable: Bool,
        expanded: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                titleText(title)
                
                Spacer()
                
                valueText(valueString)
            }
            
            powerConsumptionText(powerConsumptionValueString)
            
            HStack {
                subtitleText(subtitle)
                    .opacity(expanded.wrappedValue ? 0 : 1)
                    .animation(.default.speed(2), value: expanded.wrappedValue)
                
                Spacer()
                
                if expandable {
                    expandArrow(expanded.wrappedValue)
                }
            }
        }
    }
    
    // MARK: Components
    @MainActor @ViewBuilder
    private func titleText(_ title: String) -> some View {
        Text(title)
            .fontWeight(.semibold)
    }
    
    @MainActor @ViewBuilder
    private func valueText(_ valueString: String) -> some View {
        Text(valueString)
            .font(.callout)
            .foregroundStyle(.sh(.midnight))
    }
    
    @MainActor @ViewBuilder
    private func valueText(_ valueString: AttributedString) -> some View {
        Text(valueString)
            .font(.callout)
            .foregroundStyle(.sh(.midnight))
    }
    
    @MainActor @ViewBuilder
    private func subtitleText(_ subtitle: String) -> some View {
        Text(subtitle)
            .font(.caption)
    }
    
    @MainActor @ViewBuilder
    private func expandArrow(_ expanded: Bool) -> some View {
        ExpandArrow(expanded)
            .stroke(lineWidth: expanded ? 0.5 : 1)
            .foregroundStyle(.sh(expanded ? .midnight30 : .midnight))
            .fixedSize(horizontal: false, vertical: true)
            .frame(width: 16)
    }
    
    @MainActor @ViewBuilder
    private func powerConsumptionText(_ valueString: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "bolt.fill")
                .foregroundStyle(.sh(.cyan))

            Text(valueString)
        }
        .font(.footnote)
    }
}

private struct StatisticItemCenterAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[VerticalAlignment.center]
    }
}

private struct ProductionBuildingIconAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[.trailing]
    }
}

private extension VerticalAlignment {
    static let statisticItemCenter = VerticalAlignment(StatisticItemCenterAlignment.self)
}

private extension HorizontalAlignment {
    static let productionBuildingIcon = HorizontalAlignment(ProductionBuildingIconAlignment.self)
}

private extension Alignment {
    static let statisticItemCenter = Alignment(horizontal: .center, vertical: .statisticItemCenter)
    static let productionBuildingIcon = Alignment(horizontal: .productionBuildingIcon, vertical: .center)
}

#if DEBUG
import SHStorage

#Preview("Plastic") {
    StatisticsView(viewModel: StatisticsViewModel(production: Production.singleItem(singleItemPlasticProduction())))
}

#Preview("HMF") {
    StatisticsView(viewModel: StatisticsViewModel(production: Production.singleItem(singleItemHMFProduction())))
}

private func singleItemPlasticProduction() -> SingleItemProduction {
    @Dependency(\.storageService)
    var storageService
    
    let plastic = storageService.item(id: "part-plastic")!
    let rubber = storageService.item(id: "part-rubber")!
    let fuel = storageService.item(id: "part-fuel")!
    let hor = storageService.item(id: "part-heavy-oil-residue")!
    
    let water = storageService.item(id: "part-water")!
    let crudeOil = storageService.item(id: "part-crude-oil")!
    
    let recycledPlasticRecipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
    let recycledRubberRecipe = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
    let residualRubberRecipe = storageService.recipe(id: "recipe-residual-rubber")!
    let dilutedFuelRecipe = storageService.recipe(id: "recipe-alternate-diluted-fuel")!
    let horRecipe = storageService.recipe(id: "recipe-alternate-heavy-oil-residue")!
    
    var production = SingleItemProduction(id: UUID(), name: "Plastic", item: plastic, amount: 90)
    production.statistics = Statistics(
        items: [
            StatisticItem(item: plastic, recipes: [
                StatisticRecipe(recipe: recycledPlasticRecipe, amount: 90)
            ]),
            StatisticItem(item: rubber, recipes: [
                StatisticRecipe(recipe: recycledRubberRecipe, amount: 46.6666),
                StatisticRecipe(recipe: residualRubberRecipe, amount: 10)
            ]),
            StatisticItem(item: fuel, recipes: [
                StatisticRecipe(recipe: dilutedFuelRecipe, amount: 80)
            ]),
            StatisticItem(item: hor, recipes: [
                StatisticRecipe(recipe: horRecipe, amount: 40)
            ])
        ],
        naturalResources: [
            StatisticNaturalResource(item: water, amount: 100),
            StatisticNaturalResource(item: crudeOil, amount: 30)
        ]
    )
    
    return production
}

private func singleItemHMFProduction() -> SingleItemProduction {
    @Dependency(\.storageService)
    var storageService
    
    let hmf = storageService.item(id: "part-heavy-modular-frame")!
    let modularFrame = storageService.item(id: "part-modular-frame")!
    let encasedIndustrialBeam = storageService.item(id: "part-encased-industrial-beam")!
    let steelPipe = storageService.item(id: "part-steel-pipe")!
    let concrete = storageService.item(id: "part-concrete")!
    let reinforcedIronPlate = storageService.item(id: "part-reinforced-iron-plate")!
    let ironRod = storageService.item(id: "part-iron-rod")!
    let steelIngot = storageService.item(id: "part-steel-ingot")!
    let ironPlate = storageService.item(id: "part-iron-plate")!
    let screw = storageService.item(id: "part-screw")!
    let ironIngot = storageService.item(id: "part-iron-ingot")!
    
    let limestone = storageService.item(id: "part-limestone")!
    let coal = storageService.item(id: "part-coal")!
    let ironOre = storageService.item(id: "part-iron-ore")!
    
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
    
    var production = SingleItemProduction(id: UUID(), name: "Heavy Modular Frame", item: hmf, amount: 12)
    production.statistics = Statistics(
        items: [
            StatisticItem(item: hmf, recipes: [
                StatisticRecipe(recipe: heavyEncasedFrameRecipe, amount: 12)
            ]),
            StatisticItem(item: modularFrame, recipes: [
                StatisticRecipe(recipe: modularFrameRecipe, amount: 32)
            ]),
            StatisticItem(item: encasedIndustrialBeam, recipes: [
                StatisticRecipe(recipe: encasedIndustrialBeamRecipe, amount: 40)
            ]),
            StatisticItem(item: steelPipe, recipes: [
                StatisticRecipe(recipe: steelPipeRecipe, amount: 424)
            ]),
            StatisticItem(item: concrete, recipes: [
                StatisticRecipe(recipe: concreteRecipe, amount: 288)
            ]),
            StatisticItem(item: reinforcedIronPlate, recipes: [
                StatisticRecipe(recipe: ripRecipe, amount: 48)
            ]),
            StatisticItem(item: ironRod, recipes: [
                StatisticRecipe(recipe: ironRodRecipe, amount: 192)
            ]),
            StatisticItem(item: steelIngot, recipes: [
                StatisticRecipe(recipe: solidSteelIngotRecipe, amount: 636)
            ]),
            StatisticItem(item: ironPlate, recipes: [
                StatisticRecipe(recipe: ironPlateRecipe, amount: 288)
            ]),
            StatisticItem(item: screw, recipes: [
                StatisticRecipe(recipe: castScrewRecipe, amount: 576)
            ]),
            StatisticItem(item: ironIngot, recipes: [
                StatisticRecipe(recipe: ironIngotRecipe, amount: 1192)
            ])
        ],
        naturalResources: [
            StatisticNaturalResource(item: limestone, amount: 864),
            StatisticNaturalResource(item: coal, amount: 424),
            StatisticNaturalResource(item: ironOre, amount: 1192)
        ]
    )
    
    return production
}
#endif
