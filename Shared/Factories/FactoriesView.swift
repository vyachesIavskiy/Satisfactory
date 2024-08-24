import SwiftUI
import SHModels

struct FactoriesView: View {
    @State
    private var viewModel = FactoriesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !viewModel.factoriesSection.factories.isEmpty {
                    listView
                } else {
                    emptyStateView
                }
            }
            .navigationTitle("factories-navigation-title")
        }
        .task {
            await viewModel.observeStorage()
        }
        .sheet(isPresented: $viewModel.showingNewFactoryModal) {
            NewFactoryView()
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
        Section(isExpanded: $viewModel.factoriesSectionExpanded) {
            ForEach(viewModel.factoriesSection.factories) { factory in
                FactoryRowView(factory: factory)
                    .background {
                        NavigationLink("") {
                            FactoryView(viewModel: FactoryViewModel(factory: factory))
                        }
                        .opacity(0)
                    }
                    .listRowSeparator(.hidden)
                    .contextMenu {
                        Button("general-delete", systemImage: "trash", role: .destructive) {
                            viewModel.factoryToDelete = factory
                            viewModel.showingDeleteFactoryAlert = true
                        }
                    }
            }
        } header: {
            if !viewModel.productionsSection.productions.isEmpty {
                SHSectionHeader("factories-factories-section-name", expanded: $viewModel.factoriesSectionExpanded)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .background(.background)
            }
        }
        .id(viewModel.factoriesSection.id)
        .confirmationDialog(
            "factories-delete-factory",
            isPresented: $viewModel.showingDeleteFactoryAlert,
            presenting: viewModel.factoryToDelete
        ) { factory in
            Button("general-delete", role: .destructive) {
                viewModel.deleteFactory(factory)
            }
            
            Button("general-cancel", role: .cancel) {
                viewModel.factoryToDelete = nil
            }
        } message: { _ in
            Text("factory-delete-factory-message")
        }
    }
    
    @MainActor @ViewBuilder
    private var productionsSection: some View {
        if !viewModel.searchText.isEmpty {
            Section(isExpanded: $viewModel.productionsSectionExpanded) {
                ForEach(viewModel.productionsSection.productions) { production in
                    Button {
                        // TODO: Select production
                    } label: {
                        ProductionRowView(production: production)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            } header: {
                if !viewModel.productionsSection.productions.isEmpty {
                    SHSectionHeader("factories-productions-section-name", expanded: $viewModel.productionsSectionExpanded)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        .background(.background)
                }
            }
            .id(viewModel.productionsSection.id)
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
                    .foregroundStyle(.background)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 4)
            }
            .buttonStyle(.shBorderedProminent)
        }
        .padding(32)
    }
}

#if DEBUG
#Preview {
    FactoriesView()
}
#endif
