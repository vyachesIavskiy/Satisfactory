import SwiftUI

struct RecipeCalculatorHeader: View {
    let item: Item
    @Binding var amount: Double
    @FocusState private var focusField: Int?
    
    var body: some View {
        HStack {
            ItemRow(item: item)
            
            Spacer()
            
            TextField("", value: $amount, format: .fractionFromZeroToFour)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .labelsHidden()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
                .focused($focusField, equals: 0)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        HStack {
                            Spacer()
                            
                            Button("Done") {
                                focusField = nil
                            }
                        }
                    }
                }
            
            Text("/ min")
                .fontWeight(.semibold)
        }
    }
}

struct RecipeCalculatorHeaderPreviews: PreviewProvider {
    private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        RecipeCalculatorHeader(item: storage[partID: "copper-sheet"]!, amount: .constant(34))
    }
}

