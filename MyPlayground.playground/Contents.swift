struct Recipe {
    let produce: [Int]
    let need: [Int]
    let time: Int
}

let reinforcedIronPlate = Recipe(produce: [1], need: [6, 12], time: 12)
let screw = Recipe(produce: [4], need: [1], time: 6)
let ironPlate = Recipe(produce: [2], need: [3], time: 6)
let ironRod = Recipe(produce: [1], need: [1], time: 4)
let ironIngot = Recipe(produce: [1], need: [1], time: 2)

let screwTimeMulti = Double(reinforcedIronPlate.time) / Double(screw.time)
let screwMulti = (Double(reinforcedIronPlate.need[1]) / (Double(screw.produce[0]) * screwTimeMulti)).rounded(.up)

let ironPlateTimeMulti = Double(reinforcedIronPlate.time) / Double(ironPlate.time)
let ironPlateMulti = (Double(reinforcedIronPlate.need[0]) / (Double(ironPlate.produce[0]) * ironPlateTimeMulti)).rounded(.up)

let ironRodTimeMulti = Double(screw.time) / Double(ironRod.time)
let ironRodMulti = (Double(screw.need[0]) * screwMulti / (Double(ironRod.produce[0]) * ironRodTimeMulti)).rounded(.up)

let ironIngotPlateTimeMulti = Double(ironPlate.time) / Double(ironIngot.time)
let ironIngotPlateMulti = Double(ironPlate.need[0]) * ironPlateMulti / (Double(ironIngot.produce[0]) * ironIngotPlateTimeMulti)

let ironIngotRodTimeMulti = Double(ironRod.time) / Double(ironIngot.time)
let ironIngotRodMulti = Double(ironRod.need[0]) * ironRodMulti / (Double(ironIngot.produce[0]) * ironIngotRodTimeMulti)

let ironIngotAmount = Double(ironIngot.produce[0]) * ironIngotPlateMulti * ironIngotPlateTimeMulti
    + Double(ironIngot.produce[0]) * ironIngotRodMulti * ironIngotRodTimeMulti
let ironRodAmount = Double(ironRod.produce[0]) * ironRodMulti * ironRodTimeMulti
let ironPlateAmount = Double(ironPlate.produce[0]) * ironPlateMulti * ironPlateTimeMulti
let screwAmount = Double(screw.produce[0]) * screwMulti * screwTimeMulti
