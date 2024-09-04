import SwiftUI
import SHModels
import SHSingleItemCalculatorUI

struct ProductionView: View {
    @State
    var production: Production
    
    var body: some View {
        ZStack {
            switch production {
            case let .singleItem(production):
                SHSingleItemCalculator.editProduction(production)
                
            case let .fromResources(production):
                EmptyView()
                
            case let .power(production):
                EmptyView()
            }
        }
    }
}
