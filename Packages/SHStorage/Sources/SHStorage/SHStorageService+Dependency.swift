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
        pins: { Pins() },
        streamPins: { .never },
        parts: { [] },
        equipment: { [] },
        buildings: { [] },
        recipes: { [] },
        changePartPinStatus: { _ in },
        changeEquipmentPinStatus: { _ in },
        changeRecipePinStatus: { _ in }
    )
    
    static let failing = SHStorageService(
        load: unimplemented("SHStorageService.load"),
        staticConfiguration: unimplemented("SHStorageService.staticConfiguration"),
        persistentConfiguration: unimplemented("SHStorageService.persistentConfiguration"),
        pins: unimplemented("SHStorageService.pins"),
        streamPins: unimplemented("SHStorageService.streamPins"),
        parts: unimplemented("SHStorageService.parts"),
        equipment: unimplemented("SHStorageService.equipment"),
        buildings: unimplemented("SHStorageService.buildings"),
        recipes: unimplemented("SHStorageService.recipes"),
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
            pins: { live.pins },
            streamPins: { live.streamPins },
            parts: { live.parts },
            equipment: { live.equipment },
            buildings: { live.buildings },
            recipes: { live.recipes },
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
            pins: { preview.pins },
            streamPins: { preview.streamPins },
            parts: { preview.parts },
            equipment: { preview.equipment },
            buildings: { preview.buildings },
            recipes: { preview.recipes },
            changePartPinStatus: { preview.changePartPinStatus($0) },
            changeEquipmentPinStatus: { preview.changeEquipmentPinStatus($0) },
            changeRecipePinStatus: { preview.changeRecipePinStatus($0) }
        )
    }()
}
