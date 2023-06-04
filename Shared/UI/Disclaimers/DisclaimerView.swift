import SwiftUI

struct DisclaimerView: View {
    var disclaimer: Disclaimer
    
    var body: some View {
        VStack(alignment: .leading) {
            updateMessageView(disclaimer.updateMessage)
            
            Text("What's changed:")
                .font(.system(size: 30, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Group {
                changeSectionView("Fixes:", changes: disclaimer.changes[.fix])
                changeSectionView("Important:", changes: disclaimer.changes[.important])
                changeSectionView("Added:", changes: disclaimer.changes[.addition])
                changeSectionView("Removed:", changes: disclaimer.changes[.removal])
            }
            .padding(.horizontal)
        }
    }
    
    init(_ disclaimer: Disclaimer) {
        self.disclaimer = disclaimer
    }
    
    @ViewBuilder private func updateMessageView(_ updateMessage: LocalizedStringKey) -> some View {
        Text(disclaimer.updateMessage)
            .frame(maxWidth: .infinity, alignment: .leading)
            .insideBubble()
            .padding(.horizontal)
            .font(.system(.body, design: .rounded))
    }
    
    @ViewBuilder private func changeSectionView(_ title: LocalizedStringKey, changes: [Disclaimer.Change]) -> some View {
        if !changes.isEmpty {
            Text(title)
                .font(.system(size: 23, design: .rounded))
                .padding(.top, 8)
            
            ForEach(changes) { change in
                changeView(change)
            }
        }
    }
    
    @ViewBuilder private func changeView(_ change: Disclaimer.Change) -> some View {
        (Text("\(Image(systemName: imageName(for: change.changeType)))\t")
            .foregroundColor(color(for: change.changeType)) + Text(change.log))
        .font(.system(.body, design: .rounded))
        .brightness(-0.15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .insideBubble()
    }
    
    private func imageName(for changeType: Disclaimer.Change.ChangeType) -> String {
        switch changeType {
        case .fix, .addition, .removal: return "circle.fill"
        case .important: return "exclamationmark.square.fill"
        }
    }
    
    private func color(for changeType: Disclaimer.Change.ChangeType) -> Color {
        switch changeType {
        case .fix: return .blue
        case .addition: return .green
        case .removal, .important: return .red
        }
    }
}

struct DisclaimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            DisclaimerView(.previewValue)
        }
    }
}
