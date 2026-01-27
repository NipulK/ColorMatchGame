import SwiftUI

struct RulesPopupView: View {

    let level: GameLevel
    let onConfirm: () -> Void

    var body: some View {

        ZStack {

            // 🌫 DIMMED BACKGROUND
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            // 🧊 POPUP CARD
            VStack(spacing: 22) {

                // 🔶 HEADER
                VStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(levelColor.opacity(0.25))
                            .frame(width: 64, height: 64)

                        Image(systemName: "gamecontroller.fill")
                            .font(.system(size: 28))
                            .foregroundColor(levelColor)
                    }

                    Text("How to Play")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)

                    Text(levelTitle)
                        .font(.subheadline)
                        .foregroundColor(levelColor)
                }

                Divider()
                    .background(Color.white.opacity(0.2))

                // 📜 RULES
                VStack(alignment: .leading, spacing: 14) {
                    ruleRow("Tap a card to reveal its color")
                    ruleRow("Match two cards with the same color")
                    ruleRow("Matched cards stay open")
                    ruleRow("Complete all matches to win")
                    ruleRow("Finish faster to get a better score")
                }

                // ▶️ START BUTTON
                Button {
                    onConfirm()
                } label: {
                    Text("START GAME")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(levelColor)
                        .cornerRadius(14)
                }
                .buttonStyle(PressableButtonStyle())
                .padding(.top, 8)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(hex: "#1C1F2A"))
                    .shadow(color: levelColor.opacity(0.35), radius: 20)
            )
            .padding(.horizontal, 28)
        }
        .transition(.scale.combined(with: .opacity))
    }

    
    // MARK: - Rule Row
    private func ruleRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(levelColor)

            Text(text)
                .font(.callout)
                .foregroundColor(.white.opacity(0.9))
        }
    }

    // MARK: - Level Title
    private var levelTitle: String {
        switch level {
        case .easy:
            return "Easy • 3 × 3 Grid"
        case .medium:
            return "Medium • 5 × 5 Grid"
        case .hard:
            return "Hard • 7 × 7 Grid"
        }
    }

    // MARK: - Level Accent Color
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
