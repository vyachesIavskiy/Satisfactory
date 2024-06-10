import SwiftUI
import MessageUI

struct SendFeedbackButton: View {
    enum ButtonState: Equatable {
        case initial
        case loading
        case result
    }
    
    @State private var state = ButtonState.initial
    @State private var showSendFeedback = false
//    @State private var feedbackResult: SendFeedbackView.Result?
    
    private var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    var body: some View {
        Button {
            switch state {
            case .initial:
                state = .loading
                showSendFeedback = true
                
            case .loading:
                break
                
            case .result:
                state = .initial
            }
        } label: {
            Text("Send feedback")
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)
        }
        .buttonStyle(
            SendFeedbackButtonStyle(state: $state) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Feedback sent!")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.semibold)
                    
                    Text("Thank you! I appreciate this! Every message helps me making this app better. And now you are a part of this!")
                        .font(.system(.body, design: .rounded))
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        )
        .disabled(state == .loading)
        .sheet(isPresented: $showSendFeedback) {
            // Only real device can send email
            if canSendMail {
//                SendFeedbackView(result: $feedbackResult)
            } else {
                // On simulators or previews we will fake it
                HStack(spacing: 24) {
                    Button {
                        state = .initial
                        showSendFeedback = false
                    } label: {
                        Text("Cancel/Fail")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        state = .result
                        showSendFeedback = false
                    } label: {
                        Text("Sent")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
//        .onChange(of: feedbackResult) { newValue in
//            switch newValue {
//            case .sent:
//                state = .result
//                
//            default:
//                state = .initial
//            }
//        }
    }
}

private struct SendFeedbackButtonStyle<ResultView: View>: PrimitiveButtonStyle {
    @Binding private var state: SendFeedbackButton.ButtonState
    private let resultView: ResultView

    @State private var isPressing = false
    
    @Namespace private var namespace
    
    init(state: Binding<SendFeedbackButton.ButtonState>, @ViewBuilder result: () -> ResultView) {
        self._state = state
        self.resultView = result()
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            switch state {
            case .initial:
                configuration.label
                    .foregroundStyle(.white)
                    .opacity(isPressing ? 0.7 : 1)
                
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                
            case .result:
                resultView
                    .foregroundStyle(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 45)
        .background(.tint, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        .scaleEffect(isPressing ? 0.95 : 1)
        .animation(.default, value: isPressing)
        .animation(.default, value: state)
        ._onButtonGesture { isPressing in
            self.isPressing = isPressing
        } perform: {
            configuration.trigger()
        }
    }
}

struct SendFeedbackButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            
            SendFeedbackButton()
                .padding(.horizontal)
        }
    }
}
