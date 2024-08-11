import SwiftUI

struct CalculationView: View {
    @State
    var viewModel: CalculationViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @FocusState
    private var focused
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
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
        .toolbar {
            if viewModel.selectingByproduct {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.cancelByproductSelection()
                    }
                }
            } else if !viewModel.canBeDismissedWithoutSaving {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.showingUnsavedConfirmationDialog = true
                    }
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Statistics", systemImage: "info.bubble") {
//                    viewModel.showingStatisticsSheet = true
                }
            }
                
            if viewModel.hasUnsavedChanges, !viewModel.selectingByproduct {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save", systemImage: "square.and.arrow.down") {
                        viewModel.saveProduction()
                    }
                    .disabled(true)
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.startLocation.x < 40 {
                        viewModel.showingUnsavedConfirmationDialog = true
                    }
                },
            isEnabled: !viewModel.showingUnsavedConfirmationDialog || !viewModel.canBeDismissedWithoutSaving || viewModel.modalNavigationState == nil
        )
        .confirmationDialog(
            "You have unsaved changes",
            isPresented: $viewModel.showingUnsavedConfirmationDialog,
            titleVisibility: .visible
        ) {
            Button("Save and exit") {
                viewModel.saveProduction()
                dismiss()
            }
            
            Button("Don't save", role: .destructive) {
                dismiss()
            }
            
            Button("Cancel", role: .cancel) {
                // Do nothing
            }
        } message: {
            Text("If you close production now, all unsaved changes will be lost. Would you like to save those changes?")
        }
        .sheet(item: $viewModel.modalNavigationState) { state in
            switch state {
            case let .selectInitialRecipeForItem(viewModel):
                selectInitialRecipeView(viewModel: viewModel)
                
            case let .adjustItem(viewModel):
                adjustItemView(viewModel: viewModel)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func selectInitialRecipeView(viewModel: InitialRecipeSelectionViewModel) -> some View {
        NavigationStack {
            InitialRecipeSelectionView(viewModel: viewModel)
                .navigationTitle(viewModel.item.localizedName)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            self.viewModel.modalNavigationState = nil
                        }
                    }
                }
        }
    }
    
    @MainActor @ViewBuilder
    private func adjustItemView(viewModel: ProductAdjustmentViewModel) -> some View {
        ProductAdjustmentView(viewModel: viewModel)
    }
    
    @MainActor @ViewBuilder
    private var amountView: some View {
        HStack {
            Text("Amount")
            
            Spacer()
            
            TextField("Amount", value: $viewModel.amount, format: .shNumber)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .focused($focused)
                .submitLabel(.done)
                .onSubmit {
                    focused = false
                    viewModel.update()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 2)
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
                        viewModel.update()
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
                    Text("There is no item with id '\(itemID)'")
                }
                
                if recipe == nil {
                    Text("There is no recipe with id '\(recipeID)'")
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
