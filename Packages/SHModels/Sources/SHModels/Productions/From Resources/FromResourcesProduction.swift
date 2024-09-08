import Foundation
import SHDependencies

public struct FromResourcesProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var creationDate: Date
    public var resources: [InputResource]
    public var inputItems: [InputItem]
    public var byproducts: [InputByproduct]
    public var assetName: String
    public var statistics: Statistics
    // TODO: Add fields
    
    public init(
        id: UUID,
        name: String,
        creationDate: Date,
        resources: [InputResource] = [],
        inputItems: [InputItem] = [],
        byproducts: [InputByproduct] = [],
        assetName: String,
        statistics: Statistics
    ) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.resources = resources
        self.inputItems = inputItems
        self.byproducts = byproducts
        self.assetName = assetName
        self.statistics = statistics
    }
    
    // Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.creationDate == rhs.creationDate &&
        lhs.resources == rhs.resources &&
        lhs.inputItems == rhs.inputItems &&
        lhs.byproducts == rhs.byproducts &&
        lhs.assetName == rhs.assetName &&
        lhs.statistics == rhs.statistics
    }
    
    // Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(creationDate)
        hasher.combine(resources)
        hasher.combine(inputItems)
        hasher.combine(byproducts)
        hasher.combine(assetName)
        hasher.combine(statistics)
    }
}
