import SwiftUI

struct CalculationView: View {
    @State
    var viewModel: CalculationViewModel
    
    @State
    private var viewModelToDrag: ProductViewModel?
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @FocusState
    private var focused
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16, pinnedViews: .sectionHeaders) {
                ForEach(viewModel.outputItemViewModels) { viewModel in
                    ProductView(viewModel: viewModel)
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            amountView
        }
        .navigationBarBackButtonHidden(!viewModel.canBeDismissedWithoutSaving)
        .navigationTitle(viewModel.item.localizedName)
        #if os(iOS)
        .toolbarBackground(.background, for: .navigationBar)
        #endif
        .toolbar { toolbar }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.startLocation.x < 40 {
                        viewModel.showingUnsavedConfirmationDialog = true
                    }
                },
            isEnabled: !viewModel.showingUnsavedConfirmationDialog && !viewModel.canBeDismissedWithoutSaving && viewModel.modalNavigationState == nil
        )
        .sheet(item: $viewModel.modalNavigationState) { state in
            sheetContentView(state: state)
        }
    }
    
    @MainActor @ViewBuilder
    private func selectInitialRecipeView(viewModel: InitialRecipeSelectionViewModel) -> some View {
        NavigationStack {
            InitialRecipeSelectionView(viewModel: viewModel)
                .navigationTitle(viewModel.item.localizedName)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("general-cancel") {
                            self.viewModel.modalNavigationState = nil
                        }
                    }
                }
        }
        .id(viewModel.item.id)
    }
    
    @MainActor @ViewBuilder
    private func adjustItemView(viewModel: ProductAdjustmentViewModel) -> some View {
        ProductAdjustmentView(viewModel: viewModel)
    }
    
    @MainActor @ViewBuilder
    private var amountView: some View {
        HStack {
            Text("single-item-production-calculation-amount-title")
            
            Spacer()
            
            TextField("single-item-production-calculation-amount-title", value: $viewModel.amount, format: .shNumber)
                .multilineTextAlignment(.center)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .focused($focused)
                .submitLabel(.done)
                .onSubmit {
                    focused = false
                    viewModel.adjustNewAmount()
                    viewModel.update()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
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
                        viewModel.adjustNewAmount()
                        viewModel.update()
                    } label: {
                        Image(systemName: "checkmark")
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.shBordered)
                } else {
                    Text("single-item-production-calculation-amount-per-minute")
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
    
    @MainActor @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        if viewModel.selectingByproduct {
            ToolbarItem(placement: .cancellationAction) {
                Button("general-cancel") {
                    viewModel.cancelByproductSelection()
                }
            }
        } else if !viewModel.canBeDismissedWithoutSaving {
            ToolbarItem(placement: .cancellationAction) {
                Button("general-cancel") {
                    viewModel.showingUnsavedConfirmationDialog = true
                }
                .confirmationDialog(
                    "single-item-production-calculation-you-have-unsaved-changes",
                    isPresented: $viewModel.showingUnsavedConfirmationDialog,
                    titleVisibility: .visible
                ) {
                    Button("single-item-production-calculation-save-and-exit") {
                        viewModel.saveProduction {
                            dismiss()
                        }
                    }
                    
                    Button("single-item-production-calculation-dont-save", role: .destructive) {
                        dismiss()
                    }
                } message: {
                    Text("single-item-production-calculation-you-have-unsaved-changes-message")
                }
            }
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button("single-item-production-calculation-save", systemImage: "square.and.arrow.down") {
                viewModel.saveProduction()
            }
            .disabled(viewModel.canBeDismissedWithoutSaving || viewModel.selectingByproduct)
        }
        
        ToolbarItem(placement: .secondaryAction) {
            Button("single-item-production-calculation-statistics", systemImage: "list.number") {
                viewModel.showStatistics()
            }
        }
        
        if viewModel.hasSavedProduction {
            ToolbarItem(placement: .secondaryAction) {
                Button("general-edit", systemImage: "pencil") {
                    viewModel.editProduction()
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func sheetContentView(state: CalculationViewModel.ModalNavigationState) -> some View {
        switch state {
        case let .selectInitialRecipeForItem(viewModel):
            selectInitialRecipeView(viewModel: viewModel)
            
        case let .adjustItem(viewModel):
            adjustItemView(viewModel: viewModel)
            
        case let .editProduction(viewModel):
            EditProductionView(viewModel: viewModel)
            
        case let .statistics(viewModel):
            StatisticsView(viewModel: viewModel)
        }
    }
}

#if DEBUG
import SHStorage
import SHModels

private struct _CalculationPreview: View {
    private let itemID: String
    private let item: (any Item)?
    
    private let recipeID: String
    private let recipe: Recipe?
    
    @State
    private var viewModel: CalculationViewModel?
    
    init(itemID: String, recipeID: String) {
        @Dependency(\.storageService)
        var storageService
        
        self.itemID = itemID
        self.recipeID = recipeID
        
        item = storageService.item(id: itemID)
        recipe = storageService.recipe(id: recipeID)
        
        if let item, let recipe {
            _viewModel = State(initialValue: CalculationViewModel(item: item, recipe: recipe))
        }
    }
    
    var body: some View {
        if let viewModel {
            NavigationStack {
                CalculationView(viewModel: viewModel)
            }
        } else {
            VStack(spacing: 24) {
                if item == nil {
                    Text(verbatim: "There is no item with id '\(itemID)'")
                }
                
                if recipe == nil {
                    Text(verbatim: "There is no recipe with id '\(recipeID)'")
                }
            }
            .font(.title2)
            .padding()
        }
    }
}

#Preview("Calculation View") {
    _CalculationPreview(itemID: "part-plastic", recipeID: "recipe-alternate-recycled-plastic")
}
#endif