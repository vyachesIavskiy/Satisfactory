import SwiftUI
import SHSharedUI
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
                    
//                    seasonalEventsSection
                    
                    otherSection
                    
                    feedbackSection
                }
                .navigationTitle("settings-navigation-title")
            }
            #if canImport(UIKit)
            .disabled(viewModel.feedbackResult == .sent)
            #endif
            
            #if canImport(UIKit)
            if viewModel.feedbackResult == .sent {
                feedbackShaderView
                
                feedbackSentView
            }
            #endif
        }
        #if canImport(UIKit)
        .animation(.default, value: viewModel.feedbackResult)
        #endif
    }
    
    @MainActor @ViewBuilder
    private var recipeSection: some View {
        Section("settings-recipes-section-name") {
            ZStack {
                RecipeView(viewModel.recipe)
                    .showIngredientNames(true)
                    .hidden()
                
                RecipeView(viewModel.recipe)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Toggle(
                    "settings-recipe-section-show-ingredient-names",
                    isOn: $viewModel.settings.showIngredientNames
                )
                .tint(.sh(.orange))
                
                Text("settings-recipe-section-show-ingredient-names-explanation")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Toggle(
                "settings-recipe-section-auto-select-single-recipe",
                isOn: $viewModel.settings.autoSelectSingleRecipe
            )
            .tint(.sh(.orange))
            
            Toggle(
                "settings-recipe-section-auto-select-pinned-recipe",
                isOn: $viewModel.settings.autoSelectSinglePinnedRecipe
            )
            .tint(.sh(.orange))
        }
    }
    
    @MainActor @ViewBuilder
    private var seasonalEventsSection: some View {
        Section("settings-seasonal-events-section-name") {
            Toggle("settings-seasonal-events-section-ficsmas", isOn: $viewModel.settings.showFICSMAS)
                .tint(.sh(.orange))
        }
    }
    
    @MainActor @ViewBuilder
    private var otherSection: some View {
        Section {
            NavigationLink("settings-other-section-changes") {
                ChangeLogsView()
            }
            
            NavigationLink("settings-other-section-app-info") {
                AppInfoView()
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var feedbackSection: some View {
        #if canImport(UIKit)
        Section {
            Button {
                viewModel.showFeedback = true
            } label: {
                Text("settings-feedback-section-send-feedback")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.background)
            }
            .listRowBackground(Color.sh(.orange))
        }
        .sheet(isPresented: $viewModel.showFeedback) {
            FeedbackView(result: $viewModel.feedbackResult)
        }
        #endif
    }
    
    @MainActor @ViewBuilder
    private var feedbackShaderView: some View {
        #if canImport(UIKit)
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
        #endif
    }
    
    @MainActor @ViewBuilder
    private var feedbackSentView: some View {
        Text("settings-feedback-sent-message")
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 12))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom)
            #if canImport(UIKit)
            .onTapGesture {
                viewModel.feedbackResult = nil
            }
            #endif
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
