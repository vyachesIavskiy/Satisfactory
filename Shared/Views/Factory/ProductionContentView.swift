import SwiftUI
import SHModels

struct ProductionContentView: View {
    let production: Production
    
    var body: some View {
        ZStack {
            switch production.content {
            case .singleItem:
                SingleItemCalculatorContainerView(production: production)
                
            case let .fromResources(content):
                EmptyView()
                
            case let .power(content):
                EmptyView()
            }
        }
    }
}
