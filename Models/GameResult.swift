import Foundation

struct GameResult: Identifiable, Codable {

    let id: UUID
    let playerName: String
    let score: Int
    let time: Double
    let level: GameLevel
    let date: Date

    init(
        playerName: String,
        score: Int,
        time: Double,
        level: GameLevel,
        date: Date = Date()
    ) {
        self.id = UUID()
        self.playerName = playerName
        self.score = score
        self.time = time
        self.level = level
        self.date = date
    }
}
