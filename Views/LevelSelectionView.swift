import SwiftUI

struct LevelSelectionView: View {

    let playerName: String   // ✅ NEW

    @State private var selectedLevel: GameLevel = .easy
    @State private var showRules = false
    @State private var goToGame = false

    var body: some View {

        ZStack {

            // 🌌 SAME BACKGROUND AS HOME
            LinearGradient(
                colors: [
                    Color(hex: "#0F2027"),
                    Color(hex: "#203A43"),
                    Color(hex: "#2C5364")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                Spacer(minLength: 40)

                // 🎮 TITLE
                Text("Choose Level")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)

                Text("Select your difficulty")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.6))

                Spacer(minLength: 20)

                // 🟢 EASY
                levelCard(
                    title: "Easy",
                    subtitle: "3 × 3 Grid",
                    icon: "leaf.fill",
                    color: .green,
                    level: .easy
                )

                // 🟡 MEDIUM
                levelCard(
                    title: "Medium",
                    subtitle: "5 × 5 Grid",
                    icon: "flame.fill",
                    color: .orange,
                    level: .medium
                )

                // 🔴 HARD
                levelCard(
                    title: "Hard",
                    subtitle: "7 × 7 Grid",
                    icon: "bolt.fill",
                    color: .red,
                    level: .hard
                )

                Spacer()
            }
            .padding(.horizontal, 28)
        }

        // 📜 RULES POPUP
        .sheet(isPresented: $showRules) {
            RulesPopupView(
                level: selectedLevel,
                onConfirm: {
                    showRules = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        goToGame = true
                    }
                }
            )
        }

        // 🔀 HIDDEN NAVIGATION
        .background(
            NavigationLink(
                destination: GameView(
                    level: selectedLevel,
                    playerName: playerName   // ✅ PASS NAME
                ),
                isActive: $goToGame
            ) {
                EmptyView()
            }
        )
    }

    // MARK: - Level Card UI
    private func levelCard(
        title: String,
        subtitle: String,
        icon: String,
        color: Color,
        level: GameLevel
    ) -> some View {

        Button {
            selectedLevel = level
            showRules = true
        } label: {

            HStack(spacing: 16) {

                Circle()
                    .fill(color.opacity(0.25))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(color)
                            .font(.title2)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .cornerRadius(16)
        }
        .buttonStyle(PressableButtonStyle())
    }
}
