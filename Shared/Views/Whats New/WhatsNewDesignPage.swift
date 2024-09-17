import SwiftUI
import SHSharedUI
import SHModels
import SHStorage

struct WhatsNewDesignPage: View {
    private let part: Part?
    private let recipe: Recipe?
    
    init() {
        @Dependency(\.storageService)
        var storageService
        
        part = storageService.part(id: "part-heavy-modular-frame")
        recipe = storageService.recipe(id: "recipe-alumina-solution")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            WhatsNewPageTitle("whats-new-design-page-title")
            
            Spacer()
            
            WhatsNewPageSubtitle("whats-new-design-page-subtitle")
            
            VStack(alignment: .leading, spacing: 48) {
                if let part {
                    ListRowItem(part)
                }
                
                if let recipe {
                    RecipeView(recipe)
                }
            }
            .geometryGroup()
            
            Spacer()
            
            Spacer()
        }
        .padding(20)
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    WhatsNewDesignPage()
}
#endif
