import SwiftUI

class Settings: ObservableObject {
    enum ItemViewStyle: String {
        case icon
        case row
    }
    
    @AppStorage("itemViewStyle")
    var itemViewStyle: ItemViewStyle = .icon
    
    @AppStorage("showWithoutRecipes")
    var showItemsWithoutRecipes = true
}

struct SettingsView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var settings: Settings
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    RecipeView(recipe: storage[recipesFor: "non-fissile-uranium"][0])
                        .frame(maxWidth: .infinity)
                } header: {
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
                    .padding(.bottom)
                }
                
                Section {
                    Toggle("Show items without recipes", isOn: $settings.showItemsWithoutRecipes)
                        .tint(Color("Factory Primary"))
                } footer: {
                    Text("Items without recipes \(settings.showItemsWithoutRecipes ? "will" : "will not") be visible in items list.")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }
            }
        }
    }
}

struct SettingsPreviews: PreviewProvider {
    @State private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        SettingsView()
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}

