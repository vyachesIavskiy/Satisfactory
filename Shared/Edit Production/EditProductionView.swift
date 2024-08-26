import SwiftUI
import SHStorage
import SHModels
import SingleItemCalculator

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
        NavigationStack(path: $viewModel.navigationPath) {
            VStack(spacing: 4) {
                productionNameTextField
                
                factoryPicker
                
                assetPicker
                
                deleteButton
            }
            .navigationTitle("New production")
            .navigationDestination(for: EditProductionViewModel.NavigationPath.self) { path in
                switch path {
                case .selectFactory:
                    FactoryPickerView(selectedFactoryID: $viewModel.selectedFactoryID)
                }
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
        HStack(spacing: 12) {
            iconView
            
            TextField("Production name", text: $viewModel.productionName)
                .submitLabel(.done)
                .focused($focused)
                .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
    }
    
    @MainActor @ViewBuilder
    private var factoryPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Select factory")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Button {
                focused = false
                viewModel.navigationPath.append(.selectFactory)
            } label: {
                ZStack {
                    if let factory = viewModel.selectedFactory {
                        FactoryRowView(factory: factory)
                    } else {
                        emptyFactoryRow
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
    
    @MainActor @ViewBuilder
    private var emptyFactoryRow: some View {
        HStack(spacing: 12) {
            ListRowIcon(backgroundShape: .angledRectangle) {
                Image(systemName: "questionmark")
                    .font(.title2)
                    .foregroundStyle(.sh(.midnight))
            }
            
            HStack {
                Text("Factory is not selected")
                    .foregroundStyle(.sh(.midnight).secondary)
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .fontWeight(.light)
                    .foregroundStyle(.sh(.gray))
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#if DEBUG
private struct _EditProductionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    @Dependency(\.uuid)
    private var uuid
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            EditProductionView(viewModel: EditProductionViewModel(
                newProduction: .singleItem(SingleItemProduction(id: uuid(), name: "Plastic", item: item, amount: 20))
            ))
        } else {
            Text("There is no item with id '\(itemID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview {
    _EditProductionPreview(itemID: "part-plastic")
}
#endif

