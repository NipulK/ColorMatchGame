import Foundation
import Combine

final class ScoreboardViewModel: ObservableObject {

    @Published var allResults: [GameResult] = []
    @Published var selectedLevel: GameLevel? = nil

    init() {
        load()
    }

    func load() {
        allResults = ScoreboardManager.shared.loadResults()
    }

    // MARK: - Filtered Results
    var filteredResults: [GameResult] {
        guard let level = selectedLevel else { return allResults }
        return allResults.filter { $0.level == level }
    }

    // MARK: - Leaderboard (Top Scores)
    var topScores: [GameResult] {
        filteredResults
            .sorted {
                if $0.score == $1.score {
                    return $0.time < $1.time
                }
                return $0.score > $1.score
            }
            .prefix(10)
            .map { $0 }
    }
}
