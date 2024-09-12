import SwiftUI
import TipKit
import SHSharedUI
import SHUtils

struct SingleItemCalculatorView: View {
    @State
    var viewModel: SingleItemCalculatorViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    
    @FocusState
    private var focused
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: horizontalSizeClass == .compact ? .leading : .center, spacing: 16, pinnedViews: .sectionHeaders) {
                ForEach(Array(viewModel.outputItemViewModels.enumerated()), id: \.element.id) { index, itemViewModel in
                    if index == 0 {
                        SingleItemCalculatorItemView(viewModel: itemViewModel)
                            .popoverTip(viewModel.autoSelectSingleRecipeTip, arrowEdge: .top)
                            .popoverTip(viewModel.autoSelectSinglePinnedRecipeTip, arrowEdge: .top)
                    } else {
                        SingleItemCalculatorItemView(viewModel: itemViewModel)
                    }
                    
                    if index != viewModel.outputItemViewModels.indices.last {
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.sh(.midnight), .sh(.midnight30)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 2 / displayScale)
                            .padding(.leading, 16)
                            .frame(
                                maxWidth: horizontalSizeClass == .compact ? .infinity : 600,
                                alignment: .leading
                            )
                    }
                }
            }
            .padding(.vertical, 16)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if horizontalSizeClass == .compact {
                AmountView(amount: $viewModel.amount, focused: $focused) {
                    viewModel.adjustNewAmount()
                    viewModel.update()
                }
                .disabled(viewModel.selectingByproduct)
            }
        }
        .navigationBarBackButtonHidden(!viewModel.canBeDismissedWithoutSaving || viewModel.selectingByproduct)
        .navigationTitle(viewModel.navigationTitle)
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
        .sheet(item: $viewModel.modalNavigationState) {
            if viewModel.dismissAfterProductionDeletion {
                dismiss()
            }
        } content: { state in
            sheetContentView(state: state)
        }
    }
    
    @MainActor @ViewBuilder
    private func selectInitialRecipeView(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel) -> some View {
        NavigationStack {
            SingleItemCalculatorInitialRecipeSelectionView(viewModel: viewModel)
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
                        viewModel.editProduction {
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
        
        ToolbarItemGroup(placement: .primaryAction) {
            Button("single-item-production-calculation-statistics", systemImage: "list.number") {
                viewModel.showStatistics()
            }
            .disabled(viewModel.selectingByproduct)
            
            Button(viewModel.saveProductionTitle) {
                viewModel.editProduction()
            }
            .bold()
            .disabled(viewModel.selectingByproduct)
        } label: {
            Label("general-manage", systemImage: "general-more")
        }
        
        if horizontalSizeClass == .regular {
            ToolbarItem(placement: .primaryAction) {
                AmountView(amount: $viewModel.amount, focused: $focused) {
                    viewModel.adjustNewAmount()
                    viewModel.update()
                }
                .disabled(viewModel.selectingByproduct)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func sheetContentView(state: SingleItemCalculatorViewModel.ModalNavigationState) -> some View {
        switch state {
        case let .selectInitialRecipeForItem(viewModel):
            selectInitialRecipeView(viewModel: viewModel)
            
        case let .adjustItem(viewModel):
            SingleItemCalculatorItemAdjustmentView(viewModel: viewModel)
            
        case let .editProduction(viewModel):
            EditProductionView(viewModel: viewModel)
            
        case let .statistics(viewModel):
            StatisticsView(viewModel: viewModel)
        }
    }
}

private struct AmountView: View {
    @Binding
    private var amount: Double
    
    @FocusState.Binding
    private var focused: Bool
    
    private var onSubmit: () -> Void
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.isEnabled)
    private var isEnabled
    
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    
    private var textFieldBackgroundStyle: AnyShapeStyle {
        if isEnabled {
            AnyShapeStyle(.background)
        } else {
            AnyShapeStyle(.background.secondary)
        }
    }
    
    private var textFieldForegroundStyle: AnyShapeStyle {
        if isEnabled {
            AnyShapeStyle(.primary)
        } else {
            AnyShapeStyle(.secondary)
        }
    }
    
    private var horizontalPadding: Double {
        if horizontalSizeClass == .compact {
            16
        } else {
            0
        }
    }
    
    private var verticalPadding: Double {
        if horizontalSizeClass == .compact {
            8
        } else {
            0
        }
    }
    
    private var backgroundStyle: AnyShapeStyle {
        if horizontalSizeClass == .compact {
            AnyShapeStyle(.background)
        } else {
            AnyShapeStyle(.clear)
        }
    }
    
    init(amount: Binding<Double>, focused: FocusState<Bool>.Binding, onSubmit: @escaping () -> Void) {
        _amount = amount
        _focused = focused
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        HStack {
            if horizontalSizeClass == .compact {
                Text("single-item-production-calculation-amount-title")
                
                Spacer()
            }
            
            TextField("single-item-production-calculation-amount-title", value: $amount, format: .shNumber())
                .multilineTextAlignment(.center)
                #if os(iOS)
                .keyboardType(.decimalPad)
                #endif
                .focused($focused)
                .submitLabel(.done)
                .onSubmit {
                    focused = false
                    onSubmit()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: 150)
                .background(textFieldBackgroundStyle, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                .foregroundStyle(textFieldForegroundStyle)
                .overlay(
                    .sh(focused ? .orange30 : .midnight30),
                    in: RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(lineWidth: 1.5)
                )
            
            ZStack {
                if focused {
                    Button {
                        focused = false
                        onSubmit()
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
        .padding(.horizontal, horizontalPadding)
        .padding([focused ? .vertical : .top], verticalPadding)
        .overlay(alignment: .top) {
            if horizontalSizeClass == .compact {
                Rectangle()
                    .foregroundStyle(.sh(.midnight))
                    .frame(height: 1 / displayScale)
            }
        }
        .background(backgroundStyle)
    }
}

#if DEBUG
import SHStorage
import SHModels

private struct _SingleItemCalculatorPreview: View {
    private let itemID: String
    private let item: (any Item)?
    
    private let recipeID: String
    private let recipe: Recipe?
    
    @State
    private var viewModel: SingleItemCalculatorViewModel?
    
    init(itemID: String, recipeID: String) {
        @Dependency(\.storageService)
        var storageService
        
        self.itemID = itemID
        self.recipeID = recipeID
        
        item = storageService.item(id: itemID)
        recipe = storageService.recipe(id: recipeID)
        
        if let item, let recipe {
            _viewModel = State(initialValue: SingleItemCalculatorViewModel(item: item, recipe: recipe))
        }
    }
    
    var body: some View {
        if let viewModel {
            NavigationStack {
                SingleItemCalculatorView(viewModel: viewModel)
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

#Preview("Calculator View") {
    _SingleItemCalculatorPreview(itemID: "part-plastic", recipeID: "recipe-alternate-recycled-plastic")
}
#endif
