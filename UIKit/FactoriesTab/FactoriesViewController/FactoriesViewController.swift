import UIKit

final class FactoriesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Factories"
        
        let emptyView = UILabel()
        emptyView.text = "Under construction"
        emptyView.font = .preferredFont(forTextStyle: .largeTitle)
        
        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
