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
        
        row(
            item: item.statisticItem.item,
            expandLabel: item.subtitle,
            valueString: AttributedString(item.statisticItem.amount.formatted(.shNumber)),
            expandable: item.expandable,
            isExpanded: _item.recipesExpanded,
            data: item.statisticItem.recipes
        ) { recipe in
            contentRow(
                title: recipe.recipe.localizedName,
                valueString: AttributedString(recipe.amount.formatted(.shNumber))
            )
        }
    }
    
    @MainActor @ViewBuilder
    private func naturalResourceView(_ naturalResource: StatisticNaturalResource) -> some View {
        HStack(spacing: 12) {
            ItemRowIcon(naturalResource.item)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(naturalResource.item.localizedName)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Text(naturalResource.amount, format: .shNumber)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.sh(.midnight))
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor @ViewBuilder
    private func machineView(_ _machine: Binding<StatisticsViewModel.Machine>) -> some View {
        let machine = _machine.wrappedValue
        
        row(
            item: machine.building,
            subValueString: machine.powerValueString,
            expandLabel: machine.subtitle,
            valueString: machine.valueString,
            expandable: machine.expandable,
            isExpanded: _machine.recipesExpanded,
            data: machine.recipes
        ) { recipe in
            contentRow(title: recipe.recipe.localizedName, valueString: recipe.valueString)
        }
    }
    
    @MainActor @ViewBuilder
    private func row<Data: Identifiable, Content: View>(
        item: any Item,
        subValueString: String? = nil,
        expandLabel: String,
        valueString: AttributedString,
        expandable: Bool,
        isExpanded: Binding<Bool>,
        data: [Data],
        @ViewBuilder content: @escaping (Data) -> Content
    ) -> some View {
        HStack(alignment: .statisticItemCenter, spacing: 12) {
            ItemRowIcon(item)
            
            ZStack {
                if expandable {
                    expandableRow(
                        title: item.localizedName,
                        subValueString: subValueString,
                        expandLabel: expandLabel,
                        valueString: valueString,
                        isExpanded: isExpanded,
                        data: data,
                        content: content
                    )
                } else {
                    staticRow(
                        title: item.localizedName,
                        subtitle: expandLabel,
                        subValueString: subValueString,
                        valueString: valueString
                    )
                }
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor @ViewBuilder
    private func expandableRow<Data: Identifiable, Content: View>(
        title: String,
        subValueString: String? = nil,
        expandLabel: String,
        valueString: AttributedString,
        isExpanded: Binding<Bool>,
        data: [Data],
        @ViewBuilder content: @escaping (Data) -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .fontWeight(.semibold)
                    .alignmentGuide(.statisticItemCenter) { d in
                        d[.bottom] - 1
                    }
                
                Spacer()
                
                Text(valueString)
                    .font(.callout)
                    .foregroundStyle(.sh(.midnight))
            }
            
            if let subValueString {
                HStack(spacing: 4) {
                    Image(systemName: "bolt.fill")
                    
                    Text(subValueString)
                }
                .font(.footnote)
                .foregroundStyle(.sh(.midnight))
            }
            
            Button {
                isExpanded.wrappedValue.toggle()
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(expandLabel)
                            .font(.caption)
                            .opacity(isExpanded.wrappedValue ? 0 : 1)
                            .animation(.default.speed(2), value: isExpanded.wrappedValue)
                        
                        Spacer()
                        
                        ExpandArrow(isExpanded.wrappedValue)
                            .stroke(lineWidth: isExpanded.wrappedValue ? 0.5 : 1)
                            .foregroundStyle(.sh(isExpanded.wrappedValue ? .midnight30 : .midnight))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 16)
                    }
                    
                    if isExpanded.wrappedValue {
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(data) { data in
                                HStack(alignment: .firstTextBaseline) {
                                    content(data)
                                }
                            }
                        }
                        .font(.caption)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.animation(.default.speed(0.5)),
                                removal: .opacity.animation(.default.speed(3))
                            )
                        )
                    }
                }
                .contentShape(.interaction, Rectangle())
            }
            .buttonStyle(.plain)
        }
    }
    
    @MainActor @ViewBuilder
    private func staticRow(
        title: String,
        subtitle: String,
        subValueString: String? = nil,
        valueString: AttributedString
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                
                if let subValueString {
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                        
                        Text(subValueString)
                    }
                    .font(.footnote)
                    .foregroundStyle(.sh(.midnight))
                }
                
                Text(subtitle)
                    .font(.caption)
                    .padding(.bottom, 4)
            }
            
            Spacer()
            
            Text(valueString)
                .font(.callout)
                .foregroundStyle(.sh(.midnight))
        }
    }
    
    @MainActor @ViewBuilder
    private func contentRow(title: String, valueString: AttributedString) -> some View {
        Text(title)
        
        Spacer()
        
        Text(valueString)
            .fontWeight(.semibold)
            .foregroundStyle(.sh(.midnight))
    }
}

private struct StatisticItemCenterAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[VerticalAlignment.center]
    }
}

private extension VerticalAlignment {
    static let statisticItemCenter = VerticalAlignment(StatisticItemCenterAlignment.self)
}

private extension Alignment {
    static let statisticItemCenter = Alignment(horizontal: .center, vertical: .statisticItemCenter)
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
