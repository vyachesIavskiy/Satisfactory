import Foundation

struct PartNetwork: Codable {
    let id: String
    let name: String
    let partType: String
    let tier: Int
    let milestone: Int
    let sortingPriority: Int
    let rawResource: Bool
}
