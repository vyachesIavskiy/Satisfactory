import SwiftUI
import SHModels
import SHStorage

struct ProductionView: View {
    @Bindable
    var viewModel: ProductionViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    @FocusState
    private var focused
    
    @State
    private var isChangingAmount = false
    
    @State
    private var bottomSheetSize = CGSize.zero
    
    @Namespace
    private var namespace
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.step == .selectingInitialRecipe {
                    initialRecipeSelection
                } else {
                    productionList
                        .sheet(item: $viewModel.selectedNewItemID) { itemID in
                            ProductionNewProductRecipeSelectionView(viewModel: viewModel.addInitialRecipeViewModel(for: itemID))
                        }
                        .sheet(item: $viewModel.selectedProduct) { selectedProduct in
                            ProductAdjustmentView(viewModel: viewModel.productAdjustmentViewModel(for: selectedProduct))
                        }
                }
            }
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", systemImage: "xmark.circle.fill") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", systemImage: "square.and.arrow.down") {
                    }
                    .disabled(true)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationTitle(viewModel.item.localizedName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
//    @MainActor @ViewBuilder
//    private var navigationBar: some View {
//        NavigationBar {
//            if viewModel.step == .selectingInitialRecipe {
//                Text("To start a production calculation, select an initial recipe for an item")
//                    .font(.title3)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            } else {
//                HStack {
//                    Text(viewModel.item.localizedName)
//                        .font(.title3)
//                    
//                    Spacer()
//                    
//                    if viewModel.step != .selectingInitialRecipe {
//                        TextField("Amount", value: $viewModel.amount, format: .fractionFromZeroToFour)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 8)
//                            .padding(.vertical, 2)
//                            .focused($focused)
//                            .frame(maxWidth: 100)
//                            .background(.background, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
//                            .overlay(
//                                .sh(focused ? .orange30 : .midnight30),
//                                in: RoundedRectangle(cornerRadius: 4, style: .continuous)
//                                    .stroke(lineWidth: 1.5)
//                            )
//                        
//                        ZStack {
//                            if focused {
//                                Button {
//                                    focused = false
//                                } label: {
//                                    Image(systemName: "checkmark")
//                                        .fontWeight(.semibold)
//                                }
//                                .buttonStyle(.shTinted)
//                                .transition(.scale.combined(with: .opacity))
//                            } else {
//                                Text("/ min")
//                                    .font(.headline)
//                                    .transition(.move(edge: .trailing).combined(with: .opacity))
//                            }
//                        }
//                        .frame(minWidth: 40, alignment: .leading)
//                        .animation(.bouncy, value: focused)
//                    }
//                }
//            }
//        } buttons: {
//            HStack {
//                Button("Cancel", role: .cancel) {
//                    dismiss()
//                }
//                .buttonStyle(.shToolbar(role: .cancel))
//                
//                Spacer()
//                
//                if viewModel.step != .selectingInitialRecipe {
//                    Button("Save") {
//                    }
//                    .buttonStyle(.shToolbar(role: .confirm))
//                }
//            }
//        }
//        .padding(.top, -16)
//    }
    
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
    
    @MainActor @ViewBuilder
    private var initialRecipeSelection: some View {
        ItemRecipesView(viewModel: ItemRecipesViewModel(item: viewModel.item, onRecipeSelected: viewModel.addInitialRecipe))
    }
}

#if DEBUG
import SHStorage

private struct _ProductionPreview: View {
    let itemID: String
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: itemID)!
    }
    
    var body: some View {
        ProductionView(viewModel: ProductionViewModel(item: item))
    }
}

#Preview {
    _ProductionPreview(itemID: "part-plastic")
}
#endif

extension String: Identifiable {
    public var id: String { self }
}
