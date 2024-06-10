import SwiftUI
import SHStorage

struct Factory: Identifiable {
    var id = UUID()
    var name: String
    var image: ImageFormat
    var productions = Set<ProductionChain>()
    
    enum ImageFormat {
        case text(String)
        case asset(String)
    }
}

final class FactoriesViewModel: ObservableObject {
    var legacyFactory: Factory? {
        let productionsWithoutFactory = storage
            .productionChains
            .filter { $0.factoryID == nil }
        
        return if !productionsWithoutFactory.isEmpty {
            Factory(
                id: UUID(),
                name: "Legacy productions",
                image: .text("⚠️"),
                productions: Set(productionsWithoutFactory)
            )
        } else {
            nil
        }
    }
    var factories: [Factory] {
//        storage
//            .factories
//            .sorted(using: KeyPathComparator(\Factory.name))
        
        []
    }
    
    var statistics: [CalculationStatisticsModel] {
//        factories
//            .flatMap { $0.productions.map(\.statistics) }
//            .reduce([], +)
//            .reduceDuplicates()
        
        []
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
//        factories
//            .flatMap { $0.productions.map(\.machineStatistics) }
//            .reduce([], +)
//            .reduceDuplicates()
//            .sorted { lhs, rhs in
//                (lhs.item as? Part)?.sortingPriority ?? 1 > (rhs.item as? Part)?.sortingPriority ?? 0
//            }
        
        []
    }
    
    var statisticsHidden: Bool {
        statistics.isEmpty || machineStatistics.isEmpty
    }
    
    @Dependency(\.storageService)
    private var storageService
    
    @Published var isShowingStatistics = false
    @Published var isShowingNewFactory = false
    
//    func factoryViewModel(for factory: Factory) -> FactoryViewModel {
//        FactoryViewModel(storage: storage, factory: factory)
//    }
    
//    func newFactoryViewModel() -> NewFactoryViewModel {
//        NewFactoryViewModel(storage: storage)
//    }
    
//    func deleteFactory(_ factory: Factory) {
//        storage.deleteFactory(factory)
//    }
}

struct FactoriesView: View {
    @ObservedObject var viewModel: FactoriesViewModel
    
    @Environment(\.displayScale) private var displayScale
    
