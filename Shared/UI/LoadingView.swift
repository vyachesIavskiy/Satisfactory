import SwiftUI

private struct Downloader {
    var dataProvider: DataProviderProtocol
    var storage: Storage
    
    func execute() async {
        storage.version = await dataProvider.version
        
        storage.parts = await dataProvider.parts.map { part in
            Part(
                id: part.id,
                name: part.name,
                partType: PartType(rawValue: part.partType)!,
                tier: Tier(rawValue: part.tier)!,
                milestone: part.milestone,
                sortingPriority: part.sortingPriority,
                rawResource: part.rawResource,
                isFavorite: storage[partID: part.id]?.isFavorite == true
            )
        }
        
        storage.equipments = await dataProvider.equipments.map { equipment in
            Equipment(
                id: equipment.id,
                name: equipment.name,
                slot: EquipmentSlot(rawValue: equipment.slot)!,
                fuel: storage[partID: equipment.fuel ?? ""],
                ammo: storage[partID: equipment.ammo ?? ""],
                consumes: storage[partID: equipment.consumes ?? ""],
                isFavorite: storage[equipmentID: equipment.id]?.isFavorite == true
            )
        }
        
        storage.buildings = await dataProvider.buildings.map { building in
            Building(
                id: building.id,
                name: building.name,
                buildingType: BuildingType(rawValue: building.buildingType)!,
                isFavorite: storage[buildingID: building.id]?.isFavorite == true
            )
        }
        
        storage.vehicles = await dataProvider.vehicles.map { vehicle in
            Vehicle(
                id: vehicle.id,
                name: vehicle.name,
                fuel: vehicle.fuel.compactMap { fuel in
                    storage[partID: fuel]
                },
                isFavorite: storage[vehicleID: vehicle.id]?.isFavorite == true
            )
        }
        
        storage.recipes = await dataProvider.recipes.map { recipe in
            Recipe(
                id: recipe.id,
                name: recipe.name,
                input: recipe.input.map { input in
                    Recipe.RecipePart(item: storage[itemID: input.id]!, amount: input.amount)
                },
                output: recipe.output.map { output in
                    Recipe.RecipePart(item: storage[itemID: output.id]!, amount: output.amount)
                },
                machines: recipe.machines.compactMap { machine in
                    storage[buildingID: machine]
                },
                duration: recipe.duration,
                isDefault: recipe.isDefault,
                isFavorite: storage[recipeID: recipe.id]?.isFavorite == true
            )
        }
        
        storage.save()
    }
}

struct LoadingView: View {
    @Environment(\.dataProvider) private var dataProvider
    @EnvironmentObject private var storage: Storage
    
    @Binding var isLoaded: Bool
    
    @State private var status = Status.loading
    
    @AppStorage("flushed_v1.4")
    private var flushed_v1_4 = false
    
    private enum Status: String {
        case loading = ""
        case downloading = "Downloading"
    }
    
    var body: some View {
        ProgressView(status.rawValue)
            .task {
                let version = await dataProvider.version
                let currentVersion = storage.version
                if flushed_v1_4 {
                    storage.load()
                    
                    if version > currentVersion {
                        status = .downloading
                        await Downloader(dataProvider: dataProvider, storage: storage).execute()
                    }
                } else {
                    status = .downloading
                    await Downloader(dataProvider: dataProvider, storage: storage).execute()
                    
                    flushed_v1_4 = true
                }
                
                isLoaded = true
            }
    }
}

struct LoadingPreviews: PreviewProvider {
    @State private static var isLoaded = false
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        LoadingView(isLoaded: $isLoaded)
            .environmentObject(storage)
    }
}

