import UIKit

public extension UIViewController {
    func insideNavigation(presentationStyle: UIModalPresentationStyle = .automatic) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        modalPresentationStyle = presentationStyle
        return navigation
    }
}
