import SwiftUI

@main
struct SatisfactoryApp: App {
    @State private var isLoaded = false
//    @StateObject private var storage: Storage = Storage()
    
    var body: some Scene {
        WindowGroup {
//            Group {
//                if isLoaded {
//                    ContentView()
//                } else {
//                    LoadingView(isLoaded: $isLoaded)
//                }
//            }
//            .environmentObject(storage)
//            .environmentObject(Settings())
            StorageTestView()
        }
    }
}

struct StorageTestView: View {
    @State private var filenames = [String]()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(filenames, id: \.self) { filename in
                    Text(filename)
                }
            }
        }
        .task {
            do {
                let documentsURL = try FileManager.default.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )
                
                filenames = try FileManager.default
                    .contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                    .map(\.absoluteString)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    StorageTestView()
}
