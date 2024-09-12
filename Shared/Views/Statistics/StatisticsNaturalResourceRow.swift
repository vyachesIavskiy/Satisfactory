import SwiftUI
import SHModels
import SHSharedUI
import SHUtils

extension StatisticsView {
    struct NaturalResourceRow: View {
        var naturalResource: StatisticNaturalResource
        
        init(_ naturalResource: StatisticNaturalResource) {
            self.naturalResource = naturalResource
        }
        
        var body: some View {
            ListRow {
                ListRowIconItem(naturalResource.item)
            } label: {
                Text(naturalResource.item.localizedName)
                    .fontWeight(.semibold)
            } accessory: {
                Text(naturalResource.amount, format: .shNumber)
                    .font(.callout)
                    .foregroundStyle(.sh(.midnight))
            }
        }
    }
}

#if DEBUG
import SHStorage

private struct _NaturalResourceRowPreview: View {
    let naturalResource: StatisticNaturalResource
    
    init(itemID: String, amount: Double) {
        @Dependency(\.storageService)
        var storageService
        
        naturalResource = StatisticNaturalResource(item: storageService.item(id: itemID)!, amount: amount)
    }
    
    var body: some View {
        StatisticsView.NaturalResourceRow(naturalResource)
    }
}

#Preview {
    _NaturalResourceRowPreview(itemID: "part-iron-ore", amount: 120)
}
#endif
