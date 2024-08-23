import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class StatisticsViewModel {
    let productions: [Production]
    let title: String
    
    var itemsSection = ItemsSection()
    var naturalResourcesSection = NaturalResourcesSection()
    var machinesSection = MachineSection()
    
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
        
        private var totalPowerConsumption: Recipe.PowerConsumption {
            machines.reduce(into: Recipe.PowerConsumption()) { partialResult, machine in
                partialResult.min += machine.powerConsumption.min
                partialResult.max += machine.powerConsumption.max
            }
        }
        
        var powerConsumptionString: String {
            if totalPowerConsumption.min == totalPowerConsumption.max {
                "\(totalPowerConsumption.max.formatted(.number)) MW"
            } else {
                "(\(totalPowerConsumption.min.formatted(.number)) ~ \(totalPowerConsumption.min.formatted(.number))) MW"
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
        
        var subtitle: String {
            if expandable {
                "\(statisticItem.recipes.count) recipes"
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
        
        var powerConsumption: Recipe.PowerConsumption {
            recipes.reduce(into: Recipe.PowerConsumption()) { partialResult, machineRecipe in
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
        
        var subtitle: String {
            if expandable {
                "\(recipes.count) recipes"
            } else {
                recipes[0].recipe.localizedName
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
        
        var powerValueString: String {
            if powerConsumption.min == powerConsumption.max {
                "\(powerConsumption.max.formatted(.number)) MW"
            } else {
                "(\(powerConsumption.min.formatted(.number)) ~ \(powerConsumption.min.formatted(.number))) MW"
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
        let id = UUID()
        let recipe: Recipe
        var amount: Double
        var powerConsumption: Recipe.PowerConsumption
        
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
                AttributedString("\(powerConsumption.max.formatted(.number)) MW")
            } else {
                AttributedString("(\(powerConsumption.min.formatted(.number)) ~ \(powerConsumption.min.formatted(.number))) MW")
            }
        }
        
        init(statisticRecipe: StatisticRecipe) {
            let recipeAmount = statisticRecipe.amount / statisticRecipe.recipe.amountPerMinute
            recipe = statisticRecipe.recipe
            amount = statisticRecipe.amount / statisticRecipe.recipe.amountPerMinute
            powerConsumption = Recipe.PowerConsumption(
                min: statisticRecipe.recipe.powerConsumption.min * Int(recipeAmount.rounded(.up)),
                max: statisticRecipe.recipe.powerConsumption.max * Int(recipeAmount.rounded(.up))
            )
        }
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
