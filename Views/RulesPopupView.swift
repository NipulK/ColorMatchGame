import SwiftUI

struct RulesPopupView: View {

    let level: GameLevel
    let onConfirm: () -> Void

    var body: some View {

        ZStack {

            Color.black.opacity(0.25)
                .ignoresSafeArea()

            VStack(spacing: 22) {

                VStack(spacing: 10) {
                    Circle()
                        .fill(Color.accentSoft)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Image(systemName: "gamecontroller.fill")
                                .foregroundColor(.accent)
                                .font(.system(size: 26))
                        )

                    Text("How to Play")
                        .font(.title2.bold())
                        .foregroundColor(.primaryText)

                    Text(levelTitle)
                        .font(.subheadline)
                        .foregroundColor(.accent)
                }

                Divider()

                VStack(alignment: .leading, spacing: 14) {
                    ruleRow("Tap a card to reveal its color")
                    ruleRow("Match two cards with the same color")
                    ruleRow("Matched cards stay open")
                    ruleRow("Complete all matches to win")
                }

                Button {
                    onConfirm()
                } label: {
                    Text("START GAME")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accent)
                        .cornerRadius(14)
                }
            }
            .padding(24)
            .background(Color.cardBackground)
            .cornerRadius(26)
            .padding(.horizontal, 28)
        }
    }

    private func ruleRow(_ text: String) -> some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.accent)
            Text(text)
                .foregroundColor(.primaryText)
        }
    }

    private var levelTitle: String {
        switch level {
        case .easy: return "Easy • 3×3"
        case .medium: return "Medium • 5×5"
        case .hard: return "Hard • 7×7"
        }
    }
}
