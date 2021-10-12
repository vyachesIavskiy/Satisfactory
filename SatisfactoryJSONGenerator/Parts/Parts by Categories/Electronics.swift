private extension Part {
    init(name: String, tier: Tier, milestone: Int, sortingPriority: Int) {
        self.init(name: name, partType: .electronics, tier: tier, milestone: milestone, sortingPriority: sortingPriority)
    }
}

let wire = Part(name: "Wire", tier: .tier0, milestone: 1, sortingPriority: 40)
let cable = Part(name: "Cable", tier: .tier0, milestone: 1, sortingPriority: 41)
let quickwire = Part(name: "Quickwire", tier: .tier6, milestone: 0, sortingPriority: 55)
let aiLimiter = Part(name: "AI Limiter", tier: .tier6, milestone: 0, sortingPriority: 68)
let circuitBoard = Part(name: "Circuit Board", tier: .tier5, milestone: 0, sortingPriority: 67)
let highSpeedConnector = Part(name: "High-Speed Connector", tier: .tier6, milestone: 0, sortingPriority: 94)


let Electronics = [
    wire,
    cable,
    quickwire,
    aiLimiter,
    circuitBoard,
    highSpeedConnector
]
