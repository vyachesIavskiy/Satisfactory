import SwiftUI
import Models
import TCA

private struct DummyItem: Item {
    let id = "Dummy"
    let category = Category.special
}

extension ItemRow {
    struct ViewState {
        let item: any Item
        let productions: [Production]
        let showAmountOfProductions: Bool
        
        var amountOfProductions: Int { productions.count }
        
        init(state: Void) {
            item = DummyItem()
            productions = []
            showAmountOfProductions = false
        }
    }
}

extension ItemRow.ViewState: Equatable {
    static func == (lhs: ItemRow.ViewState, rhs: ItemRow.ViewState) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.productions == rhs.productions &&
        lhs.showAmountOfProductions == rhs.showAmountOfProductions
    }
}

struct ItemRow: View {
    private var viewStore: ViewStore<ViewState, Void>
    
    init(store: Store<Void, Void>) {
        viewStore = ViewStore(store, observe: ViewState.init(state:))
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(viewStore.item.id)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(viewStore.item.localizedName)
            
            Spacer()
            
            if !viewStore.productions.isEmpty, viewStore.showAmountOfProductions {
                HStack(spacing: 2) {
                    Text(viewStore.amountOfProductions, format: .number)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "scale.3d")
                }
                .foregroundColor(.white)
                .padding(3)
                .background(Color.orange)
                .cornerRadius(6)
            }
        }
    }
}

#Preview("Dummy item") {
    let store = Store<Void, Void>(initialState: ()) {
        EmptyReducer()
    }
    
    return ItemRow(store: store)
}
