import SwiftUI

struct NameEntryPopupView: View {

    @Binding var playerName: String
    let onContinue: () -> Void
    let onCancel: () -> Void

    var body: some View {

        ZStack {

            Color.black.opacity(0.25)
                .ignoresSafeArea()

            VStack(spacing: 22) {

                // HEADER
                VStack(spacing: 10) {
                    Circle()
                        .fill(Color.accentSoft)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.accent)
                                .font(.system(size: 26))
                        )

                    Text("Enter Your Name")
                        .font(.title2.bold())
                        .foregroundColor(.primaryText)

                    Text("This name will appear on the scoreboard")
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }

                Divider()

                // INPUT
                TextField("Player name", text: $playerName)
                    .padding()
                    .background(Color.appBackground)
                    .cornerRadius(12)
                    .multilineTextAlignment(.center)

                // CONTINUE
                Button {
                    if !playerName.isEmpty {
                        onContinue()
                    }
                } label: {
                    Text("CONTINUE")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accent)
                        .cornerRadius(14)
                }

                Button("Cancel", action: onCancel)
                    .foregroundColor(.secondaryText)
            }
            .padding(24)
            .background(Color.cardBackground)
            .cornerRadius(26)
            .padding(.horizontal, 28)
        }
    }
}
