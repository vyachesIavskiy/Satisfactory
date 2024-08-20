import SwiftUI
import SHStorage
import SHModels
import SingleItemCalculator

@Observable
final class EditProductionViewModel {
    // MARK: Ignored properties
    let production: SingleItemProduction
    private let onApply: () -> Void
    
    // MARK: Observed properties
    var factories: [Factory]
    var productionName = ""
    var selectedFactoryID: Factory.ID?
    var showingNewFactoryModal = false
    
    var saveDisabled: Bool {
        productionName.isEmpty || selectedFactoryID == nil
    }
    
    var imageName: String {
        production.item.id
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init(production: SingleItemProduction, onApply: @escaping () -> Void) {
        @Dependency(\.storageService)
        var storageService
        
        factories = storageService.factories()
        self.production = production
        self.onApply = onApply
        productionName = production.name
    }
    
    func observeFactories() async {
        for await factories in storageService.streamFactories() {
            guard !Task.isCancelled else { break }
            
            self.factories = factories
        }
    }
    
    func saveProduction() {
        guard let selectedFactoryID else { return }
        
        var newProduction = production
        newProduction.name = productionName
        
        storageService.saveProduction(.singleItem(newProduction), selectedFactoryID)
        onApply()
    }
}

struct EditProductionView: View {
    @State
    private var viewModel: EditProductionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(viewModel: EditProductionViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    iconView
                    
                    ZStack {
                        TextField("Production name", text: $viewModel.productionName)
                            .submitLabel(.done)
                        
                        LinearGradient(
                            colors: [.sh(.midnight40), .sh(.gray10)],
                            startPoint: .leading,
                            endPoint: UnitPoint(x: 0.85, y: 0.5)
                        )
                        .frame(height: 2 / displayScale)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                
                factoriesView
            }
            .navigationTitle("New production")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveProduction()
                        dismiss()
                    }
                    .disabled(viewModel.saveDisabled)
                }
            }
        }
        .task {
            await viewModel.observeFactories()
        }
        .sheet(isPresented: $viewModel.showingNewFactoryModal) {
            NewFactoryView()
        }
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        Image(viewModel.imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .padding(6)
            .background {
                AngledRectangle(cornerRadius: 6)
                    .fill(.sh(.gray20))
                    .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
            }
    }
    
    @MainActor @ViewBuilder
    private var factoriesView: some View {
        if viewModel.factories.isEmpty {
            factoriesEmptyView
        } else {
            factoriesListView
        }
    }
    
    @MainActor @ViewBuilder
    private var factoriesEmptyView: some View {
        VStack(spacing: 24) {
            Text("To save a production you need to attach it to a Factory.")
                .font(.title)
            
            Spacer()
            
            Text("Unfortunatelly, you did not create any factories yet.")
                .font(.title3)
            
            Button {
                viewModel.showingNewFactoryModal = true
            } label: {
                Text("Create a Factory")
                    .font(.title2)
                    .padding(12)
            }
            .buttonStyle(.shBorderedProminent)
            .shButtonCornerRadius(8)
            .padding(24)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
    
    @MainActor @ViewBuilder
    private var factoriesListView: some View {
        List {
            Section {
                ForEach(viewModel.factories) { factory in
                    factoryRow(factory, isSelected: viewModel.selectedFactoryID == factory.id)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectedFactoryID = factory.id
                        }
                        .listRowSeparator(.hidden)
                }
            } header: {
                Text("Select a factory")
            }
        }
        .listStyle(.plain)
    }
    
    @MainActor @ViewBuilder
    private func factoryRow(_ factory: Factory, isSelected: Bool) -> some View {
        HStack(spacing: 12) {
            factoryIconView(factory)
            
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(factory.name)
                        
                        if !factory.productionIDs.isEmpty {
                            Text("\(factory.productionIDs.count) productions")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundStyle(.sh(.orange))
                    }
                }
                
                LinearGradient(
                    colors: [.sh(.midnight40), .sh(.gray10)],
                    startPoint: .leading,
                    endPoint: UnitPoint(x: 0.85, y: 0.5)
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor @ViewBuilder
    private func factoryIconView(_ factory: Factory) -> some View {
        Group {
            switch factory.asset {
            case .abbreviation:
                Text(factory.name.abbreviated())
                    .font(.title2)
                    .foregroundStyle(.sh(.midnight))
                
            case let .assetCatalog(name):
                Image(name)
                    .resizable()
                
            case .legacy:
                Image(systemName: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.title)
            }
        }
        .frame(width: 40, height: 40)
        .padding(6)
        .background {
            AngledRectangle(cornerRadius: 5)
                .fill(.sh(.gray20))
                .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
        }
    }
}

#if DEBUG
private struct EditProductionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    @Dependency(\.uuid)
    private var uuid
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            EditProductionView(viewModel: EditProductionViewModel(
                production: SingleItemProduction(id: uuid(), name: "Plastic", item: item, amount: 20),
                onApply: { }
            ))
        } else {
            Text("There is no item with id '\(itemID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview {
    EditProductionPreview(itemID: "part-plastic")
}
#endif

