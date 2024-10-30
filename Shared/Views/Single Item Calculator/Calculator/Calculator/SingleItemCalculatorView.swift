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
            LazyVStack(spacing: 16, pinnedViews: .sectionHeaders) {
                Section {
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
                } header: {
                    VStack(alignment: .leading) {
                        if horizontalSizeClass == .compact {
                            HStack(spacing: 0) {
                                Button("single-item-production-calculation-statistics", systemImage: "list.number") {
                                    viewModel.showStatistics()
                                }
                                .disabled(viewModel.selectingByproduct)
                                .frame(maxWidth: .infinity)
                                
                                if viewModel.hasSavedProduction {
                                    Button("single-item-production-info", systemImage: "info.square") {
                                        viewModel.editProduction()
                                    }
                                    .disabled(viewModel.selectingByproduct)
                                    .frame(maxWidth: .infinity)
                                }
                                
                                Button("general-save", systemImage: "square.and.arrow.down") {
                                    if viewModel.hasSavedProduction {
                                        viewModel.saveProductionContent()
                                    } else {
                                        viewModel.editProduction()
                                    }
                                }
                                .disabled(viewModel.selectingByproduct)
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.vertical, 8)
                            .background(.background)
                        }
                        
                        if viewModel.showHelp {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "info.square")
                                        .foregroundStyle(.tint)
                                    
                                    Text("help")
                                }
                                .fontWeight(.medium)
                                
                                Text("single-item-calculator-help-text")
                            }
                            .padding(.horizontal, 16)
                        }
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
        .id(viewModel.part.id)
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
                        if viewModel.hasSavedProduction {
                            viewModel.saveProductionContent()
                            dismiss()
                        } else {
                            viewModel.editProduction {
                                viewModel.saveProductionContent()
                                dismiss()
                            }
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
        
        if horizontalSizeClass == .regular {
            ToolbarItem(placement: .primaryAction) {
                AmountView(amount: $viewModel.amount, focused: $focused) {
                    viewModel.adjustNewAmount()
                    viewModel.update()
                }
                .disabled(viewModel.selectingByproduct)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("single-item-production-calculation-statistics", systemImage: "list.number") {
                    viewModel.showStatistics()
                }
                .disabled(viewModel.selectingByproduct)
            }
            
            if viewModel.hasSavedProduction {
                ToolbarItem(placement: .primaryAction) {
                    Button("single-item-production-info", systemImage: "info.square") {
                        viewModel.editProduction()
                    }
                    .disabled(viewModel.selectingByproduct)
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("general-save") {
                    if viewModel.hasSavedProduction {
                        viewModel.saveProductionContent()
                    } else {
                        viewModel.editProduction()
                    }
                }
                .disabled(viewModel.selectingByproduct)
            }
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button("help", systemImage: "info.bubble") {
                withAnimation(.bouncy) {
                    viewModel.showHelp.toggle()
                }
            }
            .disabled(viewModel.selectingByproduct)
        }
    }
    
    @MainActor @ViewBuilder
    private func sheetContentView(state: SingleItemCalculatorViewModel.ModalNavigationState) -> some View {
        switch state {
        case let .selectInitialRecipeForItem(viewModel):
            if #available(iOS 18, *) {
                selectInitialRecipeView(viewModel: viewModel)
                    .presentationSizing(.page)
            } else {
                selectInitialRecipeView(viewModel: viewModel)
            }
            
        case let .adjustItem(viewModel):
            if #available(iOS 18, *) {
                SingleItemCalculatorItemAdjustmentView(viewModel: viewModel)
                    .presentationSizing(.page)
            } else {
                SingleItemCalculatorItemAdjustmentView(viewModel: viewModel)
            }
            
        case let .editProduction(viewModel):
            EditProductionView(viewModel: viewModel)
            
        case let .statistics(viewModel):
            if #available(iOS 18, *) {
                StatisticsView(viewModel: viewModel)
                    .presentationSizing(.page)
            } else {
                StatisticsView(viewModel: viewModel)
            }
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
    
    private var textFieldMinWidth: CGFloat? {
        if horizontalSizeClass == .regular {
            150
        } else {
            nil
        }
    }
    
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
                .frame(minWidth: textFieldMinWidth, maxWidth: 150)
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
    private let partID: String
    private let part: Part?
    
    private let recipeID: String
    private let recipe: Recipe?
    
    @State
    private var viewModel: SingleItemCalculatorViewModel?
    
    init(partID: String, recipeID: String) {
        @Dependency(\.storageService)
        var storageService
        
        self.partID = partID
        self.recipeID = recipeID
        
        part = storageService.part(id: partID)
        recipe = storageService.recipe(id: recipeID)
        
        if let part, let recipe {
            _viewModel = State(initialValue: SingleItemCalculatorViewModel(part: part, recipe: recipe))
        }
    }
    
    var body: some View {
        if let viewModel {
            NavigationStack {
                SingleItemCalculatorView(viewModel: viewModel)
            }
        } else {
            VStack(spacing: 24) {
                if part == nil {
                    Text(verbatim: "There is no item with id '\(partID)'")
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
    NavigationStack {
        _SingleItemCalculatorPreview(partID: "part-plastic", recipeID: "recipe-alternate-recycled-plastic")
            .navigationBarTitleDisplayMode(.inline)
    }
}
#endif
