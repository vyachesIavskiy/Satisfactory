import SwiftUI
import SHModels
import SHSharedUI
import SHUtils

extension StatisticsView {
    struct NaturalResourceRow: View {
        let naturalResource: StatisticNaturalResource
        
        init(_ naturalResource: StatisticNaturalResource) {
            self.naturalResource = naturalResource
        }
        
        var body: some View {
            ListRow {
                ListRowIconItem(naturalResource.part)
            } label: {
                Text(naturalResource.part.localizedName)
                    .fontWeight(.medium)
            } accessory: {
                Text(naturalResource.amount, format: .shNumber())
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
    
    init(partID: String, amount: Double) {
        @Dependency(\.storageService)
        var storageService
        
        naturalResource = StatisticNaturalResource(part: part(id: partID), amount: amount)
    }
    
    var body: some View {
        StatisticsView.NaturalResourceRow(naturalResource)
    }
}

#Preview("Natural Resource") {
    _NaturalResourceRowPreview(partID: "part-iron-ore", amount: 120)
}
#endif
