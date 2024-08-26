import SwiftUI

struct FactoryAssetCatalogView: View {
    @State
    private var viewModel = FactoryAssetCatalogViewModel()
    
    @Binding
    var selectedAssetName: String?
    
    @Environment(\.displayScale)
    private var displayScale
    
    private let gridItem = GridItem(.adaptive(minimum: 78), spacing: 8)
    
    var body: some View {
        ScrollViewReader { scroll in
            ScrollView {
                LazyVGrid(columns: [gridItem], pinnedViews: .sectionHeaders) {
                    ForEach($viewModel.sections) { $section in
                        Section(isExpanded: $section.expanded) {
                            ForEach(section.assetNames, id: \.self) { assetName in
                                iconView(for: assetName)
                                    .id(assetName)
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
                .animation(.spring.speed(2.5), value: selectedAssetName)
                .onAppear {
                    if let selectedAssetName = selectedAssetName {
                        scroll.scrollTo(selectedAssetName, anchor: .center)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
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
                if selectedAssetName == assetName {
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
                selectedAssetName = assetName
            }
    }
}

#if DEBUG
private struct _FactoryAssetCatalogPreview: View {
    @State
    private var selectedAssetName: String?
    
    init(selectedAssetName: String? = nil) {
        _selectedAssetName = State(initialValue: selectedAssetName)
    }
    
    var body: some View {
        FactoryAssetCatalogView(selectedAssetName: $selectedAssetName)
    }
}

#Preview("No selection") {
    _FactoryAssetCatalogPreview()
}

#Preview("Preselected") {
    _FactoryAssetCatalogPreview(selectedAssetName: "part-iron-plate")
}
#endif
