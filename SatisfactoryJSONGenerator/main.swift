import Foundation

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let fileManager = FileManager.default
let home = fileManager.homeDirectoryForCurrentUser
let folder = home.appendingPathComponent("Desktop/Satisfactory/Satisfactory/JSON")

if !fileManager.fileExists(atPath: folder.path) {
    try? fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
}

do {
    try encoder.encode(["parts": Parts]).write(to: folder.appendingPathComponent("parts.json"))
    try encoder.encode(["equipment": Equipments]).write(to: folder.appendingPathComponent("equipment.json"))
    try encoder.encode(["buildings": Buildings]).write(to: folder.appendingPathComponent("buildings.json"))
    try encoder.encode(["vehicles": Vehicles]).write(to: folder.appendingPathComponent("vehicles.json"))
    try encoder.encode(["recipes": Recipes]).write(to: folder.appendingPathComponent("recipes.json"))
} catch {
    print(error)
}

//let ironImpureAmount = 5.0
//let ironNormalAmount = 8.0
//let ironPureAmount = 3.0
//
//// MARK: - Amount of iron ore we can get
//// MARK: - Impure
//let impureOreMK1 = ironImpureAmount * ExtractionRate.impure.rawValue * MinerLevel.mk1.rawValue
//let impureOreMK2 = ironImpureAmount * ExtractionRate.impure.rawValue * MinerLevel.mk2.rawValue
//let impureOreMK3 = ironImpureAmount * ExtractionRate.impure.rawValue * MinerLevel.mk3.rawValue
//
//// MARK: - Normal
//let normalOreMK1 = ironNormalAmount * ExtractionRate.normal.rawValue * MinerLevel.mk1.rawValue
//let normalOreMK2 = ironNormalAmount * ExtractionRate.normal.rawValue * MinerLevel.mk2.rawValue
//let normalOreMK3 = ironNormalAmount * ExtractionRate.normal.rawValue * MinerLevel.mk3.rawValue
//
//// MARK: - Pure
//let pureOreMK1 = ironPureAmount * ExtractionRate.pure.rawValue * MinerLevel.mk1.rawValue
//let pureOreMK2 = ironPureAmount * ExtractionRate.pure.rawValue * MinerLevel.mk2.rawValue
//let pureOreMK3 = ironPureAmount * ExtractionRate.pure.rawValue * MinerLevel.mk3.rawValue
//
//let mk1 = impureOreMK1 + normalOreMK1 + pureOreMK1
//let mk2 = impureOreMK2 + normalOreMK2 + pureOreMK2
//let mk3 = impureOreMK3 + normalOreMK3 + pureOreMK3
//let all = mk1 + mk2 + mk3
//
//print(impureOreMK1, impureOreMK2, impureOreMK3)
//print(normalOreMK1, normalOreMK2, normalOreMK3)
//print(pureOreMK1, pureOreMK2, pureOreMK3)
//print(mk1, mk2, mk3, all)
//
//adaptiveControlUnitRecipe.requirements

//print("""
//\(adaptiveControlUnitRecipe)
//    \(automatedWiringRecipe)
//        \(statorRecipe)
//            \(wireRecipe)
//                \(copperIngotRecipe)
//            \(steelPipeRecipe)
//                \(steelIngotRecipe)
//        \(cableRecipe)
//            \(wireRecipe)
//                \(copperIngotRecipe)
//    \(circuitBoardRecipe)
//        \(copperSheetRecipe)
//            \(copperIngotRecipe)
//        \(plasticResidualRecipe)
//    \(heavyModularFrameRecipe)
//        \(modularFrameRecipe)
//            \(reinforcedIronPlateRecipe)
//                \(ironPlateRecipe)
//                    \(ironIngotRecipe)
//                \(screwRecipe)
//                    \(ironRodRecipe)
//                        \(ironIngotRecipe)
//        \(ironRodRecipe)
//            \(ironIngotRecipe)
//        \(steelPipeRecipe)
//            \(steelIngotRecipe)
//        \(encasedIndustrialBeamRecipe)
//            \(concreteRecipe)
//            \(steelBeamRecipe)
//                \(steelIngotRecipe)
//        \(screwRecipe)
//            \(ironRodRecipe)
//                \(ironIngotRecipe)
//    \(computerRecipe1)
//        \(circuitBoardRecipe)
//            \(copperSheetRecipe)
//                \(copperIngotRecipe)
//            \(plasticResidualRecipe)
//    \(crystalOscillatorRecipe)
//        \(quartzCrystalRecipe)
//        \(cableRecipe)
//            \(wireRecipe)
//                \(copperIngotRecipe)
//        \(reinforcedIronPlateRecipe)
//            \(ironPlateRecipe)
//                \(ironIngotRecipe)
//            \(screwRecipe)
//                \(ironRodRecipe)
//                    \(ironIngotRecipe)
//""")
