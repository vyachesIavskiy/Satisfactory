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
        load: { _ in },
        staticConfiguration: { Configuration(version: 1) },
        persistentConfiguration: { Configuration(version: 1) },
        pins: { Pins() },
        streamPins: { .never },
        factories: { [] },
        streamFactories: { .never },
        productions: { [] },
        streamProductions: { .never },
        saveFactory: { _ in },
        saveProduction: { _, _ in },
        deleteFactory: { _ in },
        deleteProduction: { _ in },
        parts: { [] },
        equipment: { [] },
        buildings: { [] },
        recipes: { [] },
        extractions: { [] },
        changePartPinStatus: { _ in },
        changeEquipmentPinStatus: { _ in },
        changeRecipePinStatus: { _ in }
    )
    
    static let failing = SHStorageService(
        load: unimplemented("SHStorageService.load", placeholder: ()),
        staticConfiguration: unimplemented("SHStorageService.staticConfiguration", placeholder: Configuration(version: 0)),
        persistentConfiguration: unimplemented("SHStorageService.persistentConfiguration", placeholder: Configuration(version: 0)),
        pins: unimplemented("SHStorageService.pins", placeholder: Pins()),
        streamPins: unimplemented("SHStorageService.streamPins", placeholder: .never),
        factories: unimplemented("SHStorageService.factories", placeholder: []),
        streamFactories: unimplemented("SHStorageService.streamFactories", placeholder: .never),
        productions: unimplemented("SHStorageService.productions", placeholder: []),
        streamProductions: unimplemented("SHStorageService.streamProductions", placeholder: .never),
        saveFactory: unimplemented("SHStorageService.saveFactory", placeholder: ()),
        saveProduction: unimplemented("SHStorageService.saveProduction", placeholder: ()),
        deleteFactory: unimplemented("SHStorageService.deleteFactory", placeholder: ()),
        deleteProduction: unimplemented("SHStorageService.deleteProduction", placeholder: ()),
        parts: unimplemented("SHStorageService.parts", placeholder: []),
        equipment: unimplemented("SHStorageService.equipment", placeholder: []),
        buildings: unimplemented("SHStorageService.buildings", placeholder: []),
        recipes: unimplemented("SHStorageService.recipes", placeholder: []),
        extractions: unimplemented("SHStorageService.extractions", placeholder: []),
        changePartPinStatus: unimplemented("SHStorageService.changePartPinStatus", placeholder: ()),
        changeEquipmentPinStatus: unimplemented("SHStorageService.changeEquipmentPinStatus", placeholder: ()),
        changeRecipePinStatus: unimplemented("SHStorageService.changeRecipePinStatus", placeholder: ())
    )
    
    static let live = {
        let live = Live()
        
        return SHStorageService(
            load: { try live.load($0) },
            staticConfiguration: { live.staticConfiguration },
            persistentConfiguration: { live.persistentConfiguration },
            pins: { live.pins },
            streamPins: { live.streamPins },
            factories: { live.factories },
            streamFactories: { live.streamFactories },
            productions: { live.productions },
            streamProductions: { live.streamProductions },
            saveFactory: { live.saveFactory($0) },
            saveProduction: { live.saveProduction($0, to: $1) },
            deleteFactory: { live.deleteFactory($0) },
            deleteProduction: { live.deleteProduction($0) },
            parts: { live.parts },
            equipment: { live.equipment },
            buildings: { live.buildings },
            recipes: { live.recipes },
            extractions: { live.extractions },
            changePartPinStatus: { live.changePartPinStatus($0) },
            changeEquipmentPinStatus: { live.changeEquipmentPinStatus($0) },
            changeRecipePinStatus: { live.changeRecipePinStatus($0) }
        )
    }()
    
    static var preview = {
        let preview = Preview()
        
        return SHStorageService(
            load: { _ in },
            staticConfiguration: { Configuration(version: 1) },
            persistentConfiguration: { Configuration(version: 1) },
            pins: { preview.pins },
            streamPins: { preview.streamPins },
            factories: { preview.factories },
            streamFactories: { preview.streamFactories },
            productions: { preview.productions },
            streamProductions: { preview.streamProductions },
            saveFactory: { preview.saveFactory($0) },
            saveProduction: { preview.saveProduction($0, to: $1) },
            deleteFactory: { preview.deleteFactory($0) },
            deleteProduction: { preview.deleteProduction($0) },
            parts: { preview.parts },
            equipment: { preview.equipment },
            buildings: { preview.buildings },
            recipes: { preview.recipes },
            extractions: { preview.extractions },
            changePartPinStatus: { preview.changePartPinStatus($0) },
            changeEquipmentPinStatus: { preview.changeEquipmentPinStatus($0) },
            changeRecipePinStatus: { preview.changeRecipePinStatus($0) }
        )
    }()
}
