import SHDependencies
import SHModels

public extension DependencyValues {
    var storageService: SHStorageService {
        get { self[SHStorageService.self] }
        set { self[SHStorageService.self] = newValue }
    }
}

extension SHStorageService: DependencyKey {
    public static var liveValue = live
    public static var testValue = failing
    public static var previewValue = preview
}

extension SHStorageService {
    static let noop = SHStorageService(
        load: { },
        staticConfiguration: { Configuration(version: 1) },
        persistentConfiguration: { Configuration(version: 1) },
        parts: { [] },
        equipment: { [] },
        buildings: { [] },
        recipes: { [] },
        streamPins: { .never },
        pins: { Pins() },
        isPartPinned: { _ in false },
        isEquipmentPinned: { _ in false },
        isRecipePinned: { _ in false },
        changePartPinStatus: { _ in },
        changeEquipmentPinStatus: { _ in },
        changeRecipePinStatus: { _ in }
    )
    
    static let failing = SHStorageService(
        load: unimplemented("SHStorageService.load"),
        staticConfiguration: unimplemented("SHStorageService.staticConfiguration"),
        persistentConfiguration: unimplemented("SHStorageService.persistentConfiguration"),
        parts: unimplemented("SHStorageService.parts"),
        equipment: unimplemented("SHStorageService.equipment"),
        buildings: unimplemented("SHStorageService.buildings"),
        recipes: unimplemented("SHStorageService.recipes"),
        streamPins: unimplemented("SHStorageService.streamPins"),
        pins: unimplemented("SHStorageService.pins"),
        isPartPinned: unimplemented("SHStorageService.isPartPinned"),
        isEquipmentPinned: unimplemented("SHStorageService.isEquipmentPinned"),
        isRecipePinned: unimplemented("SHStorageService.isRecipePinned"),
        changePartPinStatus: unimplemented("SHStorageService.changePartPinStatus"),
        changeEquipmentPinStatus: unimplemented("SHStorageService.changeEquipmentPinStatus"),
        changeRecipePinStatus: unimplemented("SHStorageService.changeRecipePinStatus")
    )
    
    static let live = {
        let live = Live()
        
        return SHStorageService(
            load: { try live.load() },
            staticConfiguration: { live.staticConfiguration },
            persistentConfiguration: { live.persistentConfiguration },
            parts: { live.parts },
            equipment: { live.equipment },
            buildings: { live.buildings },
            recipes: { live.recipes },
            streamPins: { live.streamPins },
            pins: { live.pins },
            isPartPinned: { live.isPartPinned($0) },
            isEquipmentPinned: { live.isEquipmentPinned($0) },
            isRecipePinned: { live.isRecipePinned($0) },
            changePartPinStatus: { live.changePartPinStatus($0) },
            changeEquipmentPinStatus: { live.changeEquipmentPinStatus($0) },
            changeRecipePinStatus: { live.changeRecipePinStatus($0) }
        )
    }()
    
    static var preview = {
        let preview = Preview()
        
        return SHStorageService(
            load: { },
            staticConfiguration: { Configuration(version: 1) },
            persistentConfiguration: { Configuration(version: 1) },
            parts: { preview.parts },
            equipment: { preview.equipment },
            buildings: { preview.buildings },
            recipes: { preview.recipes },
            streamPins: { preview.streamPins },
            pins: { preview.pins },
            isPartPinned: { preview.isPartPinned($0) },
            isEquipmentPinned: { preview.isEquipmentPinned($0) },
            isRecipePinned: { preview.isRecipePinned($0) },
            changePartPinStatus: { preview.changePartPinStatus($0) },
            changeEquipmentPinStatus: { preview.changeEquipmentPinStatus($0) },
            changeRecipePinStatus: { preview.changeRecipePinStatus($0) }
        )
    }()
}
