import SwiftUI
import SHModels
import SHStorage

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
            List {
                switch viewModel.step {
                case .selectingInitialRecipe:
                    SingleItemProductionInitialRecipeSelectionView(viewModel: SingleItemProductionInitialRecipeSelectionViewModel(item: viewModel.item, onRecipeSelected: viewModel.addInitialRecipe))
                    
                case .production:
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
            .safeAreaInset(edge: .top) {
                Rectangle()
                    .foregroundStyle(.sh(.midnight))
                    .frame(height: 1 / displayScale)
                    .background(.background, ignoresSafeAreaEdges: .top)
            }
            .safeAreaInset(edge: .bottom) {
                if viewModel.step != .selectingInitialRecipe {
                    HStack {
                        Text("Amount")
                        
                        Spacer()
                        
                        TextField("Amount", value: $viewModel.amount, format: .fractionFromZeroToFour)
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
                }
            }
            .toolbar {
                if viewModel.step == .production {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", systemImage: "xmark.square") {
                            if viewModel.hasUnsavedChanges {
                                viewModel.showUnsavedAlert = true
                            } else {
                                dismiss()
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", systemImage: "square.and.arrow.down") {
                    }
                    .disabled(true)
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
                LinearGradient(
                    colors: [.black.opacity(0.6), .black.opacity(0.4), .clear],
                    startPoint: .bottom,
                    endPoint: .top
                )
                .opacity(0.5)
                .ignoresSafeArea()
                .transition(.opacity.animation(.default.speed(0.75)))
                .contentShape(Rectangle())
                .zIndex(1)
                .onTapGesture {
                    viewModel.showUnsavedAlert = false
                }
                
                VStack {
                    Button("Cancel") {
                        viewModel.showUnsavedAlert = false
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                    
                    Text("You have unsaved changes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("If you close production now, all unsaved changes will be lost. Would you like to save those changes?")
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                    
                    HStack(spacing: 24) {
                        Button {
                            viewModel.showUnsavedAlert = false
                            dismiss()
                        } label: {
                            Text("Close")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.shTinted)
                        .tint(.sh(.red))
                        
                        Button {
                            viewModel.showUnsavedAlert = false
                            viewModel.saveProduction()
                            dismiss()
                        } label: {
                            Text("Save and close")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.shTinted)
                    }
                    .padding(.top)
                }
                .padding(24)
                .background(
                    .background.shadow(.drop(color: .sh(.midnight100), radius: 2)),
                    in: RoundedRectangle(cornerRadius: 24, style: .continuous)
                )
                .padding(8)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 16)
                .transition(.move(edge: .bottom))
                .zIndex(2)
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
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 36)
    }
}

#if DEBUG
import SHStorage

private struct _ProductionPreview: View {
    let itemID: String
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(withID: itemID)!
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
