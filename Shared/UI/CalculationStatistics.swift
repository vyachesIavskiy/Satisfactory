import SwiftUI

struct CalculationStatisticsModel: Identifiable {
    let item: Item
    var amount: Double
    
    var id: String { item.id }
}

extension Array where Element == CalculationStatisticsModel {
    func sorted() -> Self {
        sorted {
            guard let left = $0.item as? Part, let right = $1.item as? Part else { return true }
            
            return left.sortingPriority > right.sortingPriority
        }
    }
    
    func reduceDuplicates() -> Self {
        var result = [CalculationStatisticsModel]()
        for element in self {
            if let index = result.firstIndex(where: { $0.id == element.id }) {
                result[index].amount += element.amount
            } else {
                result.append(element)
            }
        }
        
        return result
    }
}

struct CalculationMachineStatisticsModel: Identifiable {
    let recipe: Recipe
    let item: Item
    var amount: Double
    var amountOfMachines: Double
    var machine: Building {
        recipe.machines[0]
    }
    
    var id: String { recipe.id }
}

extension Array where Element == CalculationMachineStatisticsModel {
    func reduceDuplicates() -> Self {
        var result = [CalculationMachineStatisticsModel]()
        for element in self {
            if let index = result.firstIndex(where: { $0.recipe.id == element.recipe.id }) {
                result[index].amount += element.amount
                result[index].amountOfMachines += element.amountOfMachines
            } else {
                result.append(element)
            }
        }
        
        return result
    }
}

struct CalculationStatistics: View {
    var data: [CalculationStatisticsModel]
    var machines: [CalculationMachineStatisticsModel]
    
    @State private var itemsExpanded = true
    @State private var machinesExpanded = true
    
    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                SHSection("Items", data: data.sorted(), expanded: $itemsExpanded) { entry in
                    ItemRow(item: entry.item, amount: entry.amount)
                }
                
                Spacer()
                    .frame(height: 4)
                
                SHSection("Machines", data: machines, expanded: $machinesExpanded) { machine in
                    machineView(machine)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func machineView(_ machine: CalculationMachineStatisticsModel) -> some View {
        HStack {
            HStack(alignment: .top, spacing: 12) {
                Image(machine.machine.imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(4)
                    .overlay(
                        Color("Secondary").opacity(0.3),
                        in: AngledRectangle(cornerRadius: 6).stroke(style: StrokeStyle(lineWidth: 1))
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(machine.machine.name)
                    
                    HStack(spacing: 10) {
                        Image(machine.item.imageName)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(2)
                            .overlay(
                                Color("Secondary").opacity(0.3),
                                in: AngledRectangle(cornerRadius: 4).stroke(style: StrokeStyle(lineWidth: 1))
                            )
                        
                        Text(machine.item.name)
                            .font(.footnote)
                    }
                }
            }
            
            Spacer()
            
            Text(machine.amountOfMachines, format: .fractionFromZeroToFour)
                .font(.headline)
        }
    }
}

#if DEBUG
#Preview("Calculation statistics (icon)") {
    let storage: Storage = PreviewStorage()
    
    return CalculationStatistics(
        data: [
            CalculationStatisticsModel(item: storage[partID: "iron-plate"]!, amount: 100),
            CalculationStatisticsModel(item: storage[partID: "iron-ingot"]!, amount: 150),
            CalculationStatisticsModel(item: storage[partID: "iron-ore"]!, amount: 150)
        ],
        machines: [
            CalculationMachineStatisticsModel(
                recipe: storage[recipesFor: "iron-plate"][0],
                item: storage[partID: "iron-plate"]!,
                amount: 100,
                amountOfMachines: 5
            ),
            CalculationMachineStatisticsModel(
                recipe: storage[recipesFor: "iron-ingot"][0],
                item: storage[partID: "iron-ingot"]!,
                amount: 150,
                amountOfMachines: 5
            )
        ]
    )
    .environmentObject(Settings())
    .environmentObject(storage)
}
#endif
