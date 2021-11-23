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
    var amountOfMachines: Double
    var machine: Building {
        recipe.machines[0]
    }
    
    var id: String { recipe.id }
}

struct CalculationStatistics: View {
    var data: [CalculationStatisticsModel]
    var machines: [CalculationMachineStatisticsModel]
    
    @EnvironmentObject private var settings: Settings
    
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
                    machineView(machine)
                }
            }
        }
    }
    
    private func machineView(_ machine: CalculationMachineStatisticsModel) -> some View {
        Group {
            switch settings.itemViewStyle {
            case .icon: machineViewIcon(machine)
            case .row: machineViewRow(machine)
            }
        }
    }
    
    private func machineViewIcon(_ machine: CalculationMachineStatisticsModel) -> some View {
        HStack {
            Image(machine.item.name)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(3)
                .background(Color.orange)
                .cornerRadius(6)
            
            machineStatisticsView(machine)
        }
    }
    
    private func machineViewRow(_ machine: CalculationMachineStatisticsModel) -> some View {
        VStack(alignment: .leading) {
            ItemRow(item: machine.item)
                .foregroundColor(.white)
                .padding(3)
                .background(Color.orange)
                .cornerRadius(6)
            
            machineStatisticsView(machine)
        }
    }
    
    private func machineStatisticsView(_ machine: CalculationMachineStatisticsModel) -> some View {
        HStack {
            HStack(spacing: 10) {
                Image(machine.machine.name)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text(machine.machine.name)
            }
            
            Spacer()
            
            Text("\(Int(ceil(machine.amountOfMachines)))")
                .fontWeight(.bold)
        }
    }
}

struct CalculationStatisticsPreviews: PreviewProvider {
    static var previews: some View {
        CalculationStatistics(data: [], machines: [])
            .environmentObject(Settings())
    }
}
