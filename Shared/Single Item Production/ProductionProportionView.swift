import SwiftUI

struct ProductionProportionView: View {
    private enum ProductionProportionDisplay {
        case auto
        case fraction
        case fixed
    }
    
    @Binding
    var proportion: ProductionProportion
    
    @MainActor @State
    private var proportionDisplay: ProductionProportionDisplay
    
    @MainActor @State
    var fractionAmount: Double
    
    @MainActor @State
    var fixedAmount: Double
    
//    @State
//    private var isSelecting = false
    
    @State
    private var buttonWidth = 0.0
    
    @FocusState
    private var focusField: ProductionProportionTextfield.Field?
    
    @Namespace
    private var namespace
    
    @MainActor
    init(_ proportion: Binding<ProductionProportion>, totalAmount: Double) {
        self._proportion = proportion
        
        switch proportion.wrappedValue {
        case .auto:
            proportionDisplay = .auto
            fractionAmount = 100
            
        case let .fraction(fraction):
            proportionDisplay = .fraction
            fractionAmount = fraction * 100
            
        case .fixed:
            proportionDisplay = .fixed
            fractionAmount = 100
        }
        
        fixedAmount = totalAmount
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                ProductionProportionTextfield($fractionAmount, focus: $focusField, field: .fraction)
                    .opacity(proportionDisplay == .fraction ? 1.0 : 0.0)
                
                ProductionProportionTextfield($fixedAmount, focus: $focusField, field: .fixed)
                    .opacity(proportionDisplay == .fixed ? 1.0 : 0.0)
            }
            .frame(width: 100)
            
            if focusField != nil {
                Button {
                    focusField = nil
                } label: {
                    Image(systemName: "checkmark")
                        .frame(height: 20)
                }
                .buttonStyle(.shTinted)
                .transition(.scale.combined(with: .opacity))
            } else {
                Menu {
                    Picker("", selection: $proportionDisplay) {
                        Text("Automatically")
                            .tag(ProductionProportionDisplay.auto)
                        
                        Label("Percentage", systemImage: "percent")
                            .tag(ProductionProportionDisplay.fraction)
                        
                        Label("Amount", systemImage: "textformat.123")
                            .tag(ProductionProportionDisplay.fixed)
                    }
                } label: {
                    ZStack {
                        switch proportion {
                        case .auto:
                            Text("AUTO")
                                .fixedSize()
                        case .fraction:
                            Image(systemName: "percent")
                        case .fixed:
                            Image(systemName: "textformat.123")
                        }
                    }
                    .frame(height: 20)
                    .frame(minWidth: 50)
                }
                .menuStyle(.button)
                .buttonStyle(.shTinted)
                .tint(.sh(.midnight))
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.bouncy, value: focusField)
        .onChange(of: proportionDisplay) {
            update()
        }
        .onChange(of: fractionAmount) {
            update()
        }
        .onChange(of: fixedAmount) {
            update()
        }
    }

    @MainActor
    private func update() {
        switch proportionDisplay {
        case .auto:
            proportion = .auto
            
        case .fraction:
            proportion = .fraction(fractionAmount / 100)
            
        case .fixed:
            proportion = .fixed(fixedAmount)
        }
    }
}

private struct ProductionProportionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.footnote)
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .frame(width: 40)
            .padding(.horizontal, 4)
            .frame(height: 24)
    }
}

private extension ButtonStyle where Self == ProductionProportionButtonStyle {
    static var productionProportion: Self { ProductionProportionButtonStyle() }
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
            if isFocused {
                5.0
            } else {
                3.0
            }
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
        TextField("", value: $amount, format: .fractionFromZeroToFour)
            .multilineTextAlignment(.center)
            .keyboardType(.decimalPad)
            .submitLabel(.done)
            .onSubmit {
                focus.wrappedValue = nil
            }
            .focused(focus, equals: field)
            .foregroundStyle(foregroundStyle)
            .padding(.horizontal, 4)
            .frame(height: 28)
            .background {
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(backgroundStyle)
                    .shadow(
                        color: shadowColor,
                        radius: shadowRadius
                    )
            }
            .animation(.default, value: isFocused)
    }
}

#if DEBUG
private struct _ProductionProportionPreview: View {
    @State
    private var proportion: ProductionProportion
    
    init(_ proportion: ProductionProportion) {
        self.proportion = proportion
    }
    
    var body: some View {
        ProductionProportionView($proportion, totalAmount: 50)
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