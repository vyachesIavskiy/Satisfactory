import SwiftUI
import SHSharedUI
import SHModels
import SHEditFactory
import SHEditProduction
import SHStatistics

struct FactoryView: View {
    @State
    private var viewModel: FactoryViewModel
    
    @Binding
    private var navigationPath: [UUID]
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(viewModel: FactoryViewModel, navigationPath: Binding<[UUID]>) {
        self.viewModel = viewModel
        self._navigationPath = navigationPath
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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("statistics-button-name", systemImage: "list.number") {
                    viewModel.showingStatisticsSheet = true
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("general-edit") {
                    viewModel.showingEditFactorySheet = true
                }
            }
        }
        .sheet(isPresented: $viewModel.showingStatisticsSheet) {
            StatisticsView(viewModel: StatisticsViewModel(factory: viewModel.factory))
        }
        .sheet(isPresented: $viewModel.showingEditFactorySheet) {
            EditFactoryView(viewModel: EditFactoryViewModel(factory: viewModel.factory) { newFactory in
                viewModel.factory = newFactory
            } onDelete: {
                dismiss()
            })
        }
        .sheet(item: $viewModel.productionToEdit) { production in
            EditProductionView(viewModel: EditProductionViewModel(editProduction: production))
        }
        .task {
            await viewModel.observeProductions()
        }
    }
    
    @MainActor @ViewBuilder
    private func productionRow(_ production: Production) -> some View {
        Button {
            navigationPath.append(production.id)
        } label: {
            ListRowProduction(production, accessory: .chevron)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .contextMenu {
            Button("factories-edit-production", systemImage: "pencil") {
                viewModel.productionToEdit = production
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
                    asset: .abbreviation,
                    productionIDs: productions.map(\.id)
                )
            )
        }
    }
    
    @State
    private var navigationPath = [UUID]()
    
    var body: some View {
        FactoryView(viewModel: viewModel, navigationPath: $navigationPath)
    }
}

#Preview {
    NavigationStack {
        FactoryPreview()
    }
}
#endif
