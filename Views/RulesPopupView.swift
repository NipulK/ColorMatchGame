import SwiftUI

struct RulesPopupView: View {

    var level: GameLevel
    @Environment(\.dismiss) var dismiss
    @State private var goToGame = false

    var body: some View {

        NavigationView {

            VStack(spacing: 20) {

                Text("How to Play")
                    .font(.title)
                    .bold()

                VStack(alignment: .leading, spacing: 10) {

                    Text("• Cards are hidden")
                    Text("• Tap two cards to match colors")
                    Text("• Matching colors give points")
                    Text("• Wrong match will flip back")
                    Text("• Complete all pairs to finish level")
                    Text("• You can pause and resume the game")

                }

                Spacer()

                NavigationLink(
                    destination: GameView(level: level),
                    isActive: $goToGame
                ) {
                    Button("OK") {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            goToGame = true
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
