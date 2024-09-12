import SwiftUI
import SHModels
import SHStorage
import SHUtils

@Observable
final class StatisticsViewModel {
    let productions: [Production]
    let title: String
    
    var itemsSection = ItemsSection()
    var naturalResourcesSection = NaturalResourcesSection()
    var machinesSection = MachineSection()
    
    var id: String {
        productions[0].id.uuidString
    }
    
    init(production: Production) {
        productions = [production]
        title = production.name
        
        buildSections()
    }
    
    init(factory: Factory) {
        @Dependency(\.storageService)
        var storageService
        
        productions = storageService.produtions(inside: factory)
        title = factory.name
        
        buildSections()
    }
    
    private func buildSections() {
        itemsSection.items = productions
            .flatMap(\.statistics.items)
            .reduce(into: [Item]()) { partialResult, statisticItem in
                if let index = partialResult.firstIndex(where: { $0.id == statisticItem.id }) {
                    partialResult[index].statisticItem.recipes.merge(with: statisticItem.recipes) { lhs, rhs in
                        lhs.id == rhs.id
                    } merging: { lhs, rhs in
                        lhs.amount += rhs.amount
                    }
                } else {
                    partialResult.append(Item(statisticItem: statisticItem))
                }
            }
            .sorted()
        
        naturalResourcesSection.naturalResources = productions
            .flatMap(\.statistics.naturalResources)
            .reduce(into: [StatisticNaturalResource]()) { partialResult, statisticNaturalResource in
                if let index = partialResult.firstIndex(where: { $0.id == statisticNaturalResource.id }) {
                    partialResult[index].amount += statisticNaturalResource.amount
                } else {
                    partialResult.append(statisticNaturalResource)
                }
            }
            .sorted()
        
        machinesSection.machines = productions.flatMap(\.statistics.items).reduce(into: []) { partialResult, statisticItem in
            let recipeMachines = statisticItem.recipes.reduce(into: [Machine]()) { partialResult, statisticRecipe in
                guard let recipeMachine = statisticRecipe.recipe.machine else { return }
                
                let newMachineRecipe = MachineRecipe(statisticRecipe: statisticRecipe)
                
                if let index = partialResult.firstIndex(where: { $0.building == recipeMachine }) {
                    partialResult[index].recipes.append(newMachineRecipe)
                } else {
                    partialResult.append(
                        Machine(
                            building: recipeMachine,
                            recipes: [newMachineRecipe]
                        )
                    )
                }
            }
            
            partialResult.merge(with: recipeMachines) { lhs, rhs in
                lhs.id == rhs.id
            } merging: { lhs, rhs in
                lhs.recipes.merge(with: rhs.recipes) { lhs, rhs in
                    lhs.id == rhs.id
                } merging: { lhs, rhs in
                    lhs.amount += rhs.amount
                    lhs.powerConsumption.min += rhs.powerConsumption.min
                    lhs.powerConsumption.max += rhs.powerConsumption.max
                }
            }
        }
    }
}

extension StatisticsViewModel {
    struct ItemsSection: Hashable {
        var items = [Item]()
        var expanded = true
    }
}

extension StatisticsViewModel {
    struct NaturalResourcesSection: Hashable {
        var naturalResources = [StatisticNaturalResource]()
        var expanded = true
    }
}

extension StatisticsViewModel {
    struct MachineSection: Hashable {
        var machines = [Machine]()
        var expanded = true
        
        private var totalPowerConsumption: MachineRecipe.PowerConsumption {
            machines.reduce(into: MachineRecipe.PowerConsumption()) { partialResult, machine in
                partialResult.min += machine.powerConsumption.min
                partialResult.max += machine.powerConsumption.max
            }
        }
        
