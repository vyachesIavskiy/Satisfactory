import SwiftUI
import SHStorage

@Observable
final class NewFactoryAssetCatalogViewModel {
    // MARK: Ignored properties
    
    // MARK: Observed properties
    var sections = [Section]()
    var selectedAssetName: String?
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init() {
        buildSections()
    }
    
    private func buildSections() {
        let parts = storageService.parts()
        let equipment = storageService.equipment()
        let buildings = storageService.buildings()
        
        sections = [
            Section(id: .parts, assetNames: parts.map(\.id)),
            Section(id: .equipment, assetNames: equipment.map(\.id)),
            Section(id: .buildings, assetNames: buildings.map(\.id))
        ]
    }
}

extension NewFactoryAssetCatalogViewModel {
    struct Section: Identifiable {
        enum ID {
            case parts
            case equipment
            case buildings
        }
        
        let id: ID
        var assetNames: [String]
        var expanded = true
        
        var name: String {
            switch id {
            case .parts: "Parts"
            case .equipment: "Equipment"
            case .buildings: "Buildings"
            }
        }
    }
}

struct NewFactoryAssetCatalogView: View {
    @State
    private var viewModel = NewFactoryAssetCatalogViewModel()
    
    @Binding
    var selectedAssetName: String?
    
    @Environment(\.displayScale)
    private var displayScale
    
    private let gridItem = GridItem(.adaptive(minimum: 78), spacing: 8)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem], pinnedViews: .sectionHeaders) {
                ForEach($viewModel.sections) { $section in
                    Section(isExpanded: $section.expanded) {
                        ForEach(section.assetNames, id: \.self) { assetName in
                            iconView(for: assetName)
                        }
                    } header: {
                        SHSectionHeader(section.name, expanded: $section.expanded)
                            .padding(.top, 8)
                            .padding(.bottom, 4)
                            .background(.background)
                    }
                }
            }
            .padding(.horizontal, 20)
            .animation(.spring.speed(2.5), value: viewModel.selectedAssetName)
        }
        .onChange(of: viewModel.selectedAssetName) {
            selectedAssetName = viewModel.selectedAssetName
        }
    }
    
    @MainActor @ViewBuilder
    private func iconView(for assetName: String) -> some View {
        Image(assetName)
            .resizable()
            .frame(width: 60, height: 60)
            .padding(9)
            .background {
                AngledRectangle(cornerRadius: 6)
                    .fill(.sh(.gray20))
                    .stroke(.sh(.midnight40), lineWidth: 3 / displayScale)
            }
            .overlay {
                if viewModel.selectedAssetName == assetName {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.footnote)
                        .foregroundStyle(.sh(.orange))
                        .padding(1 / displayScale)
                        .background(.background, in: Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(2)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.selectedAssetName = assetName
            }
    }
}

#Preview {
    NewFactoryAssetCatalogView(selectedAssetName: .constant(nil))
}
