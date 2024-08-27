import SwiftUI
import SHModels
import SHStorage

extension EditProductionView {
    struct FactoryPickerView: View {
        @Binding
        var selectedFactoryID: UUID?
        
        @State
        private var showingNewFactoryModal = false
        
        @Environment(\.displayScale)
        private var displayScale
        
        private var factories: [Factory] {
            @Dependency(\.storageService)
            var storageService
            
            return storageService.factories()
        }
        
        var body: some View {
            ZStack {
                if factories.isEmpty {
                    emptyView
                } else {
                    List {
                        ForEach(factories) { factory in
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
                                showingNewFactoryModal = true
                            }
                        }
                    }
                }
            }
            .navigationTitle("edit-production-factory-picker-navigation-title")
            .sheet(isPresented: $showingNewFactoryModal) {
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
                    showingNewFactoryModal = true
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
                ListRow(accessory: .checkmark) {
                    ListRowIconFactory(factory)
                } label: {
                    Text(factory.name)
                }
            } else {
                ListRow {
                    ListRowIconFactory(factory)
                } label: {
                    Text(factory.name)
                }
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
