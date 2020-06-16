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
        let tabBarItemStackedAppearance = UITabBarItemAppearance()
        tabBarItemStackedAppearance.configureWithDefault(for: .stacked)
        tabBarItemStackedAppearance.selected.iconColor = .factoryPrimaryColor
        tabBarItemStackedAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.factorySecondaryColor]
        
        let tabBarItemCompactAppearance = UITabBarItemAppearance()
        tabBarItemCompactAppearance.configureWithDefault(for: .compactInline)
        tabBarItemCompactAppearance.selected.iconColor = .factoryPrimaryColor
        tabBarItemCompactAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.factorySecondaryColor]
        
        let tabBarItemInlineAppearance = UITabBarItemAppearance()
        tabBarItemInlineAppearance.configureWithDefault(for: .inline)
        tabBarItemInlineAppearance.selected.iconColor = .factoryPrimaryColor
        tabBarItemInlineAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.factorySecondaryColor]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance = tabBarItemStackedAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemCompactAppearance
        tabBarAppearance.inlineLayoutAppearance = tabBarItemInlineAppearance
        tabBar.standardAppearance = tabBarAppearance
    }
}
