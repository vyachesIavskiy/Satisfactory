import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = .sh(.midnight)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .sh(.gray40)
        appearance.stackedLayoutAppearance.selected.iconColor = .sh(.midnight)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.sh(.gray40)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = UIColor.sh(.midnight)

        appearance.inlineLayoutAppearance.normal.iconColor = .sh(.gray40)
        appearance.inlineLayoutAppearance.selected.iconColor = .sh(.midnight)
        appearance.inlineLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.sh(.gray40)
        appearance.inlineLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = UIColor.sh(.midnight)

        appearance.compactInlineLayoutAppearance.normal.iconColor = .sh(.gray40)
        appearance.compactInlineLayoutAppearance.selected.iconColor = .sh(.midnight)
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.sh(.gray40)
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes[.foregroundColor] = UIColor.sh(.midnight)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        let newProduction = NewProductionTabController()
        newProduction.tabBarItem = UITabBarItem(
            title: "New Production",
            image: UIImage(systemName: "hammer"),
            selectedImage: UIImage(systemName: "hammer.fill")
        )
        
        let factories = FactoriesTabController()
        factories.tabBarItem = UITabBarItem(
            title: "Factories",
            image: UIImage(systemName: "building.2"),
            selectedImage: UIImage(systemName: "building.2.fill")
        )
        
        let settings = SettingsTabController()
        settings.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear")
        )
        
        setViewControllers(
            [newProduction, factories, settings],
            animated: false
        )
    }
}
