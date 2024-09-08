import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

extension EditProductionView {
    struct FactoryPickerView: View {
        @State
        private var viewModel: FactoryPickerViewModel
        
        @Binding
        private var selectedFactoryID: UUID?
        
        @Environment(\.displayScale)
        private var displayScale
        
        init(selectedFactoryID: Binding<UUID?>) {
            _selectedFactoryID = selectedFactoryID
            _viewModel = State(initialValue: FactoryPickerViewModel(selectedFactoryID: selectedFactoryID.wrappedValue))
        }
        
        var body: some View {
            ZStack {
                if viewModel.factories.isEmpty {
                    emptyView
                } else {
                    List {
                        ForEach(viewModel.factories) { factory in
                            Button {
                                withAnimation(.default.speed(2)) {
                                    selectedFactoryID = factory.id
                                }
                            } label: {
                                factoryRow(factory)
                                    .contentShape(.interaction, Rectangle())
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button("factories-create-factory", systemImage: "plus.square") {
                                viewModel.createNewFactory()
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.observeFactories()
            }
            .navigationTitle("edit-production-factory-picker-navigation-title")
            .sheet(isPresented: $viewModel.showingNewFactoryModal) {
                viewModel.selectNewlyAddedFactory()
            } content: {
                EditFactoryView(viewModel: EditFactoryViewModel())
            }
        }
        
        @MainActor @ViewBuilder
        private var emptyView: some View {
            VStack(spacing: 120) {
                Text("factories-no-factories-message")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Button {
                    viewModel.createNewFactory()
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
        
        @MainActor @ViewBuilder
        private func factoryRow(_ factory: Factory) -> some View {
            if selectedFactoryID == factory.id {
                ListRowFactory(factory, accessory: .checkmark(.singleSelection))
            } else {
                ListRowFactory(factory)
            }
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State
    var selectedFactoryID: UUID?
    
    NavigationStack {
        EditProductionView.FactoryPickerView(selectedFactoryID: $selectedFactoryID)
    }
}
#endif
