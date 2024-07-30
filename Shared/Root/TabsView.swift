import SwiftUI

struct TabsView: View {
    @State
    var changeLogToShow = ChangeLog.latest
    
    @State
    var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NewProductionView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("New Production", systemImage: "hammer")
                }
                .tag(0)
            
            Text("Under construction")
                .tint(.sh(.orange))
                .font(.title)
                .tabItem {
                    if selectedTab == 1 {
                        Label("Factories", systemImage: "building.2.fill")
                    } else {
                        Label("Factories", systemImage: "building.2")
                            .environment(\.symbolVariants, .none)
                    }
                }
                .tag(1)

            SettingsView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .tint(.sh(.midnight))
        .sheet(item: $changeLogToShow) { changeLog in
            NavigationStack {
                ChangeLogView(changeLog, mode: .showOnLaunch)
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#if DEBUG
#Preview("Tabs view") {
    TabsView()
}
#endif
