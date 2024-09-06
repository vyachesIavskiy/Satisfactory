import SwiftUI
import SHModels
import SHSharedUI

@MainActor
struct SingleItemCalculatorItemSelectionView: View {
    @State
    var viewModel = SingleItemCalculatorItemSelectionViewModel()
    
    var body: some View {
        List {
            ForEach($viewModel.sections) { $section in
                itemsSection($section)
            }
        }
        .listStyle(.plain)
//        .navigationTitle("new-production-single-item-navigation-title")
        .navigationTitle("new-production-navigation-title")
        .searchable(text: $viewModel.searchText, prompt: "general-search")
        .autocorrectionDisabled()
        .animation(.default, value: viewModel.sections)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu("new-production-sorting-button-title", systemImage: "arrow.up.arrow.down.square") {
                    Picker("new-production-sorting-button-title", selection: $viewModel.sorting) {
                        Text("new-production-sorting-name-option")
                            .tag(SingleItemCalculatorItemSelectionViewModel.Sorting.name)
                        
                        Text("new-production-sorting-progression-option")
                            .tag(SingleItemCalculatorItemSelectionViewModel.Sorting.progression)
                    }
                }
            }
        }
        .onAppear {
            viewModel.buildInitialSections()
        }
        .navigationDestination(item: $viewModel.selectedItemID) { itemID in
            if let item = viewModel.item(id: itemID) {
                SingleItemCalculatorContainerView(item: item)
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
    private func itemsSection(_ _section: Binding<SingleItemCalculatorItemSelectionViewModel.Section>) -> some View {
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
                SectionHeader(section.title, expanded: _section.expanded)
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
            viewModel.selectItem(item)
        } label: {
            ListRowItem(item, accessory: .chevron)
                .contentShape(.interaction, Rectangle())
        }
        .listRowBackground(Color.clear)
        .contextMenu {
            Button {
                viewModel.changePinStatus(for: item)
            } label: {
                if viewModel.isPinned(item) {
                    Label("general-unpin", systemImage: "pin.slash.fill")
                } else {
                    Label("general-pin", systemImage: "pin.fill")
                }
            }
        }
    }
}

#if DEBUG
#Preview("Item selection") {
    SingleItemCalculatorItemSelectionView()
}
#endif
