import SwiftUI

struct CalculationStatisticsModel: Identifiable {
    let item: Item
    var amount: Double
    
    var id: String { item.id }
}

extension Array where Element == CalculationStatisticsModel {
    func sorted() -> Self {
        sorted {
            guard let left = $0.item as? Part, let right = $1.item as? Part else { return false }
            
            return left.sortingPriority > right.sortingPriority
        }
    }
}

struct CalculationMachineStatisticsModel: Identifiable {
    let recipe: Recipe
    let item: Item
    var amount: Double
    var machine: Building {
        recipe.machines[0]
    }
    
    var id: String { machine.id }
}

struct CalculationStatistics: View {
    var data: [CalculationStatisticsModel]
    var machines: [CalculationMachineStatisticsModel]
    
    var body: some View {
        List {
            Section(header: Text("Items")) {
                ForEach(data.sorted()) { entry in
                    HStack {
                        ItemRow(item: entry.item)
                        Spacer()
                        Text("\(entry.amount.formatted(.fractionFromZeroToFour)) / min")
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Section(header: Text("Machines")) {
                ForEach(machines) { machine in
                    HStack {
                        HStack(spacing: 10) {
                            Image(machine.machine.name)
                                .resizable()
                                .frame(width: 30, height: 30)
                            
                            Text(machine.machine.name)
                        }
                        
                        Spacer()
                        
                        Text("\(Int(ceil(machine.amount)))")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct CalculationStatisticsPreviews: PreviewProvider {
    static var previews: some View {
        CalculationStatistics(data: [], machines: [])
    }
}

