import SwiftUI

class Settings: ObservableObject {
    enum ItemViewStyle: String {
        case icon
        case row
    }
    
    @AppStorage("itemViewStyle") var itemViewStyle: ItemViewStyle = .icon
}

struct SettingsView: View {
    @EnvironmentObject var storage: BaseStorage
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Select item view style:")
                    
                    Picker(selection: settings.$itemViewStyle) {
                        Text("Icon").tag(Settings.ItemViewStyle.icon)
                        Text("Row").tag(Settings.ItemViewStyle.row)
                    } label: {
                        Label("Select item view style", systemImage: "")
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)
                
                RecipeView(recipe: storage[recipesFor: "heavy-modular-frame"][0])
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsPreviews: PreviewProvider {
    @State private static var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        SettingsView()
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}

