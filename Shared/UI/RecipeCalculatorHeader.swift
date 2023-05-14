import SwiftUI

struct RecipeCalculatorHeader: View {
    let item: Item
    @Binding var amount: Double
    @FocusState private var focused: Bool
    
    var body: some View {
        HStack {
            ItemRow(item: item)
            
            Spacer()
            
            TextField("", value: $amount, format: .fractionFromZeroToFour)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .labelsHidden()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
                .focused($focused)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if focused {
                            Button("Done") {
                                focused = false
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
        NavigationView {
            RecipeCalculatorHeader(item: storage[partID: "copper-sheet"]!, amount: .constant(34))
                .environmentObject(storage)
                .navigationTitle("Preview")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

