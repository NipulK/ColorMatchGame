import SwiftUI

struct LevelSelectionView: View {

    @State private var selectedLevel: GameLevel?
    @State private var showRules = false

    var body: some View {

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
        }
        
        .sheet(isPresented: $showRules) {

            if let level = selectedLevel {
                RulesPopupView(level: level)
            }
        }
    }
}
