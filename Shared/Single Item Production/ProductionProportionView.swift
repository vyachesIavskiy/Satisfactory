import SwiftUI
import SHSingleItemProduction
import SHUtils

@Observable
final class ProductionProportionViewModel {
    enum ProductionProportionDisplay {
        case auto
        case fraction
        case fixed
    }
    
    @MainActor @ObservationIgnored
    var proportionDisplay: ProductionProportionDisplay {
        didSet {
            update()
        }
    }
    
    @MainActor @ObservationIgnored
    var fractionAmount: Double
    
    @MainActor @ObservationIgnored
    var fixedAmount: Double
    
    @ObservationIgnored
    private var onChange: (SHProductionProportion) -> Void
    
    @MainActor
    init(
        proportion: SHProductionProportion,
        totalAmount: Double,
        numberOfRecipes: Int,
        onChange: @escaping (SHProductionProportion) -> Void
    ) {
        self.onChange = onChange
        switch proportion {
        case .auto:
            proportionDisplay = .auto
            fractionAmount = 100.0 / Double(numberOfRecipes)
            
        case let .fraction(fraction):
            proportionDisplay = .fraction
            fractionAmount = fraction * 100
            
        case .fixed:
            proportionDisplay = .fixed
            fractionAmount = 100.0 / Double(numberOfRecipes)
        }
        
        fixedAmount = totalAmount
    }
    
    @MainActor
    func update() {
        switch proportionDisplay {
        case .auto:
            onChange(.auto)
            
        case .fraction:
            onChange(.fraction(fractionAmount / 100))
            
        case .fixed:
            onChange(.fixed(fixedAmount))
        }
    }
}

struct ProductionProportionView: View {
    @State
    var viewModel: ProductionProportionViewModel
    
//    private enum ProductionProportionDisplay {
//        case auto
//        case fraction
//        case fixed
//    }
//    
//    @Binding
//    var proportion: SHProductionProportion
//    
//    @MainActor @State
//    private var proportionDisplay: ProductionProportionDisplay
//    
//    @MainActor @State
//    var fractionAmount: Double
//    
//    @MainActor @State
//    var fixedAmount: Double
    
    @FocusState
    private var focusField: ProductionProportionTextfield.Field?
    
//    @MainActor
//    init(_ proportion: Binding<SHProductionProportion>, totalAmount: Double) {
//        self._proportion = proportion
//        
//        switch proportion.wrappedValue {
//        case .auto:
//            proportionDisplay = .auto
//            fractionAmount = 100
//            
//        case let .fraction(fraction):
//            proportionDisplay = .fraction
//            fractionAmount = fraction * 100
//            
//        case .fixed:
//            proportionDisplay = .fixed
//            fractionAmount = 100
//        }
//        
//        fixedAmount = totalAmount
//    }
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                ProductionProportionTextfield(
                    $viewModel.fractionAmount,
                    focus: $focusField,
                    field: .fraction
                )
                .opacity(viewModel.proportionDisplay == .fraction ? 1.0 : 0.0)
                .onSubmit {
                    focusField = nil
                    viewModel.update()
                }
                .focused($focusField, equals: .fraction)
                
                ProductionProportionTextfield(
                    $viewModel.fixedAmount,
                    focus: $focusField,
                    field: .fixed
                )
                .opacity(viewModel.proportionDisplay == .fixed ? 1.0 : 0.0)
                .onSubmit {
                    focusField = nil
                    viewModel.update()
                }
                .focused($focusField, equals: .fixed)
            }
            .frame(width: 100)
            
            if focusField != nil {
                Button {
                    focusField = nil
                    viewModel.update()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .fontWeight(.medium)
                        .frame(height: 16)
                        .frame(minWidth: 32)
                }
                .buttonStyle(.shTinted)
                .transition(.scale.combined(with: .opacity))
            } else {
                Menu {
                    Picker("", selection: $viewModel.proportionDisplay) {
                        Text("Automatically")
                            .tag(ProductionProportionViewModel.ProductionProportionDisplay.auto)
                        
                        Label("Percentage", systemImage: "percent")
                            .tag(ProductionProportionViewModel.ProductionProportionDisplay.fraction)
                        
                        Label("Amount", systemImage: "textformat.123")
                            .tag(ProductionProportionViewModel.ProductionProportionDisplay.fixed)
                    }
                } label: {
                    ZStack {
                        switch viewModel.proportionDisplay {
                        case .auto:
                            Text("AUTO")
                                .font(.caption)
                                .fixedSize()
                        case .fraction:
                            Image(systemName: "percent")
                                .font(.caption)
                                .fontWeight(.medium)
                        case .fixed:
                            Image(systemName: "textformat.123")
                        }
                    }
                    .frame(height: 16)
                    .frame(minWidth: 32)
                }
                .menuStyle(.button)
                .buttonStyle(.shTinted)
                .tint(.sh(.midnight))
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: focusField)
    }
}

private struct ProductionProportionTextfield: View {
    enum Field {
        case fraction
        case fixed
    }
    
    @Binding
    private var amount: Double
    
    private var focus: FocusState<Field?>.Binding
    private let field: Field
    
    @Environment(\.isEnabled)
    private var isEnabled
    
    private var isFocused: Bool {
        focus.wrappedValue == field
    }
    
    private var foregroundStyle: some ShapeStyle {
        isEnabled ? .primary : .secondary
    }
    
    private var backgroundStyle: AnyShapeStyle {
        if isEnabled {
            AnyShapeStyle(.background)
        } else {
            AnyShapeStyle(.sh(.gray20))
        }
    }
    
    private var shadowColor: Color {
        if isEnabled {
            if isFocused {
                .sh(.orange)
            } else {
                .sh(.midnight)
            }
        } else {
            .clear
        }
    }
    
    private var shadowRadius: Double {
        if isEnabled {
            2.0
        } else {
            0.0
        }
    }
    
    init(_ amount: Binding<Double>, focus: FocusState<Field?>.Binding, field: Field) {
        self._amount = amount
        self.focus = focus
        self.field = field
    }
    
    var body: some View {
        TextField("", value: $amount, format: .shNumber)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .submitLabel(.done)
            .foregroundStyle(foregroundStyle)
            .padding(.horizontal, 4)
            .frame(height: 24)
            .background(.background, in: RoundedRectangle(cornerRadius: 4, style: .continuous))
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(shadowColor)
                    .blur(radius: shadowRadius)
            }
            .animation(.default, value: isFocused)
    }
}

#if DEBUG
import SHModels

private struct _ProductionProportionPreview: View {
    @State
    private var proportion: SHProductionProportion
    
    init(_ proportion: SHProductionProportion) {
        self.proportion = proportion
    }
    
    var body: some View {
        ProductionProportionView(
            viewModel: ProductionProportionViewModel(
                proportion: proportion,
                totalAmount: 50,
                numberOfRecipes: 1
            ) {
                proportion = $0
            }
        )
    }
}

#Preview("AUTO") {
    _ProductionProportionPreview(.auto)
}

#Preview("100 %") {
    _ProductionProportionPreview(.fraction(1.0))
}

#Preview("Fixed 50/50") {
    _ProductionProportionPreview(.fixed(50))
}

#Preview("50 %") {
    _ProductionProportionPreview(.fraction(0.5))
}

#Preview("Fixed 35/50") {
    _ProductionProportionPreview(.fixed(35))
}
#endif
