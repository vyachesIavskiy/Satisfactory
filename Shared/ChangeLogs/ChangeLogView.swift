import SwiftUI

struct ChangeLogView: View {
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    let changeLog: ChangeLog
    
    init(_ changeLog: ChangeLog) {
        self.changeLog = changeLog
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                updateMessageSection
                                
                changeSection("change-log-important-section-name", changes: changeLog.changes[.important])
                changeSection("change-log-fixes-section-name", changes: changeLog.changes[.fix])
                changeSection("change-log-added-section-name", changes: changeLog.changes[.addition])
                changeSection("change-log-removed-section-name", changes: changeLog.changes[.removal])
                
                Spacer(minLength: 30)
            }
            .padding(.horizontal, 16)
        }
        .background(.sh(.midnight10))
        .navigationTitle(changeLog.version.title)
    }
    
    @MainActor @ViewBuilder
    private var updateMessageSection: some View {
        Text(changeLog.updateMessage)
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
    }
    
    @MainActor @ViewBuilder
    private func changeSection(_ title: LocalizedStringKey, changes: [ChangeLog.Change]) -> some View {
        if !changes.isEmpty {
            Section {
                VStack(spacing: 8) {
                    ForEach(Array(changes.enumerated()), id: \.element.id) { index, change in
                        (imageTextAttachment(for: change.changeType) + Text(change.log))
                            .font(.callout)
                            .foregroundStyle(.primary)
                            .padding(.vertical, 4)
                        
                        if index != changes.indices.last {
                            LinearGradient(
                                colors: [.sh(.midnight40), .sh(.gray10)],
                                startPoint: .leading,
                                endPoint: UnitPoint(x: 0.85, y: 0.5)
                            )
                            .frame(height: 2 / displayScale)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                }
                .padding(.vertical, 8)
                .background(.background, in: AngledRectangle(cornerRadius: 8))
            } header: {
                SHSectionHeader(title)
            }
        }
    }
    
    private func imageTextAttachment(for changeType: ChangeLog.Change.ChangeType) -> Text {
        let imageName = switch changeType {
        case .fix, .addition, .removal: "circle.fill"
        case .important: "exclamationmark.square.fill"
        }
        
        let gradient: Gradient = switch changeType {
        case .fix: Gradient(colors: [.sh(.blue50), .sh(.blue70)])
        case .addition: Gradient(colors: [.sh(.green50), .sh(.green70)])
        case .removal: Gradient(colors: [.sh(.red50), .sh(.red70)])
        case .important: Gradient(colors: [.sh(.orange50), .sh(.orange70)])
        }
        
        let image = Image(systemName: imageName)
        return Text("\(image)  ")
            .font(.footnote)
            .foregroundStyle(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#if DEBUG
#Preview("Change log") {
    NavigationStack {
        ChangeLogView(.previewValue)
    }
}
#endif
