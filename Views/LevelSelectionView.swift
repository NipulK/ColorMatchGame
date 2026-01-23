import SwiftUI

struct LevelSelectionView: View {

    @State private var selectedLevel: GameLevel = .easy
    @State private var showRules = false
    @State private var goToGame = false

    var body: some View {

        VStack(spacing: 20) {

            Text("Select Level")
                .font(.largeTitle)
                .bold()

            // 🟢 EASY
            Button("Easy (3 × 3)") {
                selectedLevel = .easy
                showRules = true
            }
            .buttonStyle(PressableButtonStyle())

            // 🟡 MEDIUM
            Button("Medium (5 × 5)") {
                selectedLevel = .medium
                showRules = true
            }
            .buttonStyle(PressableButtonStyle())

            // 🔴 HARD
            Button("Hard (7 × 7)") {
                selectedLevel = .hard
                showRules = true
            }
            .buttonStyle(PressableButtonStyle(scale: 0.94))

            // 🔹 HIDDEN NAVIGATION TO GAME
            NavigationLink(
                destination: GameView(level: selectedLevel),
                isActive: $goToGame
            ) {
                EmptyView()
            }
        }
        .sheet(isPresented: $showRules) {

            RulesPopupView(
                level: selectedLevel,
                onConfirm: {
                    showRules = false

                    // small delay so sheet closes cleanly
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        goToGame = true
                    }
                }
            )
        }
    }
}

//
// MARK: - Button Animation Style
//
struct PressableButtonStyle: ButtonStyle {

    var scale: CGFloat = 0.96

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(
                .spring(response: 0.25, dampingFraction: 0.8),
                value: configuration.isPressed
            )
    }
}

//
