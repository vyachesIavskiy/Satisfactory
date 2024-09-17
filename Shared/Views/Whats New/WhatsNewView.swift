import SwiftUI
import SHSharedUI
import SHModels
import SHStorage
import SHSingleItemCalculator

/// What's new screen presented on a first launch of the app when it's updated.
/// A new approach for what's new screen presents only the most recent what's new information with each update.
/// There is no way to re-visit this view anyhow other than on a first launch of the app.
/// Because of this this view can be completely static and can change it's layout with each new version.
struct WhatsNewView: View {
    private let finish: () -> Void
    
    @State
    private var page = Page.welcome
    
    @Namespace
    private var namespace
    
    @Dependency(\.storageService)
    private var storageService
    
    init(finish: @escaping () -> Void) {
        self.finish = finish
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.sh(.orange10), .sh(.midnight10), .sh(.cyan10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    Group {
                        switch page {
                        case .welcome: WhatsNewWelcomePage()
                        case .design: WhatsNewDesignPage()
                        case .calculator: WhatsNewCalculatorPage()
                        case .factories: WhatsNewFactoriesPage()
                        case .statistics: WhatsNewStatisticsPage()
                        }
                    }
                    .transition(.push(from: .trailing))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                buttons
            }
            .animation(.interpolatingSpring.speed(1.2), value: page)
        }
    }
    
    @ViewBuilder
    private var buttons: some View {
        Group {
            if page == .statistics {
                Button(action: finish) {
                    Text("general-close")
                        .font(.title2)
                        .frame(minWidth: 80)
                        .padding(.vertical, 2)
                }
                .matchedGeometryEffect(id: "button", in: namespace)
            } else {
                Button {
                    page.nextPage()
                } label: {
                    Text("general-next")
                        .font(.title2)
                        .frame(minWidth: 80)
                        .padding(.vertical, 2)
                }
                .matchedGeometryEffect(id: "button", in: namespace)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 40)
            }
        }
        .buttonStyle(.shBordered)
        .padding(.bottom, 20)
    }
}

extension WhatsNewView {
    enum Page {
        case welcome
        case design
        case calculator
        case factories
        case statistics
        
        mutating func nextPage() {
            self = switch self {
            case .welcome: .design
            case .design: .calculator
            case .calculator: .factories
            case .factories: .statistics
            case .statistics: .statistics
            }
        }
    }
}

#if DEBUG
#Preview("What's new") {
    WhatsNewView { }
}
#endif