    @State private var newFactorySize = CGSize.zero
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    if let legacyFactory = viewModel.legacyFactory {
                        NavigationLink {
                            FactoryView(viewModel: viewModel.factoryViewModel(for: legacyFactory))
                        } label: {
                            factoryRow(legacyFactory)
                                .contentShape(.interaction, Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                    
                    ForEach(viewModel.factories) { factory in
                        NavigationLink {
                            FactoryView(viewModel: viewModel.factoryViewModel(for: factory))
                        } label: {
                            factoryRow(factory)
                                .contentShape(.interaction, Rectangle())
                                .contentShape(
                                    .contextMenuPreview,
                                    AngledRectangle(cornerRadius: 8).inset(by: -8)
//                                    RoundedRectangle(cornerRadius: 8).inset(by: -8)
                                )
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.deleteFactory(factory)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Button {
                        viewModel.isShowingNewFactory = true
                    } label: {
                        newFactoryRow()
                            .contentShape(.interaction, Rectangle())
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Factories")
            .toolbar {
                if !viewModel.statisticsHidden {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            viewModel.isShowingStatistics = true
                        } label: {
                            Label("Statistics", systemImage: "checklist.unchecked")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $viewModel.isShowingStatistics) {
                NavigationStack {
                    CalculationStatistics(data: viewModel.statistics, machines: viewModel.machineStatistics)
                        .navigationTitle("Global Statistics")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    viewModel.isShowingStatistics = false
                                }
                            }
                        }
                }
            }
            .sheet(isPresented: $viewModel.isShowingNewFactory) {
                NavigationStack {
                    NewFactoryView(viewModel: viewModel.newFactoryViewModel())
                }
            }
        }
    }
    
    @ViewBuilder
    private func factoryRow(_ factory: Factory) -> some View {
        HStack {
            ZStack {
                switch factory.image {
                case let .text(text):
                    Text(text)
                        .font(.title)
                    
                case let .asset(imageName):
                    Image(imageName)
                        .resizable()
                }
            }
            .frame(width: 50, height: 50)
            .padding(10)
            .overlay(
                Color("Secondary").opacity(0.3),
                in: AngledRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1.5))
            )
            
            ZStack {
                HStack {
                    Text(factory.name)
                        .font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
                LinearGradient(
                    colors: [Color("Secondary").opacity(0.6), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
    
    @ViewBuilder
    private func newFactoryRow() -> some View {
        HStack {
            Image(systemName: "plus")
                .font(.title)
                .frame(width: 50, height: 50)
                .padding(10)
                .overlay(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 8).stroke(
                        style: StrokeStyle(lineWidth: 1.5, dash: [12, 8])
                    )
                )
            
            ZStack {
                Text("New Factory...")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LinearGradient(
                    colors: [Color("Secondary").opacity(0.6), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

final class NewFactoryViewModel: ObservableObject {
    @Published var name = ""
    @Published var imageName = ""
    
    @Dependency(\.storageService)
    private var storageService
    
    struct ImageSection: Identifiable {
        var name: LocalizedStringKey
        var imageNames: [String]
        var expanded = true
        
        var id: String { "\(name)" }
    }
    
    @Published var itemImageNames: [ImageSection]
    
    var isEmpty: Bool { name.isEmpty }
    
    init() {
        let parts = storage.parts.map(\.imageName)
        let equipment = storage.equipments.map(\.imageName)
        let buildings = storage.buildings.map(\.imageName)
        
        itemImageNames = [
//            ImageSection(name: "Parts", imageNames: parts),
//            ImageSection(name: "Equipment", imageNames: equipment),
//            ImageSection(name: "Buildings", imageNames: buildings)
        ]
        
        imageName = itemImageNames.first?.imageNames.first ?? ""
    }
    
    func save() {
        let factory = Factory(name: name, image: .asset(imageName))
        storage.saveFactory(factory)
    }
}

struct NewFactoryView: View {
    @ObservedObject var viewModel: NewFactoryViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.displayScale) private var displayScale
    @Environment(\.isPresented) private var isPresented
    
    @FocusState private var isFocused
    
    var body: some View {
        Text("Factories view")
//        GeometryReader { geometry in
//            VStack(spacing: 2) {
//                VStack(spacing: 25) {
//                    ZStack {
//                        if !viewModel.imageName.isEmpty {
//                            Image(viewModel.imageName)
//                                .resizable()
//                        }
//                    }
//                    .frame(width: 70, height: 70)
//                    .padding(10)
//                    .overlay(
//                        Color("Secondary").opacity(0.3),
//                        in: AngledRectangle(cornerRadius: 8).stroke(
//                            style: StrokeStyle(lineWidth: 1.5, dash: viewModel.imageName.isEmpty ? [12, 8] : [])
//                        )
//                    )
//                    
//                    VStack {
//                        TextField("Factory name", text: $viewModel.name)
//                            .font(.title)
//                            .multilineTextAlignment(.center)
//                            .focused($isFocused)
//                            .submitLabel(.done)
//                            .onSubmit {
//                                isFocused = false
//                            }
//                        
//                        HStack(spacing: 0) {
//                            LinearGradient(
//                                colors: [Color("Secondary").opacity(0.6), .clear],
//                                startPoint: .trailing,
//                                endPoint: .leading
//                            )
//                            
//                            LinearGradient(
//                                colors: [Color("Secondary").opacity(0.6), .clear],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        }
//                        .frame(height: 2 / displayScale)
//                    }
//                }
//                
//                ScrollView {
//                    LazyVGrid(
//                        columns: [GridItem](
//                            repeating: GridItem(.adaptive(minimum: 50, maximum: 100), spacing: 0),
//                            count: 5
//                        ),
//                        alignment: .leading
//                    ) {
//                        ForEach($viewModel.itemImageNames) { $section in
//                            Section {
//                                if section.expanded {
//                                    ForEach(section.imageNames, id: \.self) { imageName in
//                                        Button {
//                                            withAnimation(.default.speed(2)) {
//                                                viewModel.imageName = imageName
//                                            }
//                                        } label: {
//                                            Image(imageName)
//                                                .resizable()
//                                                .frame(width: 45, height: 45)
//                                                .padding(5)
//                                                .background {
//                                                    if imageName == viewModel.imageName {
//                                                        AngledRectangle(cornerRadius: 8)
//                                                            .stroke(style: StrokeStyle(lineWidth: 1.5))
//                                                            .foregroundStyle(Color("Secondary").opacity(0.45))
//                                                    }
//                                                }
//                                        }
//                                        .buttonStyle(.plain)
//                                    }
//                                }
//                            } header: {
//                                ListSectionHeaderNew(title: section.name, isExpanded: $section.expanded)
//                                    .padding(.horizontal, -10)
//                            } footer: {
//                                if section.expanded {
//                                    ListSectionFooterShape(cornerRadius: 10)
//                                        .stroke(lineWidth: 0.75)
//                                        .foregroundStyle(Color("Secondary").opacity(0.75))
//                                        .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
//                                        .padding(.horizontal, -10)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 26)
//                    .padding(.top, 25)
//                }
//                .safeAreaInset(edge: .bottom, spacing: 0) {
//                    Color.clear
//                        .frame(height: geometry.safeAreaInsets.bottom)
//                }
//                .mask {
//                    VStack(spacing: 0) {
//                        LinearGradient(
//                            colors: [
//                                .clear,
//                                .white.opacity(0.4),
//                                .white.opacity(0.8),
//                                .white
//                            ],
//                            startPoint: .top,
//                            endPoint: .bottom
//                        )
//                        .frame(height: 20)
//                        
//                        Color.white
//                    }
//                }
//            }
//            .contentShape(Rectangle())
//            .onTapGesture {
//                isFocused = false
//            }
//            .ignoresSafeArea(edges: .bottom)
//        }
//        .navigationTitle("New Factory")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .cancellationAction) {
//                Button("Cancel") {
//                    dismiss()
//                }
//            }
//            
//            ToolbarItem(placement: .confirmationAction) {
//                Button("Save") {
//                    viewModel.save()
//                    dismiss()
//                }
//                .disabled(viewModel.isEmpty)
//            }
//        }
//        .interactiveDismissDisabled(!viewModel.isEmpty)
    }
}

final class FactoryViewModel: ObservableObject {
    private let storage: Storage
    var factory: Factory
    
    var productions: [ProductionChain] {
        factory.productions.sortedByTiers()
    }
    
    var statistics: [CalculationStatisticsModel] {
        factory
            .productions
            .map(\.statistics)
            .reduce([], +)
            .reduceDuplicates()
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
        factory
            .productions
            .map(\.machineStatistics)
            .reduce([], +)
            .reduceDuplicates()
            .sorted { lhs, rhs in
                (lhs.item as? Part)?.sortingPriority ?? 1 > (rhs.item as? Part)?.sortingPriority ?? 0
            }
    }
    
    var statisticsHidden: Bool {
        statistics.isEmpty || machineStatistics.isEmpty
    }
    
    @Published var isShowingStatistics = false
    @Published var movingProduction: ProductionChain?
    
    init(storage: Storage, factory: Factory) {
        self.storage = storage
        self.factory = factory
    }
    
    func productionViewModel(for production: ProductionChain) -> ProductionViewModel {
        ProductionViewModel(storage: storage, production: production)
    }
    
    func deleteProduction(_ production: ProductionChain) {
        storage[productionChainID: production.id] = nil
    }
    
    func moveProductionViewModel(for production: ProductionChain) -> MoveProductionViewModel {
        MoveProductionViewModel(storage: storage, production: production)
    }
}

struct FactoryView: View {
    @ObservedObject var viewModel: FactoryViewModel
    
    @Environment(\.displayScale) private var displayScale
    
    var body: some View {
        ZStack {
            if viewModel.productions.isEmpty {
                Text("This factory is empty. You can create a new production and save it to this factory or move already existing production to this factory.")
                    .font(.title3)
                    .padding()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: 600, maxHeight: 450, alignment: .top)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.productions) { production in
                            NavigationLink {
                                ProductionView(viewModel: viewModel.productionViewModel(for: production))
                            } label: {
                                productionRow(production)
                                    .contentShape(.interaction, Rectangle())
                                    .contentShape(
                                        .contextMenuPreview,
                                        AngledRectangle(cornerRadius: 8).inset(by: -8)
                                    )
                                    .contextMenu {
                                        Button {
                                            viewModel.movingProduction = production
                                        } label: {
                                            Label("Move", systemImage: "building.2")
                                        }
                                        
                                        Divider()
                                        
                                        Button(role: .destructive) {
                                            viewModel.deleteProduction(production)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .navigationTitle(viewModel.factory.name)
        .toolbar {
            if !viewModel.statisticsHidden {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        viewModel.isShowingStatistics = true
                    } label: {
                        Label("Statistics", systemImage: "checklist.unchecked")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingStatistics) {
            NavigationStack {
                CalculationStatistics(data: viewModel.statistics, machines: viewModel.machineStatistics)
                    .navigationTitle("Statistics")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                viewModel.isShowingStatistics = false
                            }
                        }
                    }
            }
        }
        .sheet(item: $viewModel.movingProduction) { production in
            NavigationStack {
                MoveProductionView(viewModel: viewModel.moveProductionViewModel(for: production))
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                viewModel.movingProduction = nil
                            }
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private func productionRow(_ production: ProductionChain) -> some View {
        HStack {
            Image(production.item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(10)
                .overlay(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1.5))
                )
            
            ZStack {
                HStack {
                    Text(production.id)
                        .font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
                LinearGradient(
                    colors: [Color("Secondary").opacity(0.6), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

final class ProductionViewModel: ObservableObject {
    private let storage: Storage
    var production: ProductionChain
    
    var statistics: [CalculationStatisticsModel] {
        production
            .statistics
            .reduceDuplicates()
    }
    
    var machineStatistics: [CalculationMachineStatisticsModel] {
        production
            .machineStatistics
            .reduceDuplicates()
            .sorted { lhs, rhs in
                (lhs.item as? Part)?.sortingPriority ?? 1 > (rhs.item as? Part)?.sortingPriority ?? 0
            }
    }
    
    init(storage: Storage, production: ProductionChain) {
        self.storage = storage
        self.production = production
    }
}

struct ProductionView: View {
    @ObservedObject var viewModel: ProductionViewModel
    
    var body: some View {
        NavigationStack {
            CalculationStatistics(data: viewModel.statistics, machines: viewModel.machineStatistics)
                .navigationTitle("Statistics")
        }
    }
}

final class MoveProductionViewModel: ObservableObject {
    private let storage: Storage
    var production: ProductionChain
    
    var factories: [Factory] {
        storage
            .factories
            .sorted(using: KeyPathComparator(\.name))
    }
    
    init(storage: Storage, production: ProductionChain) {
        self.storage = storage
        self.production = production
    }
    
    func moveProduction(to factory: Factory) {
        if let oldFactoryID = production.factoryID, var oldFactory = factories.first(where: { $0.id == oldFactoryID }) {
            oldFactory.productions.remove(production)
            storage.saveFactory(oldFactory)
        }
        
        var productionCopy = production
        productionCopy.factoryID = factory.id
        storage[productionChainID: productionCopy.id] = productionCopy
        
        var factoryCopy = factory
        if !factoryCopy.productions.contains(where: { $0.id == production.id }) {
            factoryCopy.productions.insert(production)
        }
        storage.saveFactory(factoryCopy)
    }
}

struct MoveProductionView: View {
    @ObservedObject var viewModel: MoveProductionViewModel
    
    @Environment(\.displayScale) private var displayScale
    
    var body: some View {
        ZStack {
            if viewModel.factories.isEmpty {
                Text("You don't have any created factories. If you have a Legacy Productions factory, you cannot move any production to this factory, only to factories created by you.")
                    .font(.title3)
                    .padding()
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: 600, maxHeight: 450, alignment: .top)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.factories) { factory in
                            Button {
                                viewModel.moveProduction(to: factory)
                            } label: {
                                factoryRow(factory)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    @ViewBuilder
    private func factoryRow(_ factory: Factory) -> some View {
        HStack {
            ZStack {
                switch factory.image {
                case let .text(text):
                    Text(text)
                        .font(.title)
                    
                case let .asset(imageName):
                    Image(imageName)
                        .resizable()
                }
            }
            .frame(width: 50, height: 50)
            .padding(10)
            .overlay(
                Color("Secondary").opacity(0.3),
                in: AngledRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1.5))
            )
            
            ZStack {
                Text(factory.name)
                    .font(.title3)
                
                LinearGradient(
                    colors: [Color("Secondary").opacity(0.6), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

#if DEBUG
#Preview("Factories view") {
    FactoriesView(viewModel: FactoriesViewModel())
}

#Preview("Factory view") {
    VStack {}
//    NavigationStack {
//        FactoryView(
//            viewModel: FactoryViewModel(
//                storage: storage,
//                factory: Factory(
//                    name: "Preview factory",
//                    image: .text("PF"),
//                    productions: [
//                        ProductionChain(
//                            productionTree: RecipeTree(
//                                element: RecipeElement(
//                                    item: storage[partID: "iron-plate"]!,
//                                    recipe: storage[recipesFor: "iron-plate"][0],
//                                    amount: 100
//                                ),
//                                children: [
//                                    RecipeTree(
//                                        element: RecipeElement(
//                                            item: storage[partID: "iron-ingot"]!,
//                                            recipe: storage[recipesFor: "iron-ingot"][0],
//                                            amount: 150
//                                        )
//                                    )
//                                ]
//                            )
//                        ),
//                        ProductionChain(
//                            productionTree: RecipeTree(
//                                element: RecipeElement(
//                                    item: storage[partID: "iron-rod"]!,
//                                    recipe: storage[recipesFor: "iron-rod"][0],
//                                    amount: 100
//                                ),
//                                children: [
//                                    RecipeTree(
//                                        element: RecipeElement(
//                                            item: storage[partID: "iron-ingot"]!,
//                                            recipe: storage[recipesFor: "iron-ingot"][0],
//                                            amount: 100
//                                        )
//                                    )
//                                ]
//                            )
//                        )
//                    ]
//                )
//            )
//        )
//    }
//    .environmentObject(storage)
//    .environmentObject(Settings())
}

#Preview("New Factory") {
    NavigationStack {
        NewFactoryView(viewModel: NewFactoryViewModel())
    }
}

#Preview("Production view") {
    VStack {}
//    ProductionView(
//        viewModel: ProductionViewModel(
//            storage: storage,
//            production: ProductionChain(
//                productionTree: RecipeTree(
//                    element: RecipeElement(
//                        item: storage[partID: "iron-plate"]!,
//                        recipe: storage[recipesFor: "iron-plate"][0],
//                        amount: 100
//                    ),
//                    children: [
//                        RecipeTree(
//                            element: RecipeElement(
//                                item: storage[partID: "iron-ingot"]!,
//                                recipe: storage[recipesFor: "iron-ingot"][0],
//                                amount: 150
//                            )
//                        )
//                    ]
//                )
//            )
//        )
//    )
//    .environmentObject(storage)
//    .environmentObject(Settings())
}
#endif
