import SwiftUI
import SHModels
import SHStorage
import SHUtils

struct ProductionView: View {
    @State
    var viewModel: ProductionViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    @FocusState
    private var focused
    
    @Namespace
    private var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
                switch viewModel.step {
                case .initialRecipe:
                    SingleItemProductionInitialRecipeSelectionView(viewModel: viewModel.initialRecipeSelectionViewModel())
                    
                default:
                    productionList
                        .sheet(item: $viewModel.selectedNewItemID) { itemID in
                            ProductionNewProductRecipeSelectionView(viewModel: viewModel.addInitialRecipeViewModel(for: itemID))
                        }
                        .sheet(item: $viewModel.selectedProduct) { selectedProduct in
                            ProductAdjustmentView(viewModel: viewModel.productAdjustmentViewModel(for: selectedProduct))
                        }
                }
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .top, spacing: 0) {
                Rectangle()
                    .foregroundStyle(.sh(.midnight))
                    .frame(height: 1 / displayScale)
                    .background(.background, ignoresSafeAreaEdges: .top)
            }
            .safeAreaInset(edge: .bottom) {
                if viewModel.step != .initialRecipe {
                    HStack {
                        Text("Amount")
                        
                        Spacer()
                        
                        TextField("Amount", value: $viewModel.amount, format: .shNumber)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .focused($focused)
                            .frame(maxWidth: 150)
                            .background(.background, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                            .overlay(
                                .sh(focused ? .orange30 : .midnight30),
                                in: RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .stroke(lineWidth: 1.5)
                            )
                        
                        ZStack {
                            if focused {
                                Button {
                                    focused = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .fontWeight(.semibold)
                                }
                                .buttonStyle(.shTinted)
                            } else {
                                Text("/ min")
                                    .font(.headline)
                            }
                        }
                        .frame(minWidth: 40, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding([focused ? .vertical : .top], 8)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .foregroundStyle(.sh(.midnight))
                            .frame(height: 1 / displayScale)
                    }
                    .background(.background)
                }
            }
            .toolbar {
                if viewModel.step == .production {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            if viewModel.hasUnsavedChanges {
                                viewModel.showUnsavedAlert = true
                            } else {
                                dismiss()
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.backward")
                                    .fontWeight(.semibold)
                                
                                Text("Back")
                            }
                            .offset(x: -8)
                        }
                    }
                }
                
                if viewModel.hasUnsavedChanges {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Save", systemImage: "square.and.arrow.down") {
                            viewModel.saveProduction()
                        }
                        .disabled(true)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .bottomBar, .tabBar)
            .navigationTitle(viewModel.item.localizedName)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(viewModel.step == .production)
            .disabled(viewModel.showUnsavedAlert)
            
            // Alerts
            if viewModel.showUnsavedAlert {
                UnsavedChangesAlert {
                    viewModel.showUnsavedAlert = false
                } onSaveAndExit: {
                    viewModel.showUnsavedAlert = false
                    viewModel.saveProduction()
                    dismiss()
                } onExit: {
                    viewModel.showUnsavedAlert = false
                    dismiss()
                }
            }
        }
        .animation(.default, value: viewModel.showUnsavedAlert)
    }
    
    @MainActor
    @ViewBuilder
    private func headerMessage(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.title2)
            .padding(.horizontal, 36)
            .padding(.vertical, 48)
        
        Spacer()
    }
    
    @MainActor
    @ViewBuilder
    private var productionList: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.productViewModels()) { productViewModel in
                ProductView(viewModel: productViewModel, namespace: namespace)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 16)
    }
}

#if DEBUG
import SHStorage

private struct _ProductionPreview: View {
    let itemID: String
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(id: itemID)!
    }
    
    var body: some View {
        NavigationStack {
            ProductionView(viewModel: ProductionViewModel(item: item))
        }
    }
}

#Preview {
    _ProductionPreview(itemID: "part-plastic")
}
#endif

extension String: Identifiable {
    public var id: String { self }
}
