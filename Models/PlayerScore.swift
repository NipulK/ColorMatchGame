import Foundation

struct PlayerScore: Identifiable, Codable {

    let id: String
    let playerName: String
    let level: String
    let timeSpent: Double
    let points: Int
    let createdAt: Date

    init(
        playerName: String,
        level: String,
        timeSpent: Double,
        points: Int
    ) {
        self.id = UUID().uuidString
        self.playerName = playerName
        self.level = level
        self.timeSpent = timeSpent
        self.points = points
        self.createdAt = Date()
    }
}
