import SwiftUI

struct RulesPopupView: View {

    let level: GameLevel
    let onConfirm: () -> Void

    var body: some View {

        ZStack {

            // 🌫 DIMMED BACKGROUND
            Color.black.opacity(0.65)
                .ignoresSafeArea()

            // 🧊 CENTERED CARD (NOT FULL HEIGHT)
            VStack(spacing: 22) {

                // 🎮 TITLE
                Text("How to Play")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                // 🎯 LEVEL INFO
                Text(levelTitle)
                    .font(.subheadline)
                    .foregroundColor(levelColor)

                Divider()
                    .background(Color.white.opacity(0.25))

                // 📜 RULES LIST
                VStack(alignment: .leading, spacing: 14) {
                    ruleRow("Tap a card to reveal its color")
                    ruleRow("Match two cards with the same color")
                    ruleRow("Matched cards stay open")
                    ruleRow("Complete all matches to win")
                    ruleRow("Finish faster to get a better score")
                }

                // ▶️ ACTION BUTTON
                Button {
                    onConfirm()
                } label: {
                    Text("OK, START GAME")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .buttonStyle(PressableButtonStyle())
                .padding(.top, 8)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(hex: "#1C1F2A"))
            )
            .padding(.horizontal, 28)
        }
    }

    // MARK: - Rule Row
    private func ruleRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)

            Text(text)
                .font(.callout)
                .foregroundColor(.white.opacity(0.9))
        }
    }

    
    // MARK: - Level Title
    private var levelTitle: String {
        switch level {
        case .easy:
            return "Easy Level • 3 × 3 Grid"
        case .medium:
            return "Medium Level • 5 × 5 Grid"
        case .hard:
            return "Hard Level • 7 × 7 Grid"
        }
    }

    // MARK: - Level Color
    private var levelColor: Color {
        switch level {
        case .easy:
            return .green
        case .medium:
            return .orange
        case .hard:
            return .red
        }
    }
}
