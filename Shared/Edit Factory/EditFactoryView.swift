import SwiftUI

struct EditFactoryView: View {
    @State
    var viewModel: EditFactoryViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Namespace
    private var namespace
    
    @FocusState
    private var focused
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                factoryNameTextField
                
                assetPickerToggle
                
                assetPicker
                
                deleteButton
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.spring.speed(2), value: viewModel.provideAssetImage)
            .navigationTitle(viewModel.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("general-cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("general-save") {
                        viewModel.saveFactory()
                        dismiss()
                    }
                    .disabled(viewModel.saveDisabled)
                }
            }
            .onChange(of: viewModel.provideAssetImage) {
                focused = false
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var factoryNameTextField: some View {
        ListRow {
            iconView
        } label: {
            TextField("edit-factory-factory-name-textfield-placeholder", text: $viewModel.factoryName)
                .submitLabel(.done)
                .focused($focused)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, viewModel.provideAssetImage ? 24 : 60)
    }
    
    @MainActor @ViewBuilder
    private var assetPickerToggle: some View {
        Toggle("edit-factory-provide-image", isOn: $viewModel.provideAssetImage)
            .font(.title3)
            .tint(.sh(.orange))
            .padding(.horizontal, 20)
    }
    
    @MainActor @ViewBuilder
    private var assetPicker: some View {
        if viewModel.provideAssetImage {
            FactoryAssetCatalogView(selectedAssetName: $viewModel.selectedAssetName)
                .transition(.move(edge: .bottom).combined(with: .offset(y: 50)))
        } else {
            Spacer()
        }
    }
    
    @MainActor @ViewBuilder
    private var deleteButton: some View {
        if viewModel.canDeleteFactory {
            Button {
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
                "edit-factory-delete-prompt",
                isPresented: $viewModel.showingDeleteConfirmation,
                titleVisibility: .visible
            ) {
                Button("general-delete", role: .destructive) {
                    viewModel.deleteFactory()
                    viewModel.showingDeleteConfirmation = false
                    dismiss()
                }
            } message: {
                Text("edit-factory-delete-message")
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        ListRowIcon(backgroundShape: .angledRectangle) {
            Group {
                if viewModel.provideAssetImage, let selectedAssetName = viewModel.selectedAssetName {
                    Image(selectedAssetName)
                        .resizable()
                } else if !viewModel.factoryName.isEmpty {
                    Text(viewModel.factoryName.abbreviated())
                } else {
                    Image(systemName: "questionmark")
                }
            }
            .font(.title)
            .foregroundStyle(.sh(.midnight50))
        }
        .matchedGeometryEffect(id: "icon", in: namespace)
    }
}

#if DEBUG
import SHModels

#Preview("New Factory") {
    EditFactoryView(viewModel: EditFactoryViewModel())
}

#Preview("Edit Factory") {
    EditFactoryView(viewModel: EditFactoryViewModel(
        factory: Factory(
            id: UUID(),
            name: "Starter factory",
            asset: .assetCatalog(name: "part-iron-plate"),
            productionIDs: []
        ),
        onSave: { _ in },
        onDelete: { }
    ))
}
#endif
