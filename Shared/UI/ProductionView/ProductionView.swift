import SwiftUI
import SHModels
import SHStorage

struct ProductionView: View {
    @Bindable
    var viewModel: ProductionViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
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
                            NavigationStack {
                                ItemRecipesView(viewModel: viewModel.addInitialRecipeViewModel(for: itemID))
                                    .navigationTitle(itemID)
                                    .toolbar {
                                        ToolbarItem(placement: .cancellationAction) {
                                            Button {
                                                viewModel.selectedNewItemID = nil
                                            } label: {
                                                Image(systemName: "xmark")
                                                    .bold()
                                            }
                                            .buttonStyle(.bordered)
                                            .buttonBorderShape(.circle)
                                        }
                                    }
                            }
                        }
                        .sheet(item: $viewModel.selectedProduct) { selectedProduct in
                            ProductAdjustmentView(viewModel: viewModel.productAdjustmentViewModel(for: selectedProduct))
                        }
                }
            }
            .safeAreaInset(edge: .top) {
                navigationBar
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var navigationBar: some View {
        NavigationBar {
            if viewModel.step == .selectingInitialRecipe {
                Text("To start a production calculation, select an initial recipe for an item")
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                HStack {
                    Text(viewModel.item.localizedName)
                        .font(.title3)
                    
                    Spacer()
                    
                    if viewModel.step != .selectingInitialRecipe {
                        TextField("Amount", value: $viewModel.amount, format: .fractionFromZeroToFour)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .focused($focused)
                            .frame(maxWidth: 100)
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
                                .transition(.scale.combined(with: .opacity))
                            } else {
                                Text("/ min")
                                    .font(.headline)
                                    .transition(.move(edge: .trailing).combined(with: .opacity))
                            }
                        }
                        .frame(minWidth: 40, alignment: .leading)
                        .animation(.bouncy, value: focused)
                    }
                }
            }
        } buttons: {
            HStack {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                .buttonStyle(.toolbar(role: .cancel))
                
                Spacer()
                
                if viewModel.step != .selectingInitialRecipe {
                    Button("Save") {
                    }
                    .buttonStyle(.toolbar(role: .confirm))
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var topSection: some View {
        switch viewModel.step {
        case .selectingInitialRecipe:
            headerMessage("To start a production calculation, select an initial recipe for an item")
            
        case .idle, .selectingRecipe, .adjustingProduct:
            productionList
        }
    }
    
    @MainActor @ViewBuilder
    private var bottomSection: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [.sh(.midnight10), .sh(.midnight), .sh(.midnight10)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1.5)
                .padding(.horizontal, 24)
            
            switch viewModel.step {
            case .selectingInitialRecipe:
                ItemRecipesView(
                    viewModel: ItemRecipesViewModel(
                        item: viewModel.item,
                        onRecipeSelected: viewModel.addInitialRecipe
                    )
                )
                
            case .idle:
                ProductionAmountView(item: viewModel.item, amount: $viewModel.amount)
                
            case let .selectingRecipe(item):
//                ItemRecipesView(viewModel: viewModel.addInitialRecipeViewModel(for: item))
//                    .safeAreaPadding(.top, 12)
                EmptyView()
                
            case let .adjustingProduct(product):
                ProductAdjustmentView(viewModel: viewModel.productAdjustmentViewModel(for: product))
            }
        }
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
    
    @MainActor @ViewBuilder
    private var initialRecipeSelection: some View {
        ItemRecipesView(viewModel: ItemRecipesViewModel(item: viewModel.item, onRecipeSelected: viewModel.addInitialRecipe))
    }
}

struct SHTintedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundStyle(.tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .foregroundStyle(.tint)
                    .blur(radius: 2)
                
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .foregroundStyle(.background)
            }
    }
}

extension ButtonStyle where Self == SHTintedButtonStyle {
    static var shTinted: Self { SHTintedButtonStyle() }
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
