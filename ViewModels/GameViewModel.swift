import SwiftUI
import Combine

class GameViewModel: ObservableObject {

    @Published var cards: [CardModel] = []
    @Published var score: Int = 0
    @Published var isWin = false
    
    @Published var time: Double = 0
    
    @Published var state: GameState = .notStarted
    
    @Published var countdown: Int = 3
    @Published var showCountdown = false

    // 🔵 NEW - for delayed finish panel
    @Published var showFinishPanel = false

    var timer: Timer?

    private var firstIndex: Int? = nil
    
    enum GameState {
        case notStarted
        case running
        case paused
    }

    // Prepare cards BUT do not start timer
    func start(level: GameLevel) {

        cards.removeAll()
        score = 0
        firstIndex = nil
        isWin = false

        // 🔵 reset finish panel
        showFinishPanel = false

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

        // Important: game not started yet
        time = 0
        state = .notStarted
    }

    // 🔵 START BUTTON PRESSED
    func startGame() {

        showCountdown = true
        countdown = 3

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in

            self.countdown -= 1

            if self.countdown == 0 {
                timer.invalidate()

                self.showCountdown = false
                self.state = .running

                // Start real game timer
                self.timer?.invalidate()

                self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    self.time += 0.01
                }
            }
        }
    }

    // 🔵 PAUSE BUTTON
    func pauseGame() {

        state = .paused
        timer?.invalidate()
    }

    // 🔵 RESUME BUTTON
    func resumeGame() {

        state = .running

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.time += 0.01
        }
    }

    // when user tap
    func selectCard(index: Int) {

        if state != .running {
            return
        }

        if cards[index].isMatched || cards[index].isFaceUp {
            return
        }

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

            let allMatched = cards.allSatisfy {
                $0.isMatched || $0.color == .gray
            }

            if allMatched {

                isWin = true

                // stop timer immediately
                timer?.invalidate()
                state = .paused

                // ✅ ASYNC AWAIT DELAY
                Task {
                    await showFinishWithDelay()
                }
            }

        } else {

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                self.cards[first].isFaceUp = false
                self.cards[second].isFaceUp = false
            }
        }
    }

    //  ASYNC DELAY FUNCTION
    @MainActor
    func showFinishWithDelay() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        showFinishPanel = true
    }
}
