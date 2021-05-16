private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .quaterPipes)
    }
}

let quarterPipe = Building(name: "Quarter Pipe")
let invertedQuarterPipe = Building(name: "Inverted Quarter Pipe")
let innerCornerQuarterPipe = Building(name: "Inner Corner Quarter Pipe")
let invertedInnerCornerQuarterPipe = Building(name: "Inverted Inner Corner Quarter Pipe")
let outerCornerQuarterPipe = Building(name: "Outer Corner Quarter Pipe")
let invertedOuterCornerQuarterPipe = Building(name: "Inverted Outer Corner Quarter Pipe")

let QuaterPipes = [
    quarterPipe,
    invertedQuarterPipe,
    innerCornerQuarterPipe,
    invertedInnerCornerQuarterPipe,
    outerCornerQuarterPipe,
    invertedOuterCornerQuarterPipe
]
