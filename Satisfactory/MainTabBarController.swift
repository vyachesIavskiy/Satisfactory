import UIKit

final class MainTabBarController: TabBarController {
    override init() {
        super.init()
        
        setViewControllers([PartsViewController().insideNavigation(), PartsViewController()], animated: false)
        
        
    }
}
