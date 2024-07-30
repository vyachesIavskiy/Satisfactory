import UIKit

final class ToggleCell: SHListCell {
    override func updateConfiguration(using state: UICellConfigurationState) {
        automaticallyUpdatesBackgroundConfiguration = false
        
        var newState = state
        newState.isHighlighted = false
        newState.isSelected = false
        backgroundConfiguration = backgroundConfiguration?.updated(for: newState)
    }
}
