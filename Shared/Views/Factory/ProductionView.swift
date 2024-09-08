import SwiftUI
import SHModels

struct ProductionView: View {
    let production: Production
    
    var body: some View {
        ZStack {
            switch production {
            case let .singleItem(production):
                SingleItemCalculatorContainerView(production: production)
                
            case let .fromResources(production):
                EmptyView()
                
            case let .power(production):
                EmptyView()
            }
        }
    }
}
