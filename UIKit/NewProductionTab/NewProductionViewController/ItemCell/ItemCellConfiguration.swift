import UIKit
import SHModels

struct ItemCellConfiguration: UIContentConfiguration, Hashable {
    let id = UUID()
    var title = ""
    var imageName = ""
    var form: Part.Form?
    
    func makeContentView() -> any UIView & UIContentView {
        ItemCellContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> ItemCellConfiguration {
        guard let state = state as? UICellConfigurationState else { return self }
        
        // Do nothing for now
        return self
    }
}
