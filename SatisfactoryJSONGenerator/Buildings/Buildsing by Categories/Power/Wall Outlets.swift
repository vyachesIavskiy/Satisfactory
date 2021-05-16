private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .wallOutlets)
    }
}

let wallOutletMK1 = Building(name: "Wall Outlet MK.1")
let wallOutletMK2 = Building(name: "Wall Outlet MK.2")
let wallOutletMK3 = Building(name: "Wall Outlet MK.3")
let doubleWallOutletMK1 = Building(name: "Double Wall Outlet MK.1")
let doubleWallOutletMK2 = Building(name: "Double Wall Outlet MK.2")
let doubleWallOutletMK3 = Building(name: "Double Wall Outlet MK.3")

let WallPoles = [
    wallOutletMK1,
    wallOutletMK2,
    wallOutletMK3,
    doubleWallOutletMK1,
    doubleWallOutletMK2,
    doubleWallOutletMK3
]
