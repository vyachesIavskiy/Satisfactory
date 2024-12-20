import SwiftUI
import SHSharedUI
import SHModels

struct FromResourcesCalculatorItemsSelectionView: View {
    @State
    var viewModel = FromResourcesCalculatorItemsSelectionViewModel()
    
    var body: some View {
        List {
            ForEach($viewModel.sections) { $section in
                itemsSection($section)
            }
        }
        .listStyle(.plain)
        .navigationTitle("new-production-from-resources-navigation-title")
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
            
            ToolbarItem(placement: .primaryAction) {
                NavigationLink("general-next") {
                    Text("Calculation")
                }
                .disabled(viewModel.selectedPartIDs.isEmpty)
            }
        }
        .onAppear {
            viewModel.buildInitialSections()
        }
//        .navigationDestination(item: $viewModel.selectedItemID) { itemID in
//            if let item = viewModel.item(id: itemID) {
//                SingleItemCalculatorContainerView(item: item)
//            }
//        }
        .task {
            await viewModel.observeStorage()
        }
        .task {
            await viewModel.observeSettings()
        }
    }
    
    @ViewBuilder
    private func itemsSection(_ _section: Binding<FromResourcesCalculatorItemsSelectionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.parts.isEmpty {
            Section(isExpanded: _section.expanded) {
                ForEach(section.parts) { part in
                    itemRow(part)
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
    private func itemRow(_ part: Part) -> some View {
        Button {
            viewModel.selectPart(part)
        } label: {
            ListRowItem(part, accessory: .checkmark(.multiSelection(selected: viewModel.isSelected(part))))
                .contentShape(.interaction, Rectangle())
        }
        .listRowBackground(Color.clear)
        .contextMenu {
            Button {
                viewModel.changePinStatus(for: part)
            } label: {
                if viewModel.isPinned(part) {
                    Label("general-unpin", systemImage: "pin.slash.fill")
                } else {
                    Label("general-pin", systemImage: "pin.fill")
                }
            }
        }
    }
}
