import UIKit

final class MainTabBarController: TabBarController {
    override init() {
        super.init()
        
        setViewControllers([ListViewController().insideNavigation(), ListViewController()], animated: false)
        
        
    }
}
