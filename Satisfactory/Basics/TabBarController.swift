import UIKit

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupAppearance()
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        
        self.viewControllers = viewControllers
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.configureWithDefault(for: .stacked)
        tabBarItemAppearance.selected.iconColor = .factoryPrimaryColor
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.factorySecondaryColor]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBar.standardAppearance = tabBarAppearance
    }
}
