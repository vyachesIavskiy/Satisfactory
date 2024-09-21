import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

struct WhatsNewFactoriesPage: View {
    @Dependency(\.storageService)
    private var storageService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            WhatsNewPageTitle("whats-new-factories-page-title")
            
            Spacer()
            
            WhatsNewPageSubtitle("whats-new-factories-page-subtitle")
            
            VStack(alignment: .leading, spacing: 16) {
                ListRowFactory(
                    Factory(
                        id: UUID(),
                        name: NSLocalizedString(
                            "whats-new-factories-legacy-factory-name",
                            comment: ""
                        ),
                        creationDate: Date(),
                        asset: .legacy,
                        productionIDs: [UUID(), UUID(), UUID()]
                    )
                )
                
                ListRowFactory(
                    Factory(
                        id: UUID(),
                        name: NSLocalizedString(
                            "whats-new-factories-starter-factory-name",
                            comment: ""
                        ),
                        creationDate: Date(),
                        asset: .abbreviation,
                        productionIDs: [UUID(), UUID()]
                    )
                )
                
                ListRowFactory(
                    Factory(
                        id: UUID(),
                        name: NSLocalizedString(
                            "whats-new-factories-steel-factory-name",
                            comment: ""
                        ),
                        creationDate: Date(),
                        asset: .assetCatalog(name: "part-encased-industrial-beam"),
                        productionIDs: [UUID(), UUID(), UUID(), UUID(), UUID()]
                    )
                )
            }
            
            WhatsNewPageFooter("whats-new-factories-page-footer")
                .foregroundStyle(.sh(.green70))
            
            Spacer()
            
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    WhatsNewFactoriesPage()
}
#endif
