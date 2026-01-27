import SwiftUI

struct NameEntryPopupView: View {

    @Binding var playerName: String
    let onContinue: () -> Void
    let onCancel: () -> Void

    // Accent color (can be changed later)
    private let accentColor: Color = .orange

    var body: some View {

        
        ZStack {

            // 🌫 DIMMED BACKGROUND
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            // 🧊 POPUP CARD
            VStack(spacing: 22) {

                // 🔶 HEADER (Same style as RulesPopupView)
                VStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(accentColor.opacity(0.25))
                            .frame(width: 64, height: 64)

                        Image(systemName: "person.fill")
                            .font(.system(size: 28))
                            .foregroundColor(accentColor)
                    }

                    Text("Enter Your Name")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)

                    Text("This name will appear on the scoreboard")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }

                Divider()
                    .background(Color.white.opacity(0.2))

                // 👤 NAME INPUT
                VStack(spacing: 10) {

                    TextField("Player name", text: $playerName)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .multilineTextAlignment(.center)
                        .textInputAutocapitalization(.words)

                    if playerName.trimmingCharacters(in: .whitespaces).isEmpty {
                        Text("Please enter your name to continue")
                            .font(.caption)
                            .foregroundColor(.red.opacity(0.8))
                    }
                }

                // ▶️ CONTINUE BUTTON
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
                        .background(accentColor)
                        .cornerRadius(14)
                }
                .buttonStyle(PressableButtonStyle())
                .padding(.top, 6)

                // ❌ CANCEL
                Button {
                    onCancel()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.75))
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color(hex: "#1C1F2A"))
                    .shadow(color: accentColor.opacity(0.35), radius: 20)
            )
            .padding(.horizontal, 28)
        }
        .transition(.scale.combined(with: .opacity))
    }
}
