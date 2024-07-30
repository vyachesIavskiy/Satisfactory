import UIKit
import SHModels
import SHStorage

final class ItemCell: SHListCell {
    var itemID: String?
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        itemID.flatMap(storageService.item(id:))
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        guard let item else { return }
        
        var newConfiguration = ItemCellConfiguration().updated(for: state)
        newConfiguration.title = item.localizedName
        newConfiguration.imageName = item.id
        newConfiguration.form = (item as? Part)?.form
        
        contentConfiguration = newConfiguration
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemID = nil
    }
}

#Preview("Cell") {
    let cell = ItemCell()
    cell.itemID = "part-iron-plate"
    return cell
}
