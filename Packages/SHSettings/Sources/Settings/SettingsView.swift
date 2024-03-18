import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Picker("Item view style", selection: .constant(0)) {
                Text("Icon")
                    .tag(0)
                    
                Text("Row")
                    .tag(1)
            }
        }
    }
}

#Preview {
    SettingsView()
}
