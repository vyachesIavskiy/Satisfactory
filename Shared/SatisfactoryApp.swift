import SwiftUI
import TCA

@main
struct SatisfactoryApp: App {
    private let store: StoreOf<Root>
    @ObservedObject private var viewStore: ViewStore<Root.State, Root.Action.View>
    
    init() {
        self.store = Store(initialState: Root.State()) {
            Root()
        }
        self.viewStore = ViewStore(store, observe: { $0 }, send: Root.Action.view)
    }
    
    var body: some Scene {
        WindowGroup {
            IfLetStore(store.scope(state: \.main, action: Root.Action.main)) { store in
                MainTabBarView(store: store)
            } else: {
                ProgressView()
                    .progressViewStyle(.circular)
                    .task {
                        viewStore.send(.task)
                    }
            }
            
//            ToolbarTestView()
        }
    }
}

//struct StorageTestView: View {
//    @State private var filenames = [String]()
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading) {
//                ForEach(filenames, id: \.self) { filename in
//                    Text(filename)
//                }
//            }
//        }
//        .task {
//            do {
//                let documentsURL = try FileManager.default.url(
//                    for: .documentDirectory,
//                    in: .userDomainMask,
//                    appropriateFor: nil,
//                    create: true
//                )
//                
//                filenames = try FileManager.default
//                    .contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//                    .map(\.absoluteString)
//            } catch {
//                print(error)
//            }
//        }
//    }
//}

//#Preview {
//    StorageTestView()
//}

struct ToolbarTestView: View {
    @State var selection = 0
    @State var percentageValue = 50
    @State var amountValue = 1
    
    @Namespace var namespace
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            ZStack {
                TextField("", text: .constant("1"))
                    .textFieldStyle(.roundedBorder)
                    .hidden()
                    .frame(width: 0)
                    .disabled(true)
                
                if selection == 0 {
                    Text("Auto")
                        .frame(height: 24)
                        .matchedGeometryEffect(id: "auto", in: namespace)
                } else {
                    Button {
                        selection = 0
                    } label: {
                        Text("Auto")
                            .frame(height: 24)
                            .foregroundStyle(.background)
                            .matchedGeometryEffect(id: "auto", in: namespace)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 2)
            .background {
                if selection == 0 {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "auto_background", in: namespace)
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "auto_background", in: namespace)
                }
            }
            .padding(0.5)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            HStack(spacing: selection == 1 ? nil : 0) {
                if selection == 1 {
                    Image(systemName: "percent")
                        .frame(height: 24)
                        .matchedGeometryEffect(id: "percentage", in: namespace)
                    
                    TextField("Percentage", value: $percentageValue, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 50)
                        .disabled(selection != 1)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    Button {
                        selection = 1
                    } label: {
                        ZStack {
                            TextField("", text: .constant("1"))
                                .textFieldStyle(.roundedBorder)
                                .multilineTextAlignment(.center)
                                .hidden()
                                .frame(width: 0)
                                .disabled(true)
                            
                            Image(systemName: "percent")
                                .frame(height: 24)
                                .foregroundStyle(.background)
                                .matchedGeometryEffect(id: "percentage", in: namespace)
                        }
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing, selection == 1 ? 2 : nil)
            .padding(.vertical, 2)
            .background {
                if selection == 1 {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "percentage_background", in: namespace)
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "percentage_background", in: namespace)
                }
            }
            .padding(0.5)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            HStack(spacing: selection == 2 ? nil : 0) {
                if selection == 2 {
                    
                    Image(systemName: "textformat.123")
                        .frame(height: 24)
                        .matchedGeometryEffect(id: "amount", in: namespace)
                    
                    TextField("Amount", value: $amountValue, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 100)
                        .disabled(selection != 2)
                        .transition(.move(edge: .trailing))
                    
                } else {
                    Button {
                        selection = 2
                    } label: {
                        ZStack {
                            TextField("", text: .constant("1"))
                                .textFieldStyle(.roundedBorder)
                                .hidden()
                                .frame(width: 0)
                                .disabled(true)
                            
                            Image(systemName: "textformat.123")
                                .frame(height: 24)
                                .foregroundStyle(.background)
                                .matchedGeometryEffect(id: "amount", in: namespace)
                        }
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing, selection == 2 ? 2 : nil)
            .padding(.vertical, 2)
            .background {
                if selection == 2 {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "amount_background", in: namespace)
                } else {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(Color.accentColor)
                        .matchedGeometryEffect(id: "amount_background", in: namespace)
                }
            }
            .padding(0.5)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .buttonStyle(.plain)
        .frame(height: 24)
        .animation(.default, value: selection)
    }
}

#Preview {
    ToolbarTestView()
}
