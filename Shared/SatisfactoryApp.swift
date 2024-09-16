import SwiftUI
import SHLogger
import SHSharedUI
import SHModels
import SHStorage
import TipKit

let logger = SHLogger(subsystemName: "Satisfactory Helper", category: "")

@main
struct SatisfactoryApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                #if canImport(UIKit)
                .onAppear {
                    UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = SHColor.orange.uiColor
                }
                #endif
            
//            FileManagerCheckView()
        }
    }
    
    init() {
        do {
            try Tips.configure([
                .datastoreLocation(.applicationDefault)
            ])
        } catch {
            print("Failed to initialize Tips with error: \(error)")
        }
    }
}

#if DEBUG
//private struct FileManagerCheckView: View {
//    class File: Identifiable {
//        let id = UUID()
//        var name: String
//        var data: Data?
//        var children: [File]?
//        
//        init(name: String, children: [File]? = nil) {
//            self.name = name
//            self.children = children
//        }
//    }
//    
//    struct FilePreview: Identifiable {
//        var name: String
//        var content: String
//        
//        var id: String { name }
//        
//        init(name: String, content: Data) {
//            self.name = name
//            self.content = String(data: content, encoding: .utf8) ?? ""
//        }
//    }
//    
//    struct FactoryListView: Identifiable, Hashable {
//        var id: UUID
//        var name: String
//        var children: [FactoryListView]?
//        
//        init(id: UUID, name: String, children: [FactoryListView]? = nil) {
//            self.id = id
//            self.name = name
//            self.children = children
//        }
//    }
//    
//    // File system
//    @State var legacyFiles = [File]()
//    @State var v2Files = [File]()
//    @State var fileToPreview: FilePreview?
//    
//    // Storage
//    @State var parts = [Part]()
//    @State var recipes = [Recipe]()
//    @State var factories = [FactoryListView]()
//    
//    @State var pinnedPartIDs = Set<String>()
//    @State var pinnedEquipmentIDs = Set<String>()
//    @State var pinnedRecipeIDs = Set<String>()
//    
//    @State var partsExpanded = true
//    @State var equipmentExpanded = true
//    @State var recipesExpanded = true
//    @State var factoriesExpanded = true
//    
////    @Dependency(\.storageClient) var storageClient
//    
//    var body: some View {
//        TabView {
//            NavigationStack {
//                List(legacyFiles, children: \.children) { file in
//                    if let data = file.data {
//                        Button(file.name) {
//                            fileToPreview = FilePreview(name: file.name, content: data)
//                        }
//                    } else {
//                        Text(file.name)
//                    }
//                }
//                .navigationTitle("Legacy File system")
//            }
//            .tabItem {
//                Label("Legacy File system", systemImage: "1.square")
//            }
//            
//            NavigationStack {
//                List(v2Files, children: \.children) { file in
//                    if let data = file.data {
//                        Button(file.name) {
//                            fileToPreview = FilePreview(name: file.name, content: data)
//                        }
//                    } else {
//                        Text(file.name)
//                    }
//                }
//                .navigationTitle("V2 File system")
//            }
//            .tabItem {
//                Label("V2 File system", systemImage: "2.square")
//            }
//            
//            NavigationStack {
//                List {
//                    Section("Parts", isExpanded: $partsExpanded) {
//                        ForEach(parts) { part in
//                            let isPinned = pinnedPartIDs.contains(part.id)
//                            
//                            HStack {
//                                Text(part.id)
//                                
//                                Spacer()
//                                
//                                if isPinned {
//                                    Image(systemName: "pin.square")
//                                }
//                            }
//                            .foregroundStyle(isPinned ? .orange : .primary)
//                        }
//                    }
//                    
//                    Section("Recipes", isExpanded: $recipesExpanded) {
//                        ForEach(recipes) { recipe in
//                            let isPinned = pinnedRecipeIDs.contains(recipe.id)
//                            
//                            HStack {
//                                Text(recipe.id)
//                                
//                                Spacer()
//                                
//                                if isPinned {
//                                    Image(systemName: "pin.square")
//                                }
//                            }
//                            .foregroundStyle(isPinned ? .orange : .primary)
//                        }
//                    }
//                    
//                    Section("Factories", isExpanded: $factoriesExpanded) {
//                        OutlineGroup(factories, children: \.children) { factory in
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text(factory.name)
//                                    
//                                    Text(factory.id.uuidString)
//                                        .font(.caption)
//                                        .foregroundStyle(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//                .listStyle(.sidebar)
//                .navigationTitle("Storage")
//            }
//            .tabItem {
//                Label("Storage", systemImage: "3.square")
//            }
//        }
////        .task {
////            for await pinnedPartIDs in storageClient.pinnedPartIDs() {
////                self.pinnedPartIDs = pinnedPartIDs
////            }
////        }
////        .task {
////            for await pinnedEquipmentIDs in storageClient.pinnedEquipmentIDs() {
////                self.pinnedEquipmentIDs = pinnedEquipmentIDs
////            }
////        }
////        .task {
////            for await pinnedRecipeIDs in storageClient.pinnedRecipeIDs() {
////                self.pinnedRecipeIDs = pinnedRecipeIDs
////            }
////        }
////        .task {
////            for await factories in storageClient.factories() {
////                self.factories = factories.map { factory in
////                    FactoryListView(id: factory.id, name: factory.name, children: factory.productions.map { production in
////                        FactoryListView(id: production.id, name: production.name)
////                    })
////                }
////            }
////        }
//        .onAppear {
//            load()
//        }
//        .overlay(alignment: .topTrailing) {
//            Button("Load storage") {
//                loadStorage()
//            }
//            .buttonStyle(.borderedProminent)
//            .padding(.trailing)
//        }
//        .sheet(item: $fileToPreview) { preview in
//            NavigationStack {
//                ScrollView {
//                    Text(preview.content)
//                        .fontDesign(.monospaced)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                        .padding()
//                }
//                .navigationTitle(preview.name)
//                #if os(iOS)
//                .navigationBarTitleDisplayMode(.inline)
//                #endif
//                .toolbar {
//                    ToolbarItem(placement: .cancellationAction) {
//                        Button("Cancel") {
//                            fileToPreview = nil
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    private func load() {
//        let baseURL = try! FileManager.default.url(
//            for: .documentDirectory,
//            in: .userDomainMask,
//            appropriateFor: nil,
//            create: true
//        )
//        
//        let names = try! FileManager.default.contentsOfDirectory(atPath: baseURL.path())
//        let files = names.map { File(name: $0) }
//        
//        for file in files {
//            addFiles(to: file, currentURL: baseURL)
//        }
//        
//        legacyFiles = files.sorted(using: KeyPathComparator(\.name))
//        v2Files = legacyFiles
//    }
//    
//    private func addFiles(to file: File, currentURL: URL) {
//        let newURL = currentURL.appending(path: file.name)
//        
//        guard let names = try? FileManager.default.contentsOfDirectory(atPath: newURL.path()) else {
//            file.data = try? Data(contentsOf: newURL)
//            
//            return
//        }
//        
//        let children = names.map { File(name: $0) }
//        
//        for child in children {
//            addFiles(to: child, currentURL: newURL)
//        }
//        
//        file.children = children.sorted(using: KeyPathComparator(\.name))
//    }
//    
//    private func loadV2Files() {
//        let baseURL = try! FileManager.default.url(
//            for: .documentDirectory,
//            in: .userDomainMask,
//            appropriateFor: nil,
//            create: true
//        )
//        
//        let names = try! FileManager.default.contentsOfDirectory(atPath: baseURL.path())
//        let files = names.map { File(name: $0) }
//        
//        for file in files {
//            addFiles(to: file, currentURL: baseURL)
//        }
//        
//        v2Files = files.sorted(using: KeyPathComparator(\.name))
//    }
//    
//    private func loadStorage() {
////        Task { @MainActor [storageClient] in
////            try await storageClient.load()
////            
////            parts = storageClient.parts()
////            equipment = storageClient.equipment()
////            recipes = storageClient.recipes()
////
////            loadV2Files()
////        }
//    }
//}
#endif
