import SwiftUI

struct LevelSelectionView: View {

    let playerName: String

    @State private var selectedLevel: GameLevel = .easy
    @State private var showRules = false
    @State private var goToGame = false

    var body: some View {

        ZStack {

            //  LIGHT BACKGROUND
            Color.appBackground
                .ignoresSafeArea()

            VStack(spacing: 24) {

                Spacer(minLength: 40)

                //  TITLE
                Text("Choose Level")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primaryText)

                Text("Select your difficulty")
                    .font(.callout)
                    .foregroundColor(.secondaryText)

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

        // 📜 RULES POPUP (LIGHT UI)
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

        // 🔀 NAVIGATION TO GAME
        .background(
            NavigationLink(
                destination: GameView(
                    level: selectedLevel,
                    playerName: playerName
                ),
                isActive: $goToGame
            ) {
                EmptyView()
            }
        )
    }

    // MARK: - Level Card (Light Style)
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
                    .fill(color.opacity(0.15))
                    .frame(width: 54, height: 54)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(color)
                            .font(.title2)
                    )

                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primaryText)

                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondaryText.opacity(0.6))
            }
            .padding()
            .background(Color.cardBackground)
            .cornerRadius(18)
            .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
        }
        .buttonStyle(PressableButtonStyle())
    }
}
