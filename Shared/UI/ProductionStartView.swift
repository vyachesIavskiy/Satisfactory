//
//  ProductionStartView.swift
//  ProductionStartView
//
//  Created by Slava Nagornyak on 17.07.2021.
//

import SwiftUI

struct ProductionStartView: View {
    let item: Item
    
    @State private var amountToProducePerMinute = 1
    @State private var selectedRecipe: Recipe?
    
    var body: some View {
        VStack {
            HStack {
                ItemRow(item: item)
                
                Spacer()
                
                Text("\(amountToProducePerMinute) / min")
            }
            .padding(.horizontal, 20)
            
            Stepper("", value: $amountToProducePerMinute, in: 1...Int.max)
                .labelsHidden()
            
            RecipeSelectionView(item: item, selectedRecipe: $selectedRecipe)
                .fullScreenCover(item: $selectedRecipe) {
                    selectedRecipe = nil
                } content: { recipe in
                    RecipeCalculationView(item: item)
                }
        }
        .navigationTitle(item.name)
    }
}

struct ProductionStartPreview: PreviewProvider {
    static var previews: some View {
        ProductionStartView(item: Storage[partName: "Turbo Motor"]!)
    }
}
