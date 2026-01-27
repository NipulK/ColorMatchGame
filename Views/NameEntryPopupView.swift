import SwiftUI

struct NameEntryPopupView: View {

    @Binding var playerName: String
    let onContinue: () -> Void
    let onCancel: () -> Void

    var body: some View {

        ZStack {

            // 🌫 DIMMED BACKGROUND
            Color.black.opacity(0.65)
                .ignoresSafeArea()

            // 🧊 CENTER CARD
            VStack(spacing: 22) {

                // 🎮 TITLE
                Text("Enter Your Name")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                Text("This name will appear on the scoreboard")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)

                // 👤 INPUT FIELD
                TextField("Player name", text: $playerName)
                    .padding()
                    .background(Color.white.opacity(0.12))
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.words)

                // ▶️ CONTINUE
                Button {
                    if !playerName.trimmingCharacters(in: .whitespaces).isEmpty {
                        onContinue()
                    }
                } label: {
                    Text("CONTINUE")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .buttonStyle(PressableButtonStyle())

                // ❌ CANCEL
                Button {
                    onCancel()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(hex: "#1C1F2A"))
            )
            .padding(.horizontal, 28)
        }
        .transition(.scale.combined(with: .opacity))
    }
}
