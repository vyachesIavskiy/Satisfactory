import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

struct EditProductionView: View {
    @State
    private var viewModel: EditProductionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @FocusState
    private var focused
    
    init(viewModel: EditProductionViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
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
                    Button(viewModel.confirmationTitle) {
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
                    .font(.title2)
                    .padding(.horizontal)
            }
            .buttonStyle(.shBordered)
            .padding(.vertical, 16)
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
        @Dependency(\.uuid)
        var uuid
        
        @Dependency(\.date)
        var date
        
        let part = part(id: itemID)
        let production = Production(
            id: uuid(),
            name: part.localizedName,
            creationDate: date(),
            assetName: part.id,
            content: .singleItem(Production.Content.SingleItem(part: part, amount: 0))
        )
        viewModel = EditProductionViewModel(.new, production: production)
    }
    
    init(editProductionWithItemID itemID: String) {
        @Dependency(\.uuid)
        var uuid
        
        @Dependency(\.date)
        var date
        
        let part = part(id: itemID)
        let production = Production(
            id: uuid(),
            name: part.localizedName,
            creationDate: date(),
            assetName: part.id,
            content: .singleItem(Production.Content.SingleItem(part: part, amount: 0))
        )
        viewModel = EditProductionViewModel(.edit, production: production)
    }
    
    var body: some View {
        EditProductionView(viewModel: viewModel)
    }
}
#endif

