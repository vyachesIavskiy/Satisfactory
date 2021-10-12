import Foundation

struct Milestone {
    let id = UUID()
    let tier: Tier
    let tierPosition: Int
    let name: String
    let unlocks: [UUID]
    let cost: [UUID: Int]
}
