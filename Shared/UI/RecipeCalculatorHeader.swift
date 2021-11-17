import SwiftUI

struct RecipeCalculatorHeader: View {
    let item: Item
    @Binding var amount: Double
    
    var body: some View {
        HStack {
            ItemRow(item: item)
            
            Spacer()
            
            TextField("", value: $amount, format: .fractionFromZeroToFour)
                .textFieldStyle(.roundedBorder)
                .labelsHidden()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
            
            Text("/ min")
                .fontWeight(.semibold)
        }
    }
}

struct RecipeCalculatorHeaderPreviews: PreviewProvider {
    private static var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        RecipeCalculatorHeader(item: storage[partID: "copper-sheet"]!, amount: .constant(34))
    }
}

