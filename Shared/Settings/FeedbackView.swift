import SwiftUI
import UIKit
import MessageUI

struct FeedbackView: View {
    enum Result: Equatable {
        case cancelled
        case saved
        case sent
        case failed
    }
    
    @Binding 
    var result: Result?
    
    var body: some View {
        if EmailFeedbackView.canShow {
            EmailFeedbackView(result: $result)
        } else {
            // Fallback for simulators and previews
            DebugFeedbackView(result: $result)
        }
    }
}

private struct EmailFeedbackView: UIViewControllerRepresentable {
    @Binding 
    var result: FeedbackView.Result?
    
    @Environment(\.dismiss) 
    private var dismiss
    
    static var canShow: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        private var dismiss: DismissAction
        @Binding private var result: FeedbackView.Result?
        
        init(dismiss: DismissAction, result: Binding<FeedbackView.Result?>) {
            self.dismiss = dismiss
            self._result = result
        }
        
        func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            guard error == nil else {
                self.result = .failed
                dismiss()
                return
            }
            
            self.result = switch result {
            case .cancelled: .cancelled
            case .saved: .saved
            case .sent: .sent
            case .failed: .failed
            @unknown default: .failed
            }
            
            dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss, result: $result)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.navigationBar.tintColor = UIColor(named: "Colors/Orange/Orange - 60")
        
        vc.setToRecipients(["satisfactory.helper.app@gmail.com"])
        vc.setSubject("Feedback about Satisfactory Helper app v\(Bundle.main.appVersion)")
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

private struct DebugFeedbackView: View {
    @Binding 
    var result: FeedbackView.Result?
    
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        NavigationStack {
            Color.clear
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Send") {
                            result = .sent
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            result = .cancelled
                            dismiss()
                        }
                    }
                }
                .navigationTitle("Debug feedback")
        }
        .presentationDetents([.height(150)])
    }
}

#if DEBUG
private struct _DebugFeedbackPreview: View {
    @State 
    private var result: FeedbackView.Result?
    
    var body: some View {
        DebugFeedbackView(result: $result)
    }
}

#Preview("Debug feedback view") {
    _DebugFeedbackPreview()
}

#Preview("Debug feedback view (sheet)") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            _DebugFeedbackPreview()
        }
}
#endif
