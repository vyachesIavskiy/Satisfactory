import Foundation
import SHModels
import SHStorage

#if DEBUG
func part(id: String) -> Part {
    @Dependency(\.storageService)
    var storageService
    
    return storageService.part(id: id) ?? Part(id: "", category: .special, progressionIndex: -1, form: .solid)
}
#endif
