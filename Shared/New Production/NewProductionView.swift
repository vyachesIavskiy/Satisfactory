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
            List {
                ForEach($viewModel.sections) { $section in
                    itemsSection($section)
                }
            }
            .listStyle(.plain)
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
            Section(isExpanded: _section.expanded) {
                ForEach(section.items, id: \.id) { item in
                    itemRow(item)
                        .disabled(!section.expanded)
                        .listRowSeparator(.hidden)
                }
            } header: {
                SHSectionHeader(section.title, expanded: _section.expanded)
            }
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
    }
}

#if DEBUG
#Preview("New production") {
    NewProductionView(viewModel: NewProductionViewModel())
}
#endif
