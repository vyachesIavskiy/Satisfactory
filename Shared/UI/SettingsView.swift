import Combine
import SwiftUI
import Settings
import Models
import TCA

@Reducer
struct SettingsReducer {
    struct State: Equatable {
        var previewRecipe: RecipeFeature.State?
        
//        @BindingState var settings = Settings()
    }
    
    enum Action: Equatable, BindableAction {
        enum View: Equatable {
            case onAppear
        }
        
        case binding(BindingAction<State>)
        case view(View)
        
        // Scoped
        case recipe(RecipeFeature.Action)
    }
    
    @Dependency(\.storageClient.recipes) private var recipes
//    @Dependency(\.settingsClient) private var settingsClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
//            .onChange(of: \.settings) { _, newValue in
//                Reduce { state, action in
//                    return .run { _ in
////                        await settingsClient(newValue)
//                    }
//                }
//            }
        
        Reduce { state, action in
            switch action {
            case .view(let viewAction): 
                return reduceView(into: &state, action: viewAction)
                
            case .binding, .recipe:
                return .none
            }
        }
    }
    
    private func reduceView(into state: inout State, action: Action.View) -> Effect<Action> {
        switch action {
        case .onAppear:
//            state.previewRecipe = recipes()
//                .first { !$0.byproducts.isEmpty && $0.input.count > 2 }
//                .map { RecipeFeature.State(recipe: $0) }
            
//            state.settings = settingsClient()
//            return .assign(\.$settings, from: settingsClient.updates())
            return .none
        }
    }
}

struct SettingsView: View {
    struct ViewState: Equatable {
//        @BindingViewState var settings: Settings
        
        init(from state: BindingViewStore<SettingsReducer.State>) {
//            _settings = state.$settings
        }
    }
    
    private let store: StoreOf<SettingsReducer>
    
    @Environment(\.dismiss) private var dismiss
    
    init(store: StoreOf<SettingsReducer>) {
        self.store = store
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                WithViewStore(store, observe: ViewState.init) { viewStore in
                    List {
                        Section {
                            IfLetStore(store.scope(state: \.previewRecipe, action: \.recipe)) { store in
                                RecipeView(store: store)
                                    .frame(maxWidth: .infinity)
                            }
                        } header: {
                            VStack {
                                Text("Select item view style:")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Picker(selection: .constant(Settings.ItemViewStyle.icon)) {
                                    Text("Icon")
                                        .tag(Settings.ItemViewStyle.icon)
                                    
                                    Text("Row")
                                        .tag(Settings.ItemViewStyle.row)
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
                    .onAppear {
                        viewStore.send(.view(.onAppear))
                    }
                }
            }
        }
    }
    
    @ViewBuilder private var changesView: some View {
        Section("Change log") {
//            ForEach(Disclaimer.Version.validVersions, id: \.self) { version in
//                NavigationLink(versionTitle(for: version)) {
//                    DisclaimerViewContainer(Disclaimer[version], showOkButton: false)
//                }
//            }
        }
    }
    
//    private func versionTitle(for version: Disclaimer.Version) -> String {
//        switch version {
//        case .preview: return "Preview (should not be visible in production)"
//        case .v1_4: return "Version 1.4"
//        case .v1_5: return "Version 1.5"
//        case .v1_5_1: return "Version 1.5.1"
//        case .v1_6: return "Version 1.6"
//        case .v1_7: return "Version 1.7"
//        case .v1_7_1: return "Version 1.7.1"
//        }
//    }
}

struct SettingsPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: Store(initialState: SettingsReducer.State()) {
            SettingsReducer()
        })
    }
}

