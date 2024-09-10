import SwiftUI
import SHSharedUI
import SHUtils

struct ProportionView: View {
    @State
    var viewModel: ProportionViewModel
    
    @FocusState
    private var focusField: ProductionProportionTextfield.Field?
    
    @Namespace
    private var namespace
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                switch viewModel.proportionDisplay {
                case .auto:
                    EmptyView()
                    
                case .fraction:
                    ProductionProportionTextfield(
                        $viewModel.fractionAmount,
                        focus: $focusField,
                        field: .fraction
                    )
                    .onSubmit {
                        focusField = nil
                        viewModel.adjustFractionAmount()
                        viewModel.update()
                    }
                    .submitLabel(.done)
                    .focused($focusField, equals: .fraction)
                    .frame(width: 100)
                    
                case .fixed:
                    ProductionProportionTextfield(
                        $viewModel.fixedAmount,
                        focus: $focusField,
                        field: .fixed
                    )
                    .onSubmit {
                        focusField = nil
                        viewModel.adjustFixedAmount()
                        viewModel.update()
                    }
                    .submitLabel(.done)
                    .focused($focusField, equals: .fixed)
                    .frame(width: 100)
                }
            }
            
            if focusField != nil {
                Button {
                    switch focusField {
                    case .fraction: viewModel.adjustFractionAmount()
                    case .fixed: viewModel.adjustFixedAmount()
                    case nil: break
                    }
                    focusField = nil
                    viewModel.update()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.callout)
                        .fontWeight(.medium)
                        .frame(minWidth: 32)
                }
                .buttonStyle(.shBordered)
                .transition(.scale.combined(with: .opacity))
            } else {
                if let tip = viewModel.proportionTip {
                    menuButton
                        .popoverTip(tip, arrowEdge: .top)
                } else {
                    menuButton
                }
            }
        }
        .animation(.bouncy, value: focusField)
    }
    
    @ViewBuilder
    private var menuButton: some View {
        Menu {
            ControlGroup {
                Button("single-item-production-proportion-auto") {
                    viewModel.proportionDisplay = .auto
                }
                
                Button("single-item-production-proportion-percent") {
                    viewModel.proportionDisplay = .fraction
                }
                
                Button("single-item-production-proportion-fixed") {
                    viewModel.proportionDisplay = .fixed
                }
            }
            .controlGroupStyle(.compactMenu)
        } label: {
            ZStack {
                switch viewModel.proportionDisplay {
                case .auto:
                    Text("single-item-production-proportion-auto")
                case .fraction:
                    Text("single-item-production-proportion-percent")
                case .fixed:
                    Text("single-item-production-proportion-fixed")
                }
            }
            .font(.callout)
            .frame(minWidth: 32)
            .lineLimit(1)
        }
        .fixedSize()
        .menuStyle(.button)
        .buttonStyle(.shBordered)
        .tint(.sh(.midnight))
        .transition(.move(edge: .trailing).combined(with: .opacity))
        .matchedGeometryEffect(id: "proportion-menu", in: namespace)
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
    
    private var borderColor: Color {
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
    
    init(_ amount: Binding<Double>, focus: FocusState<Field?>.Binding, field: Field) {
        self._amount = amount
        self.focus = focus
        self.field = field
    }
    
    var body: some View {
        TextField("", value: $amount, format: .shNumber)
            .multilineTextAlignment(.center)
            #if os(iOS)
            .keyboardType(.decimalPad)
            #endif
            .submitLabel(.done)
            .foregroundStyle(foregroundStyle)
            .padding(.horizontal, 4)
            .frame(height: 28)
            .background {
                AngledRectangle(cornerRadius: 4)
                    .fill(backgroundStyle)
                    .stroke(borderColor, lineWidth: 1)
            }
            .animation(.default, value: isFocused)
    }
}

#if DEBUG
import SHModels

private struct _ProportionPreview: View {
    @State
    private var proportion: Proportion
    
    init(_ proportion: Proportion) {
        self.proportion = proportion
    }
    
    var body: some View {
        ProportionView(
            viewModel: ProportionViewModel(
                proportion: proportion,
                recipeAmount: 50,
                itemAmount: 50,
                showTip: true
            ) {
                proportion = $0
            }
        )
    }
}

#Preview("AUTO") {
    _ProportionPreview(.auto)
}

#Preview("100 %") {
    _ProportionPreview(.fraction(1.0))
}

#Preview("Fixed 50/50") {
    _ProportionPreview(.fixed(50))
}

#Preview("50 %") {
    _ProportionPreview(.fraction(0.5))
}

#Preview("Fixed 35/50") {
    _ProportionPreview(.fixed(35))
}
#endif
