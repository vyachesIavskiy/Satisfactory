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
        HStack(alignment: .firstTextBaseline) {
            switch change.changeType {
            case .addition, .removal:
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(color(for: change.changeType))
                    .brightness(-0.25)
                
            case .important:
                Image(systemName: "exclamationmark.square.fill")
                    .frame(width: 15)
                    .foregroundColor(.red)
                    .brightness(-0.25)
            }
            
            Text(change.log)
                .font(.system(.body, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .insideBubble()
    }
    
    private func color(for changeType: Disclaimer.Change.ChangeType) -> Color {
        switch changeType {
        case .addition: return .green
        case .removal: return .red
        case .important: return .clear
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
