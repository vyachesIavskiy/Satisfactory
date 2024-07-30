import UIKit
import SHStorage

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
        @Dependency(\.storageService)
        var storageService
        
        try? storageService.load()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
