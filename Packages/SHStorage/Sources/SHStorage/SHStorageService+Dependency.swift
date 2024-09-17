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
        factories: { [] },
        streamFactories: { .never },
        productions: { [] },
        productionsInside: { _ in [] },
        streamProductions: { .never },
        streamProductionsInside: { _ in .never },
        saveFactory: { _ in },
        saveProduction: { _, _ in },
        saveProductionInformation: { _, _ in },
        saveProductionContent: { _ in },
        deleteFactory: { _ in },
        deleteProduction: { _ in },
        moveFactories: { _, _ in },
        moveProductions: { _, _, _ in },
        parts: { [] },
        buildings: { [] },
        recipes: { [] },
        extractions: { [] },
        changePartPinStatus: { _, _ in },
        changeBuildingPinStatus: { _, _ in },
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
        productionsInside: unimplemented("SHStorageService.productionsInside", placeholder: []),
        streamProductions: unimplemented("SHStorageService.streamProductions", placeholder: .never),
        streamProductionsInside: unimplemented("SHStorageService.streamProductionsInside", placeholder: .never),
        saveFactory: unimplemented("SHStorageService.saveFactory", placeholder: ()),
        saveProduction: unimplemented("SHStorageService.saveProduction", placeholder: ()),
        saveProductionInformation: unimplemented("SHStorageService.saveProductionInformation", placeholder: ()),
        saveProductionContent: unimplemented("SHStorageService.saveProductionContent", placeholder: ()),
        deleteFactory: unimplemented("SHStorageService.deleteFactory", placeholder: ()),
        deleteProduction: unimplemented("SHStorageService.deleteProduction", placeholder: ()),
        moveFactories: unimplemented("SHStorageService.moveFactories", placeholder: ()),
        moveProductions: unimplemented("SHStorageService.moveProductions", placeholder: ()),
        parts: unimplemented("SHStorageService.parts", placeholder: []),
        buildings: unimplemented("SHStorageService.buildings", placeholder: []),
        recipes: unimplemented("SHStorageService.recipes", placeholder: []),
        extractions: unimplemented("SHStorageService.extractions", placeholder: []),
        changePartPinStatus: unimplemented("SHStorageService.changePartPinStatus", placeholder: ()),
        changeBuildingPinStatus: unimplemented("SHStorageService.changeBuildingPinStatus", placeholder: ()),
        changeRecipePinStatus: unimplemented("SHStorageService.changeRecipePinStatus", placeholder: ())
    )
    
    static let live = {
        let live = Live()
        
        return SHStorageService(
            load: { try live.load() },
            staticConfiguration: { live.staticConfiguration },
            persistentConfiguration: { live.persistentConfiguration },
            pins: { live.pins },
            streamPins: { live.streamPins },
            factories: { live.factories },
            streamFactories: { live.streamFactories },
            productions: { live.productions },
            productionsInside: { live.productions(inside: $0) },
            streamProductions: { live.streamProductions },
            streamProductionsInside: { live.streamProductions(inside: $0) },
            saveFactory: { live.saveFactory($0) },
            saveProduction: { live.saveProduction($0, to: $1) },
            saveProductionInformation: { live.saveProductionInformation($0, to: $1) },
            saveProductionContent: { live.saveProductionContent($0) },
            deleteFactory: { live.deleteFactory($0) },
            deleteProduction: { live.deleteProduction($0) },
            moveFactories: { live.moveFactories(fromOffsets: $0, toOffset: $1) },
            moveProductions: { live.moveProductions(factory: $0, fromOffsets: $1, toOffset: $2) },
            parts: { live.parts },
            buildings: { live.buildings },
            recipes: { live.recipes },
            extractions: { live.extractions },
            changePartPinStatus: { live.changePinStatus(partID: $0, productionType: $1) },
            changeBuildingPinStatus: { live.changePinStatus(buildingID: $0, productionType: $1) },
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
            factories: { preview.factories },
            streamFactories: { preview.streamFactories },
            productions: { preview.productions },
            productionsInside: { preview.productions(inside: $0) },
            streamProductions: { preview.streamProductions },
            streamProductionsInside: { preview.streamProductions(inside: $0) },
            saveFactory: { preview.saveFactory($0) },
            saveProduction: { preview.saveProduction($0, to: $1) },
            saveProductionInformation: { preview.saveProductionInformation($0, to: $1) },
            saveProductionContent: { preview.saveProductionContent($0) },
            deleteFactory: { preview.deleteFactory($0) },
            deleteProduction: { preview.deleteProduction($0) },
            moveFactories: { preview.moveFactories(fromOffsets: $0, toOffset: $1) },
            moveProductions: { preview.moveProductions(factory: $0, fromOffsets: $1, toOffset: $2) },
            parts: { preview.parts },
            buildings: { preview.buildings },
            recipes: { preview.recipes },
            extractions: { preview.extractions },
            changePartPinStatus: { preview.changePinStatus(partID: $0, productionType: $1) },
            changeBuildingPinStatus: { preview.changePinStatus(buildingID: $0, productionType: $1) },
            changeRecipePinStatus: { preview.changeRecipePinStatus($0) }
        )
    }()
}
