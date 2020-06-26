//
//  ItemRecipeView.swift
//  Satisfactory
//
//  Created by Vyacheslav Nagornyak on 01.06.2020.
//  Copyright © 2020 Vyacheslav Nagornyak. All rights reserved.
//

import SwiftUI

struct ItemRecipeViewV3: View {
    var item: Item
    
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(self.item.recipes) { recipe in
                    HStack {
                        RecipeViewV3(recipe: recipe, isSelected: .constant(false))
                            .padding(.horizontal)
                            .animation(.easeInOut)
                            .onTapGesture {
                                if self.selectedRecipe == recipe {
                                    self.selectedRecipe = nil
                                } else {
                                    self.selectedRecipe = recipe
                                }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .navigationBarTitle(item.name)
    }
}

struct ItemRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemRecipeViewV3(item: Storage.shared[partName: "Fuel"]!)
        }
    }
}
