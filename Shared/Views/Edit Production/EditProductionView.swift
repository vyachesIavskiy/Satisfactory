import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

public struct EditProductionView: View {
    @State
    private var viewModel: EditProductionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @FocusState
    private var focused
    
    public init(viewModel: EditProductionViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                productionNameTextField
                
                factoryPicker
                
                assetPicker
                
                deleteButton
            }
            .navigationTitle(viewModel.navigationTitle)
            .navigationDestination(isPresented: $viewModel.showingFactoryPicker) {
                FactoryPickerView(selectedFactoryID: $viewModel.selectedFactoryID)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("general-cancel") {
                        focused = false
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("general-save") {
                        focused = false
                        viewModel.saveProduction()
                        dismiss()
                    }
                    .disabled(viewModel.saveDisabled)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var productionNameTextField: some View {
        ListRow {
            iconView
        } label: {
            TextField("edit-production-production-name-textfield-placeholder", text: $viewModel.productionName)
                .submitLabel(.done)
                .focused($focused)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
    }
    
    @MainActor @ViewBuilder
    private var factoryPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("edit-production-select-factory-section-header")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Button {
                focused = false
//                viewModel.navigationPath.append(.selectFactory)
                viewModel.showingFactoryPicker = true
            } label: {
                ZStack {
                    if let factory = viewModel.selectedFactory {
                        ListRowFactory(factory, accessory: .chevron)
                    } else {
                        ListRow(accessory: .chevron) {
                            ListRowIcon(backgroundShape: .angledRectangle) {
                                Image(systemName: "questionmark")
                                    .font(.title2)
                                    .foregroundStyle(.sh(.midnight))
                            }
                        } label: {
                            Text("edit-production-factory-is-not-selected")
                                .foregroundStyle(.sh(.midnight).secondary)
                        }
                    }
                }
                .contentShape(.interaction, Rectangle())
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
    }
    
    @MainActor @ViewBuilder
    private var assetPicker: some View {
        if viewModel.canSelectAsset {
            VStack(alignment: .leading, spacing: 8) {
                FactoryAssetCatalogView(selectedAssetName: $viewModel.selectedAssetName)
                    .transition(.move(edge: .bottom).combined(with: .offset(y: 50)))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        } else {
            Spacer()
        }
    }
    
    @MainActor @ViewBuilder
    private var deleteButton: some View {
        if viewModel.canDeleteProduction {
            Button {
                focused = false
                viewModel.showingDeleteConfirmation = true
            } label: {
                Text("general-delete")
                    .font(.title3)
                    .padding(.horizontal)
            }
            .buttonStyle(.shBordered)
            .padding(.vertical, 4)
            .tint(.sh(.red))
            .confirmationDialog(
                "edit-production-delete-prompt",
                isPresented: $viewModel.showingDeleteConfirmation,
                titleVisibility: .visible
            ) {
                Button("general-delete", role: .destructive) {
                    viewModel.deleteProduction()
                    viewModel.showingDeleteConfirmation = false
                    dismiss()
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        ListRowIcon(backgroundShape: .angledRectangle) {
            Group {
                if let selectedAssetName = viewModel.selectedAssetName {
                    Image(selectedAssetName)
                        .resizable()
                } else {
                    Image(systemName: "questionmark")
                }
            }
            .font(.title)
            .foregroundStyle(.sh(.midnight50))
        }
    }
}

#if DEBUG
#Preview("New production") {
    _EditProductionPreview(newProductionWithItemID: "part-plastic")
}

#Preview("Edit production") {
    _EditProductionPreview(editProductionWithItemID: "part-plastic")
}

private struct _EditProductionPreview: View {
    let viewModel: EditProductionViewModel
    
    @Dependency(\.uuid)
    private var uuid
    
    init(newProductionWithItemID itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.uuid)
        var uuid
        
        let item = storageService.item(id: itemID)!
        let production = SingleItemProduction(id: uuid(), name: item.localizedName, item: item, amount: 0)
        viewModel = EditProductionViewModel(.new, production: .singleItem(production))
    }
    
    init(editProductionWithItemID itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.uuid)
        var uuid
        
        let item = storageService.item(id: itemID)!
        let production = SingleItemProduction(id: uuid(), name: item.localizedName, item: item, amount: 0)
        viewModel = EditProductionViewModel(.edit, production: .singleItem(production))
    }
    
    var body: some View {
        EditProductionView(viewModel: viewModel)
    }
}
#endif

