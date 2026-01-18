import SwiftUI
import Combine  //@Published are provided by the Combine framework

class GameViewModel: ObservableObject {

    @Published var cards: [CardModel] = []
    @Published var score: Int = 0

    private var firstIndex: Int? = nil

    // Start game for selected level
    func start(level: GameLevel) {

        cards.removeAll()
        score = 0
        firstIndex = nil

        let total = level.size * level.size
        let pairCount = total / 2

        var colors: [Color] = []

        // create color pairs
        for _ in 0..<pairCount {

            let randomColor = Color(
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )

            colors.append(randomColor)
            colors.append(randomColor)
        }

        // if odd (3x3 = 9)
        if total % 2 != 0 {
            colors.append(.gray)
        }

        colors.shuffle()

        cards = colors.map { CardModel(color: $0) }
    }

    // when user tap
    func selectCard(index: Int) {

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

    // check match logic
    private func checkMatch(first: Int, second: Int) {

        if cards[first].color == cards[second].color {

            cards[first].isMatched = true
            cards[second].isMatched = true

            score += 1

        } else {

            // hide after milliseconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                self.cards[first].isFaceUp = false
                self.cards[second].isFaceUp = false
            }
        }
    }
}

