import SwiftUI
import SHModels

struct ProductionView: View {
    @State
    var production: Production
    
    var body: some View {
        ZStack {
            switch production {
            case let .singleItem(production):
                SingleItemProductionView(production: production)
                
            case let .fromResources(production):
                EmptyView()
                
            case let .power(production):
                EmptyView()
            }
        }
    }
}
