import SwiftUI
import SHModels
import SHSharedUI

struct FactoryListView: View {
    @State
    private var viewModel = FactoryListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.factoriesSection.factories.isEmpty || !viewModel.searchText.isEmpty {
                    listView
                } else {
                    emptyStateView
                }
            }
            .navigationTitle("factories-navigation-title")
            .navigationDestination(item: $viewModel.selectedFactory) { factory in
                FactoryView(viewModel: FactoryViewModel(factory: factory))
            }
            .navigationDestination(item: $viewModel.selectedProduction) { production in
                ProductionContentView(production: production)
            }
        }
        .task {
            await viewModel.observeStorage()
        }
        .sheet(isPresented: $viewModel.showingNewFactoryModal) {
            EditFactoryView(viewModel: EditFactoryViewModel(.new))
        }
        .sheet(item: $viewModel.factoryToEdit) { factory in
            EditFactoryView(viewModel: EditFactoryViewModel(.edit(factory)))
        }
        .sheet(item: $viewModel.productionToEdit) { production in
            EditProductionView(viewModel: EditProductionViewModel(.edit, production: production))
        }
    }
    
    @MainActor @ViewBuilder
    private var listView: some View {
        List {
            factoriesSection
            
            productionsSection
        }
        .listStyle(.plain)
        .animation(.default, value: viewModel.searchText)
        .searchable(text: $viewModel.searchText, prompt: Text("factories-search-factories-and-productions"))
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("factories-create-factory", systemImage: "plus.square") {
                    viewModel.showingNewFactoryModal = true
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var factoriesSection: some View {
        if !viewModel.factoriesSection.factories.isEmpty {
            Section(isExpanded: $viewModel.factoriesSection.expanded) {
                ForEach(viewModel.factoriesSection.factories) { factory in
                    factoryRow(factory)
                        .disabled(!viewModel.factoriesSection.expanded)
                }
                .onMove { fromOffsets, toOffset in
                    viewModel.move(fromOffsets: fromOffsets, toOffset: toOffset)
                }
            } header: {
                if !viewModel.productionsSection.productions.isEmpty {
                    SectionHeader("factories-factories-section-name", expanded: $viewModel.factoriesSection.expanded)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        .background(.background)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var productionsSection: some View {
        if !viewModel.productionsSection.productions.isEmpty {
            Section(isExpanded: $viewModel.productionsSection.expanded) {
                ForEach(viewModel.productionsSection.productions) { production in
                    productionView(production)
                        .disabled(!viewModel.productionsSection.expanded)
                }
            } header: {
                SectionHeader("factories-productions-section-name", expanded: $viewModel.productionsSection.expanded)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .background(.background)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func factoryRow(_ factory: Factory) -> some View {
        Button {
            viewModel.selectedFactory = factory
        } label: {
            ListRowFactory(factory, accessory: .chevron)
                .contentShape(.interaction, Rectangle())
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .contextMenu {
            Button("factories-edit-factory", systemImage: "pencil") {
                viewModel.factoryToEdit = factory
            }
            
            Button("factories-delete-factory", systemImage: "trash", role: .destructive) {
                viewModel.promptToDeleteFactory(factory)
            }
        }
        .confirmationDialog(
            "edit-factory-delete-prompt",
            isPresented: $viewModel.showingDeleteFactoryConfirmation,
            titleVisibility: .visible,
            presenting: viewModel.factoryToDelete
        ) { factory in
            Button("general-delete", role: .destructive) {
                viewModel.deleteFactory(factory)
            }
        } message: { _ in
            Text("edit-factory-delete-message")
        }
    }
    
    @MainActor @ViewBuilder
    private func productionView(_ production: Production) -> some View {
        Button {
            viewModel.selectedProduction = production
        } label: {
            ListRowProduction(production, showFactory: true, accessory: .chevron)
                .contentShape(.interaction, Rectangle())
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .contextMenu {
            Button("factories-edit-production", systemImage: "pencil") {
                viewModel.productionToEdit = production
            }
            
            Button("factories-delete-production", systemImage: "trash", role: .destructive) {
                viewModel.promptToDeleteProduction(production)
            }
        }
        .confirmationDialog(
            "edit-production-delete-prompt",
            isPresented: $viewModel.showingDeleteProductionConfirmation,
            titleVisibility: .visible,
            presenting: viewModel.productionToDelete
        ) { production in
            Button("general-delete", role: .destructive) {
                viewModel.deleteProduction(production)
            }
        }
    }
    
    @MainActor @ViewBuilder
    func imageView(_ factory: Factory) -> some View {
        switch factory.asset {
        case .abbreviation:
            let abbreviation = factory
                .name
                .split(separator: " ")
                .prefix(2)
                .compactMap { $0.first.map(String.init) }
                .joined()
            
            Circle()
                .fill(.sh(.gray))
                .overlay {
                    Text(abbreviation)
                        .foregroundStyle(.secondary)
                }
            
        case let .assetCatalog(name):
            Image(name)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(6)
                .background(
                    .sh(.gray20),
                    in: AngledRectangle(cornerRadius: 5)
                )
                .overlay(
                    .sh(.midnight40),
                    in: AngledRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                )
            
        case .legacy:
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.title3)
                .frame(width: 40)
        }
    }
    
    @MainActor @ViewBuilder
    private var emptyStateView: some View {
        VStack(spacing: 120) {
            Text("factories-no-factories-message")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Button {
                viewModel.showingNewFactoryModal = true
            } label: {
                Text("factories-create-factory")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            }
            .buttonStyle(.shBordered)
        }
        .padding(32)
    }
}

#if DEBUG
import SHStorage

#Preview {
    let factories = [
        Factory(id: UUID(), name: "Factory 1", creationDate: Date(), asset: .abbreviation, productionIDs: []),
        Factory(
            id: UUID(),
            name: "Factory 2",
            creationDate: Date(),
            asset: .assetCatalog(name: "part-iron-plate"),
            productionIDs: [UUID()]
        ),
    ]
    
    return withDependencies {
        $0.storageService.factories = {
            factories
        }
        $0.storageService.streamFactories = {
            AsyncStream { factories }
        }
    } operation: {
        FactoryListView()
    }
}
#endif
