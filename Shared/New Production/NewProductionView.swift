import SwiftUI
import SHModels

@MainActor
struct NewProductionView: View {
    @State
    var viewModel = NewProductionViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                ForEach($viewModel.sections) { $section in
                    itemsSection($section)
                }
            }
            .listStyle(.plain)
            .navigationTitle("New Production")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .autocorrectionDisabled()
            .animation(.default, value: viewModel.sections)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("Sorting", systemImage: "arrow.up.arrow.down.square") {
                        Picker("Sorting", selection: $viewModel.sorting) {
                            Text("Name")
                                .tag(NewProductionViewModel.Sorting.name)
                            
                            Text("Progression")
                                .tag(NewProductionViewModel.Sorting.progression)
                        }
                    }
                }
            }
            .navigationDestination(for: String.self) { itemID in
                if let item = viewModel.item(id: itemID) {
                    ProductionView(item: item)
                }
            }
        }
        .task {
            await viewModel.observeStorage()
        }
        .task {
            await viewModel.observeSettings()
        }
    }
    
    @ViewBuilder
    private func itemsSection(_ _section: Binding<NewProductionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.items.isEmpty {
            Section(isExpanded: _section.expanded) {
                ForEach(section.items, id: \.id) { item in
                    itemRow(item)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 20))
                        .disabled(!section.expanded)
                }
            } header: {
                SHSectionHeader(section.title, expanded: _section.expanded)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .background(.background)
            }
        }
    }
    
    @ViewBuilder
    private func itemRow(_ item: any Item) -> some View {
        Button {
            viewModel.navigationPath = [item.id]
        } label: {
            ItemRow(item)
                .contentShape(.interaction, Rectangle())
        }
        .listRowBackground(Color.clear)
        .contextMenu {
            Button {
                viewModel.changePinStatus(for: item)
            } label: {
                if viewModel.isPinned(item) {
                    Label("Unpin", systemImage: "pin.slash.fill")
                } else {
                    Label("Pin", systemImage: "pin.fill")
                }
            }
        }
    }
}

#if DEBUG
#Preview("New production") {
    NewProductionView()
}
#endif
