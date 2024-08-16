import SwiftUI
import SHModels

struct FactoryView: View {
    @State
    private var viewModel: FactoryViewModel
    
    init(viewModel: FactoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.section.productions) { production in
                ProductionRowView(production: production)
                    .background {
                        NavigationLink("") {
                            ProductionView(production: production)
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .contextMenu {
                        Button("Rename", systemImage: "pencil.line") {
                            viewModel.productionToRename = production
                            viewModel.newProductionName = production.name
                            viewModel.showingRenameAlert = true
                        }
                        
                        Divider()
                        
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            viewModel.productionToDelete = production
                            viewModel.showingDeleteAlert = true
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle(viewModel.factory.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Statistics", systemImage: "info.bubble") {
                    viewModel.showingStatisticsSheet = true
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    // Edit factory
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: Text("Search productions"))
        .alert(
            "Rename production",
            isPresented: $viewModel.showingRenameAlert,
            presenting: viewModel.productionToRename
        ) { production in
            TextField("New production name", text: $viewModel.newProductionName)
                .submitLabel(.done)
            
            Button("Rename") {
                viewModel.renameProduction(production)
                viewModel.productionToRename = nil
            }
            
            Button("Cancel", role: .cancel) {
                viewModel.productionToRename = nil
            }
        }
        .confirmationDialog(
            "Are you sure you would like to delete production?",
            isPresented: $viewModel.showingDeleteAlert,
            titleVisibility: .visible,
            presenting: viewModel.productionToDelete
        ) { production in
            Button("Delete", role: .destructive) {
                viewModel.deleteProduction(production)
                viewModel.productionToDelete = nil
            }
            
            Button("Cancel", role: .cancel) {
                viewModel.productionToDelete = nil
            }
        } message: { _ in
            Text("This action cannot be undone.")
        }
        .sheet(isPresented: $viewModel.showingStatisticsSheet) {
            NavigationStack {
                Text("Statistics will be here")
                    .font(.title)
                    .padding()
                    .navigationTitle(viewModel.factory.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                viewModel.showingStatisticsSheet = false
                            }
                        }
                    }
            }
        }
        .task {
            await viewModel.observeProductions()
        }
    }
}

#if DEBUG
import SHStorage

private struct FactoryPreview: View {
    @Dependency(\.storageService)
    private var storageService
    
    private var productions: [SingleItemProduction] {
        let itemIDs = [
            "part-iron-plate",
            "part-iron-rod",
            "part-reinforced-iron-plate",
            "part-modular-frame"
        ]
        let items = itemIDs.compactMap(storageService.item(id:))
        
        return items.map {
            SingleItemProduction(
                id: UUID(),
                name: $0.localizedName,
                item: $0,
                amount: Double(Int.random(in: 1...20)),
                inputItems: [],
                byproducts: []
            )
        }
    }
    
    private var viewModel: FactoryViewModel {
        let productions = productions
        
        return withDependencies {
            $0.storageService.productions = { @Sendable in
                productions
            }
            $0.storageService.streamProductions = { @Sendable in
                AsyncStream { productions }
            }
        } operation: {
            FactoryViewModel(
                factory: Factory(
                    id: UUID(),
                    name: "Preview factory",
                    asset: .abbreviation,
                    productionIDs: productions.map(\.id)
                )
            )
        }

    }
    
    var body: some View {
        FactoryView(viewModel: viewModel)
    }
}

#Preview {
    NavigationStack {
        FactoryPreview()
    }
}
#endif
