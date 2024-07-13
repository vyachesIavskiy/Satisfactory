import SwiftUI

struct ChangeLogView: View {
    enum Mode {
        case showOnLaunch
        case normal
    }
    
    let mode: Mode
    let changeLog: ChangeLog
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(_ changeLog: ChangeLog, mode: Mode) {
        self.changeLog = changeLog
        self.mode = mode
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                updateMessageSection
                
                whatsNewSection
                
                changeSection("Fixes", changes: changeLog.changes[.fix])
                changeSection("Important", changes: changeLog.changes[.important])
                changeSection("Added", changes: changeLog.changes[.addition])
                changeSection("Removed", changes: changeLog.changes[.removal])
            }
            .padding(.horizontal, 16)
        }
        .background(.sh(.midnight10))
        .safeAreaInset(edge: .top) {
            switch mode {
            case .normal:
                EmptyView()
                
            case .showOnLaunch:
                NavigationBar {
                    HStack {
                        Text("What's new in version \(changeLog.version.title)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button("OK") {
                            dismiss()
                        }
                        .buttonStyle(.toolbar(role: .confirm))
                    }
                }
            }
        }
        .navigationTitle("Version \(changeLog.version.title)")
        .interactiveDismissDisabled(mode == .showOnLaunch)
    }
    
    @MainActor @ViewBuilder
    private var updateMessageSection: some View {
        Text(changeLog.updateMessage)
            .font(.headline)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.background, in: AngledRectangle(cornerRadius: 8))
    }
    
    @MainActor @ViewBuilder
    private var whatsNewSection: some View {
        Text("What's changed:")
            .font(.largeTitle)
            .padding(.vertical, 12)
    }
    
    @MainActor @ViewBuilder
    private func changeSection(_ title: String, changes: [ChangeLog.Change]) -> some View {
        if !changes.isEmpty {
            Section {
                VStack(spacing: 8) {
                    ForEach(Array(changes.enumerated()), id: \.element.id) { index, change in
                        (imageTextAttachment(for: change.changeType) + Text(change.log))
                            .font(.callout)
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.background, in: AngledRectangle(cornerRadius: 8))
                }
            } header: {
                Text(title)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.sh(.midnight50))
            }
        }
    }
    
    private func imageTextAttachment(for changeType: ChangeLog.Change.ChangeType) -> Text {
        let imageName = switch changeType {
        case .fix, .addition, .removal: "circle.fill"
        case .important: "exclamationmark.square.fill"
        }
        
        let color: Color = switch changeType {
        case .fix: .sh(.blue70)
        case .addition: .sh(.green70)
        case .removal: .sh(.red70)
        case .important: .sh(.orange70)
        }
        
        let image = Image(systemName: imageName)
        return Text("\(image)  ")
            .font(.footnote)
            .foregroundStyle(color)
    }
}

#if DEBUG
#Preview("Change log") {
    ChangeLogView(.previewValue, mode: .normal)
}

#Preview("Change log (show on launch)") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            ChangeLogView(.previewValue, mode: .showOnLaunch)
        }
}
#endif
