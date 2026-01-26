import Foundation

final class ScoreboardManager {

    static let shared = ScoreboardManager()

    private let storageKey = "game_results"

    private init() {}

    // MARK: - Save Game Result
    func save(_ result: GameResult) {

        var results = loadResults()
        results.append(result)

        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    // MARK: - Load All Results
    func loadResults() -> [GameResult] {

        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([GameResult].self, from: data)
        else {
            return []
        }

        return decoded
    }

    // MARK: - Top Scores (Leaderboard)
    func topScores(limit: Int = 10) -> [GameResult] {

        return loadResults()
            .sorted {
                if $0.score == $1.score {
                    return $0.time < $1.time   // faster wins tie
                }
                return $0.score > $1.score
            }
            .prefix(limit)
            .map { $0 }
    }
}
