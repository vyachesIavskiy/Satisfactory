import SHModels
import SwiftUI

struct ProductionAmountView: View {
    let item: any Item
    
    @Binding
    var amount: Double
    
    @FocusState
    private var focused
    
    init(item: any Item, amount: Binding<Double>) {
        self.item = item
        self._amount = amount
    }
    
    var body: some View {
        HStack {
            Text(item.localizedName)
            
            Spacer()
            
            HStack(spacing: 2) {
                TextField("Amount", value: $amount, format: .fractionFromZeroToFour)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                    .focused($focused)
                    .onSubmit {
                        focused = false
                    }
                
                if focused {
                    Button {
                        focused = false
                    } label: {
                        Image(systemName: "checkmark")
                            .symbolVariant(.circle.fill)
                            .controlSize(.large)
                            .foregroundStyle(.sh(.orange))
                    }
                    .bold()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                    .disabled(!focused)
                }
            }
            .padding(.leading, 4)
            .padding(.vertical, 2)
            .background(alignment: .bottom) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.sh(.midnight), .sh(.midnight10)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)
            }
            .frame(maxWidth: 150)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .animation(.default, value: focused)
    }
}

#if DEBUG
import SHStorage

private struct _ProductionAmountPreview: View {
    let itemID: String
    
    @State
    private var amount: Double
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: itemID)!
    }
    
    init(itemID: String, amount: Double) {
        self.itemID = itemID
        self.amount = amount
    }
    
    var body: some View {
        ProductionAmountView(item: item, amount: $amount)
            .border(.sh(.midnight))
    }
}

#Preview("1 Iron Plate") {
    _ProductionAmountPreview(itemID: "part-iron-plate", amount: 1.0)
}

#Preview("10 Reinforced Iron Plates") {
    _ProductionAmountPreview(itemID: "part-reinforced-iron-plate", amount: 10.0)
}

#Preview("100 Heavy Modular Frames") {
    _ProductionAmountPreview(itemID: "part-heavy-modular-frame", amount: 100.0)
}
#endif