        var powerConsumptionString: LocalizedStringKey {
            if totalPowerConsumption.min == totalPowerConsumption.max {
                "statistics-power-consumption-fixed-\(totalPowerConsumption.max.formatted(.shNumber(fractionLength: 1)))"
            } else {
                "statistics-power-consumption-fluctuated-(\(totalPowerConsumption.min.formatted(.shNumber(fractionLength: 1)))-\(totalPowerConsumption.max.formatted(.shNumber(fractionLength: 1))))"
            }
        }
    }
}

extension StatisticsViewModel {
    struct Item: Identifiable, Hashable {
        var statisticItem: StatisticItem
        var recipesExpanded: Bool
        
        var id: String { statisticItem.id }
        
        var expandable: Bool {
            statisticItem.recipes.count > 1
        }
        
        var subtitle: LocalizedStringKey {
            if expandable {
                "statistics-\(statisticItem.recipes.count)-of-recipes"
            } else {
                "\(statisticItem.recipes[0].recipe.localizedName)"
            }
        }
        
        init(statisticItem: StatisticItem, recipesExpanded: Bool = false) {
            self.statisticItem = statisticItem
            self.recipesExpanded = recipesExpanded
        }
    }
}

extension StatisticsViewModel {
    struct NaturalResource: Identifiable, Hashable {
        var statisticNaturalResource: StatisticNaturalResource
        var machine: Building?
        var amountOfMachines: Double
        
        var id: String { statisticNaturalResource.id }
        
        init(statisticNaturalResource: StatisticNaturalResource, machine: Building? = nil, amountOfMachines: Double) {
            self.statisticNaturalResource = statisticNaturalResource
            self.machine = machine
            self.amountOfMachines = amountOfMachines
        }
    }
}

extension StatisticsViewModel {
    struct Machine: Identifiable, Hashable {
        let building: Building
        var recipes: [MachineRecipe]
        var recipesExpanded: Bool
        
        var id: String { building.id }
        
        var amount: Double {
            recipes.reduce(0) { $0 + $1.amount }
        }
        
        var powerConsumption: MachineRecipe.PowerConsumption {
            recipes.reduce(into: MachineRecipe.PowerConsumption()) { partialResult, machineRecipe in
                partialResult.min += machineRecipe.powerConsumption.min
                partialResult.max += machineRecipe.powerConsumption.max
            }
        }
        
        private var intAmount: Int {
            recipes.reduce(0) { $0 + $1.intAmount }
        }
        
        var expandable: Bool {
            recipes.count > 1
        }
        
        var subtitle: LocalizedStringKey {
            if expandable {
                "statistics-\(recipes.count)-of-recipes"
            } else {
                "\(recipes[0].recipe.localizedName)"
            }
        }
        
        var valueString: AttributedString {
            if recipes.count > 1 {
                return AttributedString(intAmount.formatted(.number))
            } else {
                let intAmount = Int(amount.rounded(.down))
                let additionalPercent = amount - Double(intAmount)
                
                if intAmount > 0, additionalPercent > 0 {
                    var result = AttributedString((intAmount + 1).formatted(.number))
                    var container = AttributeContainer()
                    container.font = .caption
                    result.append(AttributedString(" (1x \(additionalPercent.formatted(.shPercent)))", attributes: container))
                    return result
                } else if intAmount > 0 {
                    return AttributedString(intAmount.formatted(.number))
                } else if additionalPercent > 0 {
                    var result = AttributedString("1")
                    var container = AttributeContainer()
                    container.font = .caption
                    result.append(AttributedString(" (\(additionalPercent.formatted(.shPercent)))", attributes: container))
                    return result
                } else {
                    return AttributedString()
                }
            }
        }
        
        var shouldDisplayPowerConsumption: Bool {
            powerConsumption.min > 0 || powerConsumption.max > 0
        }
        
        var powerValueString: LocalizedStringKey {
            if powerConsumption.min == powerConsumption.max {
                "statistics-power-consumption-fixed-\(powerConsumption.max.formatted(.shNumber(fractionLength: 1)))"
            } else {
                "statistics-power-consumption-fluctuated-(\(powerConsumption.min.formatted(.shNumber(fractionLength: 1)))-\(powerConsumption.max.formatted(.shNumber(fractionLength: 1))))"
            }
        }
        
