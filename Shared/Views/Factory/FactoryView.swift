import SwiftUI
import SHSharedUI
import SHModels

struct FactoryView: View {
    @State
    private var viewModel: FactoryViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    init(viewModel: FactoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.section.productions) { production in
                productionRow(production)
            }
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: Text("factories-search-productions"))
        .navigationTitle(viewModel.factory.name)
        .navigationDestination(item: $viewModel.selectedProduction) { production in
            ProductionView(production: production)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button("statistics-button-name", systemImage: "list.number") {
                    viewModel.showingStatisticsSheet = true
                }
                
                Button("general-edit") {
                    viewModel.showingEditFactorySheet = true
                }
                .bold()
            } label: {
                Label("general-more", systemImage: "ellipsis.circle")
            }
        }
        .sheet(isPresented: $viewModel.showingStatisticsSheet) {
            StatisticsView(viewModel: viewModel.statisticsViewModel())
        }
        .sheet(isPresented: $viewModel.showingEditFactorySheet) {
            if viewModel.dismissAfterFactoryDeletion {
                dismiss()
            }
        } content: {
            EditFactoryView(viewModel: viewModel.editFactoryViewModel())
        }
        .sheet(item: $viewModel.productionToEdit) { production in
            EditProductionView(viewModel: EditProductionViewModel(.edit, production: production))
        }
        .task {
            await viewModel.observeProductions()
        }
    }
    
    @MainActor @ViewBuilder
    private func productionRow(_ production: Production) -> some View {
        Button {
            viewModel.selectedProduction = production
        } label: {
            ListRowProduction(production, showFactory: false, accessory: .chevron)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .contextMenu {
            Button("factories-edit-production", systemImage: "pencil") {
                viewModel.productionToEdit = production
            }
            
            Button("factories-delete-production", systemImage: "trash", role: .destructive) {
                viewModel.deleteProduction(production)
            }
        }
    }
}

#if DEBUG
import SHStorage

private struct FactoryPreview: View {
    @Dependency(\.storageService)
    private var storageService
    
    private var productions: [Production] {
        let itemIDs = [
            "part-iron-plate",
            "part-iron-rod",
            "part-reinforced-iron-plate",
            "part-modular-frame"
        ]
        let items = itemIDs.compactMap(storageService.item(id:))
        
        return items.map {
            .singleItem(SingleItemProduction(
                id: UUID(),
                name: $0.localizedName,
                creationDate: Date(),
                item: $0,
                amount: Double(Int.random(in: 1...20)),
                inputItems: [],
                byproducts: []
            ))
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
                    creationDate: Date(),
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
