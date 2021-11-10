import SwiftUI

struct ItemSelectionView: View {
    private let gridItem = GridItem(.adaptive(minimum: 100, maximum: 150), alignment: .top)
    var items: [Item] = Storage.shared.parts
    @State var selectedItems = [Item]()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [gridItem], spacing: 10) {
                ForEach(items, id: \.id) { item in
                    GridItemView(item: item)
                        .frame(alignment: .top)
                }
            }
        }
    }
}

struct GridItemView: View {
    var item: Item
    @State var isSelected = false
    
    var body: some View {
        VStack {
            Image(item.name)
                .resizable()
                .frame(width: 100, height: 100)
            Text(item.name)
                .multilineTextAlignment(.center)
        }
        .background(
            Color.green.opacity(isSelected ? 0.4 : 0)
                .cornerRadius(5)
        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct HeavyModularFrameItemTestView: View {
    var item: Item = Storage[partName: "Heavy Modular Frame"]!
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ProductionTestView(item: item)) {
                    VStack {
                        Image(item.name)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(item.name)
                    }
                }
            }
            .navigationTitle("Select item to produce")
        }
    }
}

struct ProductionTestView: View {
    var item: Item
    
    var body: some View {
        List(item.recipes) { recipe in
            Test2RecipeView(recipe: recipe)
        }
        .navigationTitle(item.name)
    }
}

struct Test2RecipeView: View {
    var recipe: Recipe
    
    let columns = [
        GridItem(.fixed(75), spacing: 10, alignment: .top),
        GridItem(.fixed(75), spacing: 10, alignment: .top)
    ]
    
    var body: some View {
        HStack(spacing: 20) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(recipe.input) { recipePart in
                    TestItemView(recipePart: recipePart)
                }
            }
            
            VStack {
                Image(systemName: "arrow.right.square.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                Text("\(recipe.duration) sec")
                    .font(.system(size: 12))
            }
            
            HStack(spacing: 10) {
                ForEach(recipe.output) { recipePart in
                    TestItemView(recipePart: recipePart)
                }
            }
        }
    }
}

struct TestItemView: View {
    var recipePart: Recipe.RecipePartOld
    
    var body: some View {
        ZStack(alignment: .init(horizontal: .trailing, vertical: .bottom)) {
            Image(recipePart.item.name)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(3)
            
            Text(recipePart.amount.string(with: ItemAmountNumberFormatter()) ?? "")
                .background(
                    Color("Factory Primary")
                        .frame(minWidth: 20, idealWidth: 20, minHeight: 20, idealHeight: 20)
                        .cornerRadius(5.0)
                )
        }
    }
}

struct HeavyModularFrameProductionTestViewPreviews: PreviewProvider {
    static var previews: some View {
        ProductionTestView(item: Storage[partName: "Heavy Modular Frame"]!)
            .frame(width: 200, height: 200)
    }
}
