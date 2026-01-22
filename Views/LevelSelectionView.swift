import SwiftUI

struct LevelSelectionView: View {

    @State private var selectedLevel: GameLevel = .easy
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

                // ✅ HIDDEN NAVIGATION (SAFE)
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

                        // delay to allow sheet dismissal
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            goToGame = true
                        }
                    }
                )
            }
            
        }
    }
}
