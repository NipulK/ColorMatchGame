import SwiftUI

struct LevelSelectionView: View {

    @State private var selectedLevel: GameLevel? = nil
    @State private var showRules = false
    @State private var goToGame = false

    var body: some View {

        NavigationView {

            VStack(spacing: 20) {

                Text("Select Level")
                    .font(.largeTitle)
                    .bold()

                Button("Easy (3 × 3)") {
                    selectedLevel = .easy
                    showRules = true
                }

                Button("Medium (5 × 5)") {
                    selectedLevel = .medium
                    showRules = true
                }

                Button("Hard (7 × 7)") {
                    selectedLevel = .hard
                    showRules = true
                }

                // 🔹 NAVIGATION TO GAME (hidden)
                NavigationLink(
                    destination: {
                        if let level = selectedLevel {
                            GameView(level: level)
                        }
                    },
                    isActive: $goToGame
                ) {
                    EmptyView()
                }
            }
            .sheet(isPresented: $showRules) {
                if let level = selectedLevel {
                    RulesPopupView(
                        level: level,
                        onConfirm: {
                            showRules = false
                            goToGame = true
                        }
                    )
                }
            }
        }
    }
}
