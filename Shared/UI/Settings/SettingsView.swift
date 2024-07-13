import SwiftUI
import SHModels
import SHSettings

struct SettingsView: View {
    @Bindable 
    var viewModel: SettingsViewModel
    
    @Namespace
    private var namespace
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    viewModeSection
                    
                    recipeSection
                    
                    seasonalEventsSection
                    
                    otherSection
                    
                    feedbackSection
                }
                .frame(maxWidth: 600)
                .navigationTitle("Settings")
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
    
    @MainActor @ViewBuilder
    private var viewModeSection: some View {
        Section {
            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: viewModel.recipe))
        } header: {
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
            .padding(.bottom, 8)
            .textCase(nil)
        }
    }
    
    @MainActor @ViewBuilder
    private var recipeSection: some View {
        Section("Recipes") {
            Toggle("Auto-select single recipe", isOn: $viewModel.settings.autoSelectSingleRecipe)
            
            Toggle("Auto-select single pinned recipe", isOn: $viewModel.settings.autoSelectSinglePinnedRecipe)
        }
    }
    
    @MainActor @ViewBuilder
    private var seasonalEventsSection: some View {
        Section("Seasonal events") {
            Toggle("FICSMAS", isOn: $viewModel.settings.showFICSMAS)
        }
    }
    
    @MainActor @ViewBuilder
    private var otherSection: some View {
        Section {
            NavigationLink("Changes") {
                ChangeLogsView()
            }
            
            NavigationLink("App Info") {
                AppInfoView()
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var feedbackSection: some View {
        Section {
            Button {
                viewModel.showFeedback = true
            } label: {
                Text("Send feedback")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.background)
            }
            .listRowBackground(Color.sh(.orange))
        }
        .sheet(isPresented: $viewModel.showFeedback) {
            FeedbackView(result: $viewModel.feedbackResult)
        }
    }
    
    @MainActor @ViewBuilder
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
private struct _SettingsPreview: View {
    @Bindable var viewModel = SettingsViewModel()

    var body: some View {
        SettingsView(viewModel: viewModel)
            .viewMode(viewModel.settings.viewMode)
    }
}

#Preview {
    _SettingsPreview()
}
#endif
