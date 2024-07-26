import SwiftUI
import SHModels

@MainActor
struct NewProductionView: View {
    @State
    var viewModel = NewProductionViewModel()
    
    @Namespace
    private var namespace
    
    @ScaledMetric(relativeTo: .body)
    private var itemSpacing = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach($viewModel.sections) { $section in
                        itemsSection($section)
                    }
                }
            }
            .navigationTitle("New Production")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .autocorrectionDisabled()
            .animation(.default, value: viewModel.pinnedItemIDs)
            .animation(.default, value: viewModel.showFICSMAS)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Picker("Sorting", selection: $viewModel.sorting) {
                            Text("Name")
                                .tag(NewProductionViewModel.Sorting.name)
                            
                            Text("Progression")
                                .tag(NewProductionViewModel.Sorting.progression)
                        }
                    } label: {
                        Label("Sorting", systemImage: "arrow.up.arrow.down.square")
                    }
                }
            }
            .navigationDestination(item: $viewModel.selectedItemID) { id in
                ProductionView(viewModel: viewModel.productionViewModel(for: id))
            }
        }
    }
    
    @ViewBuilder
    private func itemsSection(_ _section: Binding<NewProductionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.items.isEmpty {
            LazyVStack(spacing: 12, pinnedViews: .sectionHeaders) {
                Section(isExpanded: _section.expanded) {
                    ForEach(section.items, id: \.id) { item in
                        itemRow(item)
                            .padding(.horizontal, 16)
                            .disabled(!section.expanded)
                    }
                } header: {
                    SHSectionHeader(section.title, expanded: _section.expanded)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.background)
                }
            }
            .id(section.id)
        }
    }
    
    @ViewBuilder
    private func itemRow(_ item: any Item) -> some View {
        Button {
            viewModel.selectedItemID = item.id
        } label: {
            ItemRow(item)
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button {
                viewModel.changePinStatus(for: item)
            } label: {
                Text(viewModel.isPinned(item) ? "Unpin" : "Pin")
            }
        }
        .id(item.id)
        .matchedGeometryEffect(id: item.id, in: namespace)
    }
}

#if DEBUG
#Preview("New production") {
    NewProductionView(viewModel: NewProductionViewModel())
}
#endif