        init(building: Building, recipes: [MachineRecipe], recipesExpanded: Bool = false) {
            self.building = building
            self.recipes = recipes
            self.recipesExpanded = recipesExpanded
        }
    }
}

extension StatisticsViewModel {
    struct MachineRecipe: Identifiable, Hashable {
        let recipe: Recipe
        var amount: Double
        var powerConsumption: PowerConsumption
        
        var id: String { recipe.id }
        
        var intAmount: Int {
            Int(amount.rounded(.up))
        }
        
        var valueString: AttributedString {
            let intAmount = Int(amount.rounded(.down))
            let additionalPercent = amount - Double(intAmount)
            
            if intAmount > 0, additionalPercent > 0 {
                var container = AttributeContainer()
                container.font = .caption.weight(.semibold)
                var result = AttributedString((intAmount + 1).formatted(.number), attributes: container)
                container.font = .caption
                result.append(AttributedString(" (1x \(additionalPercent.formatted(.shPercent)))", attributes: container))
                return result
            } else if intAmount > 0 {
                return AttributedString(intAmount.formatted(.number))
            } else if additionalPercent > 0 {
                var container = AttributeContainer()
                container.font = .caption.weight(.semibold)
                var result = AttributedString("1", attributes: container)
                container.font = .caption
                result.append(AttributedString(" (\(additionalPercent.formatted(.shPercent)))", attributes: container))
                return result
            } else {
                return AttributedString()
            }
        }
        
        var powerValueString: AttributedString {
            if powerConsumption.min == powerConsumption.max {
                AttributedString("statistics-power-consumption-fixed-\(powerConsumption.max.formatted(.shNumber(fractionLength: 1)))")
            } else {
                AttributedString("statistics-power-consumption-fluctuated-(\(powerConsumption.min.formatted(.shNumber(fractionLength: 1)))-\(powerConsumption.min.formatted(.shNumber(fractionLength: 1))))")
            }
        }
        
        init(statisticRecipe: StatisticRecipe) {
            let recipeAmount = statisticRecipe.amount / statisticRecipe.recipe.amountPerMinute
            recipe = statisticRecipe.recipe
            amount = statisticRecipe.amount / statisticRecipe.recipe.amountPerMinute
            let intRecipeAmount = Int(recipeAmount.rounded(.down))
            var min = Double(statisticRecipe.recipe.powerConsumption.min * intRecipeAmount)
            var max = Double(statisticRecipe.recipe.powerConsumption.max * intRecipeAmount)
            
            if recipeAmount > Double(intRecipeAmount) {
                let underclockedRecipePercentage = recipeAmount - Double(intRecipeAmount)
                let underclockedMultiplier = pow(underclockedRecipePercentage, 1.321928)
                min += Double(statisticRecipe.recipe.powerConsumption.min) * underclockedMultiplier
                max += Double(statisticRecipe.recipe.powerConsumption.max) * underclockedMultiplier
            }
            powerConsumption = PowerConsumption(min: min, max: max)
        }
    }
}

extension StatisticsViewModel.MachineRecipe {
    struct PowerConsumption: Hashable {
        var min = 0.0
        var max = 0.0
    }
}

extension [StatisticsViewModel.Item] {
    func sorted() -> Self {
        sorted {
            guard
                let lPart = $0.statisticItem.item as? Part,
                let rPart = $1.statisticItem.item as? Part
            else { return false }
            
            return lPart.progressionIndex > rPart.progressionIndex
        }
    }
}

extension [StatisticNaturalResource] {
    func sorted() -> Self {
        sorted {
            guard
                let lPart = $0.item as? Part,
                let rPart = $1.item as? Part
            else { return false }
            
            return lPart.progressionIndex > rPart.progressionIndex
        }
    }
}
