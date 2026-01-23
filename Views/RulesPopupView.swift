import SwiftUI

struct RulesPopupView: View {

    var level: GameLevel
    var onConfirm: () -> Void

    var body: some View {

        VStack(spacing: 20) {

            Text("How to Play")
                .font(.title)
                .bold()

            VStack(alignment: .leading, spacing: 10) {

                Text("• Cards are hidden")
                Text("• Tap two cards to match colors")
                Text("• Matching colors give points")
                Text("• Wrong match flips cards back")
                Text("• Complete all pairs to finish the level")
                Text("• You can pause and resume the game")
            }

            
            Spacer()

            Button("OK") {
                onConfirm()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
