private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .storage)
    }
}

let personalStorageBox = Building(name: "Personal Storage Box")
let storageContainer = Building(name: "Storage Container")
let industrialStorageContainer = Building(name: "Industrial Storage Container")
let fluidBuffer = Building(name: "Fluid Buffer")
let industrialFluidBuffer = Building(name: "Industrial Fluid Buffer")

let Storage = [
    personalStorageBox,
    storageContainer,
    industrialStorageContainer,
    fluidBuffer,
    industrialFluidBuffer
]
