import SwiftUI
import SHModels

struct NewProductionView: View {
    @Bindable
    var viewModel: NewProductionViewModel
    
    @Namespace
    private var namespace
    
    @ScaledMetric(relativeTo: .body)
    private var itemSpacing = 8.0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: itemSpacing) {
                    ForEach($viewModel.sections) { $section in
                        itemsSection($section)
                    }
                }
            }
            .navigationTitle("New Production")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .autocorrectionDisabled()
            .animation(.default, value: viewModel.pins)
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
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .fullScreenCover(item: $viewModel.selectedItemID) { itemID in
                ProductionView(viewModel: viewModel.productionViewModel(for: itemID))
            }
        }
        .task {
            await viewModel.observe()
        }
    }
    
    @MainActor @ViewBuilder
    private func itemsSection(_ _section: Binding<NewProductionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.items.isEmpty {
            Section(isExpanded: _section.expanded) {
                LazyVStack(spacing: itemSpacing) {
                    ForEach(section.items, id: \.id) { item in
                        itemRow(item)
                            .disabled(!section.expanded)
                    }
                }
                .padding(.bottom, section.expanded ? 16 : 0)
            } header: {
                SHSectionHeader(section.title, expanded: _section.expanded)
            }
            .padding(.horizontal, 16)
        }
    }
    
    @MainActor @ViewBuilder
    private func itemRow(_ item: any Item) -> some View {
        Menu {
            Button {
                viewModel.changePinStatus(for: item)
            } label: {
                Text(viewModel.isPinned(item) ? "Unpin" : "Pin")
            }
        } label: {
            ItemRow(item)
        } primaryAction: {
            viewModel.selectedItemID = item.id
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
#Preview("New production") {
    NewProductionView(viewModel: NewProductionViewModel())
}
#endif
