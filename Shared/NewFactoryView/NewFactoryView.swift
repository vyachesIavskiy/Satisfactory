import SwiftUI
import SHStorage
import SHModels

@Observable
final class NewFactoryViewModel {
    // MARK: Ignored properties
    
    // MARK: Observed properties
    var factoryName = ""
    var provideAssetImage = false {
        didSet {
            selectedAssetName = nil
        }
    }
    var selectedAssetName: String?
    
    var saveDisabled: Bool {
        factoryName.isEmpty
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    func saveFactory() {
        let asset: Asset = if provideAssetImage, let selectedAssetName {
            .assetCatalog(name: selectedAssetName)
        } else {
            .abbreviation
        }
        
        let factory = Factory(
            id: UUID(),
            name: factoryName,
            asset: asset,
            productionIDs: []
        )
        
        storageService.saveFactory(factory)
    }
}

extension NewFactoryViewModel {
    enum AssetType {
        case assetCatalog
        case abbreviation
    }
}

struct NewFactoryView: View {
    @State
    private var viewModel = NewFactoryViewModel()
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    iconView
                    
                    ZStack {
                        TextField("Factory name", text: $viewModel.factoryName)
                            .submitLabel(.done)
                        
                        LinearGradient(
                            colors: [.sh(.midnight40), .sh(.gray10)],
                            startPoint: .leading,
                            endPoint: UnitPoint(x: 0.85, y: 0.5)
                        )
                        .frame(height: 2 / displayScale)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                
                Toggle("Provide image", isOn: $viewModel.provideAssetImage)
                    .font(.title3)
                    .tint(.sh(.orange))
                    .padding(.horizontal, 20)
                
                if viewModel.provideAssetImage {
                    NewFactoryAssetCatalogView(selectedAssetName: $viewModel.selectedAssetName)
                        .transition(.move(edge: .bottom).combined(with: .offset(y: 50)))
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.spring.speed(2), value: viewModel.provideAssetImage)
            .navigationTitle("New Factory")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveFactory()
                        dismiss()
                    }
                    .disabled(viewModel.saveDisabled)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        Group {
            if viewModel.provideAssetImage, let selectedAssetName = viewModel.selectedAssetName {
                Image(selectedAssetName)
                    .resizable()
            } else if !viewModel.factoryName.isEmpty {
                Text(viewModel.factoryName.abbreviated())
            } else {
                Image(systemName: "questionmark")
            }
        }
        .font(.title)
        .foregroundStyle(.sh(.midnight50))
        .frame(width: 40, height: 40)
        .padding(6)
        .background {
            AngledRectangle(cornerRadius: 6)
                .fill(.sh(.gray20))
                .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
        }
    }
}

#if DEBUG
#Preview {
    NewFactoryView()
}
#endif
