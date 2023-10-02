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
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                List {
                    Section {
                        RecipeView(recipe: storage[recipesFor: "non-fissile-uranium"][0])
                            .frame(maxWidth: .infinity)
                    } header: {
                        VStack {
                            Text("Select item view style:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Picker(selection: settings.$itemViewStyle) {
                                Text("Icon").tag(Settings.ItemViewStyle.icon)
                                Text("Row").tag(Settings.ItemViewStyle.row)
                            } label: {
                                Label("Select item view style", systemImage: "")
                            }
                            .pickerStyle(.segmented)
                            .frame(maxWidth: 320)
                        }
                        .padding(.bottom)
                    }
                    
                    changesView
                }
                .frame(maxWidth: 600)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom, spacing: 16) {
                    VStack {
                        SendFeedbackButton()
                            .frame(maxWidth: 320)
                        
                        if !Bundle.main.appVersion.isEmpty,
                           !Bundle.main.appBuildNumber.isEmpty {
                            Text("App version: \(Bundle.main.appVersion) (\(Bundle.main.appBuildNumber))")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                    }
                    .padding([.horizontal, .bottom])
                    .frame(maxWidth: 600)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder private var changesView: some View {
        Section("Change log") {
            ForEach(Disclaimer.Version.validVersions, id: \.self) { version in
                NavigationLink(versionTitle(for: version)) {
                    DisclaimerViewContainer(Disclaimer[version], showOkButton: false)
                }
            }
        }
    }
    
    private func versionTitle(for version: Disclaimer.Version) -> String {
        switch version {
        case .preview: return "Preview (should not be visible in production)"
        case .v1_4: return "Version 1.4"
        case .v1_5: return "Version 1.5"
        case .v1_5_1: return "Version 1.5.1"
        case .v1_6: return "Version 1.6"
        case .v1_7: return "Version 1.7"
        case .v1_7_1: return "Version 1.7.1"
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

