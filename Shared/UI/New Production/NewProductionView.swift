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
                VStack(spacing: itemSpacing) {
                    ForEach($viewModel.sections) { $section in
                        itemsSection($section)
                    }
                }
            }
            .navigationTitle("New Production")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section {
                            Toggle("None", isOn: $viewModel.groupingNone)
                            
                            Toggle("Categories", isOn: $viewModel.groupingCategories)
                        } header: {
                            if viewModel.groupingCategories {
                                Text("Group by")
                            }
                        }

                        if viewModel.groupingCategories {
                            Section("Sort") {
                                Toggle("Name", isOn: $viewModel.sortingName)
                                
                                Toggle("Progression", isOn: $viewModel.sortingProgression)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
                }
            }
            .fullScreenCover(item: $viewModel.selectedAnyItem) { anyItem in
                ProductionView(viewModel: ProductionViewModel(item: anyItem.item))
            }
        }
        .task {
            await viewModel.task()
        }
    }
    
    @ViewBuilder
    private func itemsSection(_ _section: Binding<NewProductionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.items.isEmpty {
            Section(isExpanded: _section.expanded) {
                VStack(spacing: itemSpacing) {
                    ForEach(section.items, id: \.id) { item in
                        itemRow(item)
                            .tag(item.id)
                            .id(item.id)
                        
//                        Group {
//                            if let part = item as? Part {
//                                partRow(part)
//                                    .tag(part.id)
//                                    .id(part.id)
//                            } else if let equipment = item as? Equipment {
//                                equipmentRow(equipment)
//                                    .tag(equipment.id)
//                                    .id(equipment.id)
//                            }
//                        }
                        .padding(.leading, viewModel.groupingCategories ? 8 : 0)
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
    
    @ViewBuilder
    func partRow(_ part: Part) -> some View {
        NavigationLink(value: part) {
            itemRow(part)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    func equipmentRow(_ equipment: Equipment) -> some View {
        NavigationLink(value: equipment) {
            itemRow(equipment)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
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
            viewModel.selectedItem = item
        }
        .buttonStyle(.plain)
        .matchedGeometryEffect(id: item.id, in: namespace)
    }
}

#if DEBUG
#Preview("New production") {
    NewProductionView(viewModel: NewProductionViewModel())
}
#endif
