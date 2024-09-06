import SwiftUI
import SHModels
import SHSharedUI

struct SingleItemCalculatorInitialRecipeSelectionView: View {
    @State
    var viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        List {
            ForEach($viewModel.sections) { $section in
                recipesSection($section)
            }
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
        }
        .environment(\.defaultMinListRowHeight, 2)
        .listStyle(.plain)
        .navigationTitle(viewModel.item.localizedName)
        .task {
            await viewModel.observeStorage()
        }
    }
    
    @MainActor @ViewBuilder
    private func recipesSection(_ _section: Binding<SingleItemCalculatorInitialRecipeSelectionViewModel.Section>) -> some View {
        let section = _section.wrappedValue
        if !section.recipes.isEmpty {
            Section(isExpanded: _section.expanded) {
                ForEach(section.recipes) { recipe in
                    recipeView(recipe)
                        .listRowInsets(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                    
                    if recipe != section.recipes.last {
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.sh(.midnight40), .sh(.gray10)],
                                startPoint: .leading,
                                endPoint: UnitPoint(x: 0.85, y: 0.5)
                            ))
                            .frame(height: 2 / displayScale)
                            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    }
                }
            } header: {
                if viewModel.sectionHeaderVisible(section) {
                    SectionHeader(section.title, expanded: _section.expanded)
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        .background(.background)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func recipeView(_ recipe: Recipe) -> some View {
        Button {
            viewModel.onRecipeSelected?(recipe)
        } label: {
            RecipeView(recipe)
                .contentShape(.interaction, Rectangle())
        }
        .buttonStyle(.plain)
        .contextMenu {
            if viewModel.pinsAllowed() {
                Button {
                    viewModel.changePinStatus(for: recipe)
                } label: {
                    if viewModel.isPinned(recipe) {
                        Label("general-unpin", systemImage: "pin.slash.fill")
                    } else {
                        Label("general-pin", systemImage: "pin.fill")
                    }
                }
            }
        }
    }
}

#if DEBUG
import SHStorage

private struct _SingleItemCalculatorInitialRecipeSelectionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        NavigationStack {
            if let item {
                SingleItemCalculatorInitialRecipeSelectionView(viewModel: SingleItemCalculatorInitialRecipeSelectionViewModel(item: item))
            } else {
                Text(verbatim: "There is no item with ID '\(itemID)'")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}

#Preview("Iron Ingot") {
    _SingleItemCalculatorInitialRecipeSelectionPreview(itemID: "part-iron-ingot")
}

#Preview("Reinforced Iron Plate") {
    _SingleItemCalculatorInitialRecipeSelectionPreview(itemID: "part-reinforced-iron-plate")
}
#endif
