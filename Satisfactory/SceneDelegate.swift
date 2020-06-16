import UIKit
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
//        let contentView = Home()
        let contentView = AllParts()
        
        window = UIWindow(windowScene: scene)
//        let controllers = [
//            PartsViewController().insideNavigation(),
//            EquipmentsViewController().insideNavigation(),
//            BuildingsViewController().insideNavigation()
//        ]
        window?.rootViewController = UIHostingController(rootView: contentView)
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

