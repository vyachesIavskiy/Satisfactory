import SwiftUI
import UIKit
import MessageUI

struct SendFeedbackView: UIViewControllerRepresentable {
    enum Result: Equatable {
        case cancelled
        case saved
        case sent
        case failed
    }
    
    @Binding var result: Result?
    
    @Environment(\.dismiss) private var dismiss
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        private var dismiss: DismissAction
        @Binding private var result: Result?
        
        init(dismiss: DismissAction, result: Binding<Result?>) {
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
            
            self.result = {
                switch result {
                case .cancelled: return .cancelled
                case .saved: return .saved
                case .sent: return .sent
                case .failed: return .failed
                @unknown default: return .failed
                }
            }()
            
            dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismiss: dismiss, result: $result)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.navigationBar.tintColor = UIColor(named: "Primary")
        
        vc.setToRecipients(["satisfactory.helper.app@gmail.com"])
        vc.setSubject("Feedback about Satisfactory Helper app v\(Bundle.main.appVersion)")
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
