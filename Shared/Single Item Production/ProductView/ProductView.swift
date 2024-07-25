import SwiftUI

struct ProductView: View {
    let viewModel: ProductViewModel
    var namespace: Namespace.ID
    
    private var nameID: String {
        if viewModel.product.recipes.count == 1 {
            "\(viewModel.product.recipes[0].id)_name"
        } else {
            "\(viewModel.product.item.id)_recipe_name"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if viewModel.product.recipes.count > 1 {
                    Text(viewModel.product.item.localizedName)
                        .font(.title3)
                } else {
                    Text(viewModel.product.recipes[0].recipe.localizedName)
                        .font(.headline)
                }
                
                Spacer()
                
                if viewModel.canAdjust {
                    Button {
                        viewModel.adjust()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.subheadline)
                    }
                    .buttonStyle(.shTinted)
                }
            }
            
            ForEach(viewModel.product.recipes) { recipe in
                VStack(alignment: .leading) {
                    if viewModel.product.recipes.count > 1 {
                        HStack {
                            Text(recipe.recipe.localizedName)
                            
                            Spacer()
                            
                            Group {
                                switch recipe.proportion {
                                case .auto:
                                    Text("AUTO")
                                    
                                case .fraction:
                                    Image(systemName: "percent")
                                    
                                case .fixed:
                                    Image(systemName: "123.rectangle")
                                }
                            }
                            .font(.footnote)
                        }
                        .font(.headline)
                    }
                    
                    SingleItemProductionRecipeSelectView(viewModel: viewModel.viewModel(for: recipe))
                }
            }
        }
        .padding(.vertical, viewModel.product.recipes.count > 1 ? 6 : 0)
    }
}
