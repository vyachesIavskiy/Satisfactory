import SwiftUI
import SHModels
import SHSettings

struct SettingsView: View {
    @State
    var viewModel = SettingsViewModel()
    
    @Namespace
    private var namespace
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    recipeSection
                    
                    seasonalEventsSection
                    
                    otherSection
                    
                    feedbackSection
                }
                .frame(maxWidth: 600)
                .navigationTitle("Settings")
            }
            .disabled(viewModel.feedbackResult != nil)
            
            if viewModel.feedbackResult == .sent {
                feedbackShaderView
                
                feedbackSentView
            }
        }
        .animation(.default, value: viewModel.feedbackResult)
    }
    
    @MainActor @ViewBuilder
    private var recipeSection: some View {
        Section("Recipes") {
            ZStack {
                let recipeViewModel = RecipeDisplayViewModel(recipe: viewModel.recipe)
                
                RecipeDisplayView(viewModel: recipeViewModel)
                    .showIngredientNames(true)
                    .hidden()
                
                RecipeDisplayView(viewModel: recipeViewModel)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Toggle("Show recipe ingredient names", isOn: $viewModel.settings.showIngredientNames)
                    .tint(.sh(.orange))
                
                Text("If it is difficult for you to distinguish recipe ingredients only by it's icon, you can enable this setting to also see recipe ingredient names.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Toggle("Auto-select single recipe", isOn: $viewModel.settings.autoSelectSingleRecipe)
                .tint(.sh(.orange))
            
            Toggle("Auto-select single pinned recipe", isOn: $viewModel.settings.autoSelectSinglePinnedRecipe)
                .tint(.sh(.orange))
        }
    }
    
    @MainActor @ViewBuilder
    private var seasonalEventsSection: some View {
        Section("Seasonal events") {
            Toggle("FICSMAS", isOn: $viewModel.settings.showFICSMAS)
                .tint(.sh(.orange))
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
    private var feedbackShaderView: some View {
        LinearGradient(
            colors: [.black.opacity(0.6), .black.opacity(0.4), .clear],
            startPoint: .bottom,
            endPoint: .top
        )
        .opacity(0.5)
        .ignoresSafeArea()
        .transition(.opacity.animation(.default.speed(0.75)))
        .contentShape(Rectangle())
        .zIndex(1)
        .onTapGesture {
            viewModel.feedbackResult = nil
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
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom)
        .onTapGesture {
            viewModel.feedbackResult = nil
        }
        .zIndex(2)
        .transition(.move(edge: .bottom))
    }
}

#if DEBUG
private struct _SettingsPreview: View {
    @State var viewModel = SettingsViewModel()

    var body: some View {
        SettingsView(viewModel: viewModel)
            .showIngredientNames(viewModel.settings.showIngredientNames)
    }
}

#Preview {
    _SettingsPreview()
}
#endif
