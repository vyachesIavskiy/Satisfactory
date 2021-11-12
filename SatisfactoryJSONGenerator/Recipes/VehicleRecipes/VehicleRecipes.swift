private extension Recipe {
    init(input: [RecipePart], vehicle: Vehicle) {
        self.init(name: vehicle.name, input: input, output: [.init(vehicle)], machines: [], duration: 0)
    }
}

let tracktorRecipe = Recipe(
    input: [
        .init(modularFrame, amount: 5),
        .init(beacon, amount: 5),
        .init(rotor, amount: 10)
    ],
    vehicle: tractor
)

let truckRecipe = Recipe(
    input: [
        .init(motor, amount: 8),
        .init(computer, amount: 10),
        .init(heavyModularFrame, amount: 4),
        .init(rubber, amount: 50),
        .init(beacon, amount: 10)
    ],
    vehicle: truck
)

let explorerRecipe = Recipe(
    input: [
        .init(crystalOscillator, amount: 5),
        .init(motor, amount: 5),
        .init(beacon, amount: 15),
        .init(heavyModularFrame, amount: 5)
    ],
    vehicle: explorer
)

let cyberWagonRecipe = Recipe(
    input: [
        .init(reinforcedIronPlate, amount: 10)
    ],
    vehicle: cyberWagon
)

let droneRecipe = Recipe(
    input: [
        .init(motor, amount: 4),
        .init(alcladAluminumSheet, amount: 10),
        .init(radioControlUnit, amount: 1),
        .init(aiLimiter, amount: 2),
        .init(portableMiner, amount: 1)
    ],
    vehicle: drone
)

let electricLocomotiveRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 5),
        .init(motor, amount: 10),
        .init(steelPipe, amount: 15),
        .init(computer, amount: 5),
        .init(beacon, amount: 5)
    ],
    vehicle: electricLocomotive
)

let freightCarRecipe = Recipe(
    input: [
        .init(heavyModularFrame, amount: 4),
        .init(steelPipe, amount: 10)
    ],
    vehicle: freightCar
)

let VehicleRecipes = [
    tracktorRecipe,
    truckRecipe,
    explorerRecipe,
    cyberWagonRecipe,
    droneRecipe,
    electricLocomotiveRecipe,
    freightCarRecipe
]
