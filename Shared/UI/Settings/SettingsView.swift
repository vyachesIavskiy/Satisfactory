import SwiftUI
import SHModels
import SHSettings

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
    @Bindable var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    recipeSection
                    
                    seasonalEventsSection
                    
                    changeLogSection
                    
                    feedbackSection
                }
                .frame(maxWidth: 600)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .safeAreaInset(edge: .bottom, spacing: 16) {
                    VStack {
                        if !Bundle.main.appVersion.isEmpty,
                           !Bundle.main.appBuildNumber.isEmpty {
                            Text("App version: \(Bundle.main.appVersion) (\(Bundle.main.appBuildNumber))")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                    }
                    .padding()
                }
            }
            
            if viewModel.feedbackResult == .sent {
                feedbackSentView
                    .zIndex(1)
                    .onTapGesture {
                        viewModel.feedbackResult = nil
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.default, value: viewModel.feedbackResult)
    }
    
    @ViewBuilder private var recipeSection: some View {
        Section("Items and recipes") {
            NavigationLink("View mode") {
                viewModePicker
                    .navigationTitle("View mode")
            }
            
            Toggle("Auto-select single recipe", isOn: $viewModel.settings.autoSelectSingleRecipe)
            
            Toggle("Auto-select single pinned recipe", isOn: $viewModel.settings.autoSelectSinglePinnedRecipe)
        }
    }
    
    @ViewBuilder
    private var viewModePicker: some View {
        VStack(spacing: 25) {
            Picker(selection: $viewModel.settings.viewMode) {
                Text("Icon")
                    .tag(ViewMode.icon)
                
                Text("Row")
                    .tag(ViewMode.row)
            } label: {
                Text("View mode")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: viewModel.recipe))
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var seasonalEventsSection: some View {
        Section("Seasonal events") {
            Toggle("FICSMAS", isOn: $viewModel.settings.showFICSMAS)
        }
    }
    
    @ViewBuilder private var changeLogSection: some View {
        Section {
            NavigationLink("Changes") {
                ChangelogsView()
            }
        }
    }
    
    @ViewBuilder
    private var feedbackSection: some View {
        Section {
            Button("Send feedback") {
                viewModel.showFeedback = true
            }
            .foregroundStyle(.background)
            .listRowBackground(Color("Primary"))
        }
        .sheet(isPresented: $viewModel.showFeedback) {
            FeedbackView(result: $viewModel.feedbackResult)
        }
    }
    
    @ViewBuilder
    private var feedbackSentView: some View {
        Text(
            """
            Thank you! We appreciate this very much!
            Every message helps us to make the app better. And now **YOU** are a part of this!
            """
        )
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
    }
}

#if DEBUG
#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
#endif
