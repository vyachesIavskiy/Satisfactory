import SwiftUI

extension VerticalAlignment {
    private enum ItemAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[VerticalAlignment.center]
        }
    }
    
    static let itemAlignment = VerticalAlignment(ItemAlignment.self)
}

extension HorizontalAlignment {
    private enum RecipeArrowAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let recipeArrowAlignment = HorizontalAlignment(RecipeArrowAlignment.self)
}

struct RecipeViewV3: View {
    var recipe: Recipe
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .itemAlignment) {
                
                ItemGrid(items: recipe.input)
                
                Image(systemName: "arrowtriangle.right.fill")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                    .alignmentGuide(.itemAlignment) {
                        $0[VerticalAlignment.center]
                }
                
                HStack(alignment: .itemAlignment) {
                    ForEach(recipe.output) { output in
                        ItemViewV4(item: output.item, amount: output.amount)
                    }
                }
            }
        }
        .padding()
        .background(NeumorficView())
    }
}

extension Array where Element == Int {
    func split(indeciesInChunk: Int) -> [[Int]] {
        reduce(into: [[Int]]()) { result, value in
            if value % indeciesInChunk == 0 {
                result.append([])
            }
            
            result[result.endIndex - 1].append(value)
        }
    }
}

struct ItemGrid: View {
    var items: [Recipe.RecipePart]
    
    private var splits: [[Int]] {
        [Int](0..<items.count).split(indeciesInChunk: 2)
    }
    
    var numberOfRows: Int {
        items.count / 2 + items.count % 2
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(splits, id: \.self) { split in
                HStack(alignment: .itemAlignment) {
                    ForEach(split, id: \.self) { index in
                        ItemViewV4(item: self.items[index].item, amount: self.items[index].amount)
                    }
                }
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeViewV3(recipe: Storage.shared[partName: "Water"]!.recipes[0], isSelected: .constant(false))
            VStack(alignment: .recipeArrowAlignment) {
                ForEach(Storage.shared[partName: "Fuel"]!.recipes) { recipe in
                    RecipeViewV3(recipe: recipe, isSelected: .constant(.random()))
                }
            }
        }
        .padding(50)
        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        .previewLayout(.sizeThatFits)
    }
}
