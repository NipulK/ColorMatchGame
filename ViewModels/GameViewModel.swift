import SwiftUI
import Combine
import UIKit

class GameViewModel: ObservableObject {

    @Published var cards: [CardModel] = []
    @Published var score: Int = 0
    @Published var isWin = false
    @Published var time: Double = 0
    @Published var state: GameState = .notStarted
    @Published var countdown: Int = 3
    @Published var showCountdown = false
    @Published var showFinishPanel = false

    @Published var playerName: String = "Player"

    private(set) var currentLevel: GameLevel?

    var timer: Timer?
    private var firstIndex: Int? = nil
    private var didSaveResult = false

    enum GameState {
        case notStarted
        case running
        case paused
    }

    func start(level: GameLevel) {

        currentLevel = level
        didSaveResult = false

        cards.removeAll()
        score = 0
        firstIndex = nil
        isWin = false
        time = 0
        showFinishPanel = false
        state = .notStarted

        let total = level.size * level.size
        let pairCount = total / 2

        var colors: [Color] = []

        for _ in 0..<pairCount {
            let randomColor = Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )
            colors.append(randomColor)
            colors.append(randomColor)
        }

        if total % 2 != 0 {
            colors.append(.gray)
        }

        colors.shuffle()
        cards = colors.map { CardModel(color: $0) }
    }

    func startGame() {

        showCountdown = true
        countdown = 3

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.countdown -= 1

            if self.countdown == 0 {
                timer.invalidate()
                self.showCountdown = false
                self.state = .running

                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    self.time += 0.01
                }
            }
        }
    }

    func pauseGame() {
        state = .paused
        timer?.invalidate()
    }

    func resumeGame() {
        state = .running
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.time += 0.01
        }
    }

    func selectCard(index: Int) {

        guard state == .running else { return }
        guard !cards[index].isMatched && !cards[index].isFaceUp else { return }

        cards[index].isFaceUp = true

        if let first = firstIndex {
            checkMatch(first: first, second: index)
            firstIndex = nil
        } else {
            firstIndex = index
        }
    }

    private func checkMatch(first: Int, second: Int) {

        if cards[first].color == cards[second].color {

            cards[first].isMatched = true
            cards[second].isMatched = true
            score += 1

            // ✅ Light match haptic
            playImpact(.light)

            let allMatched = cards.allSatisfy {
                $0.isMatched || $0.color == .gray
            }

            if allMatched {
                handleGameWin()
            }

        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards[first].isFaceUp = false
                self.cards[second].isFaceUp = false
            }
        }
    }

    private func handleGameWin() {

        guard !didSaveResult, let level = currentLevel else { return }

        didSaveResult = true
        isWin = true

        // 🏆 Strong success haptic
        playSuccess()

        timer?.invalidate()
        state = .paused

        let result = GameResult(
            playerName: playerName,
            score: score,
            time: time,
            level: level
        )

        ScoreboardManager.shared.save(result)

        Task {
            await showFinishWithDelay()
        }
    }

    @MainActor
    func showFinishWithDelay() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        showFinishPanel = true
    }

    // MARK: - Haptics
    private func playImpact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }

    private func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
}
