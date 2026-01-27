import SwiftUI

struct HomeView: View {

    @State private var goToDashboard = false

    // Player name states
    @State private var playerName: String = ""
    @State private var showNamePopup = false

    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(
                    colors: [
                        Color(hex: "#0F2027"),
                        Color(hex: "#203A43"),
                        Color(hex: "#2C5364")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 28) {

                    Spacer()

                    // 🎨 LOGO
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 110, height: 110)

                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.pink, .orange, .yellow],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                            .shadow(color: .orange.opacity(0.6), radius: 15)

                        Image(systemName: "square.grid.3x3.fill")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                    }

                    // 🎮 TITLE
                    Text("Color Craze")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)

                    // ✨ TAGLINE
                    Text("A Color Memory Challenge")
                        .font(.callout)
                        .foregroundColor(.white.opacity(0.6))

                    Spacer()

                    // ▶️ PLAY BUTTON
                    Button {
                        showNamePopup = true
                    } label: {
                        Text("PLAY")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.25), radius: 8)
                    }

                    // 🏆 SCOREBOARD
                    NavigationLink(destination: ScoreboardView()) {
                        Text("SCOREBOARD")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(16)
                    }

                    // 🚪 EXIT
                    Button {
                        exit(0)
                    } label: {
                        Text("EXIT")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.7))
                            .cornerRadius(16)
                    }

                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 28)

                // 🔀 HIDDEN NAVIGATION
                NavigationLink(
                    destination: LevelSelectionView(
                        playerName: playerName.trimmingCharacters(in: .whitespaces).isEmpty
                        ? "Player"
                        : playerName
                    ),
                    isActive: $goToDashboard
                ) {
                    EmptyView()
                }
            }
        }
        .buttonStyle(PressableButtonStyle())

        // 👤 CUSTOM NAME POPUP
        if showNamePopup {
            NameEntryPopupView(
                playerName: $playerName,
                onContinue: {
                    showNamePopup = false
                    goToDashboard = true
                },
                onCancel: {
                    showNamePopup = false
                }
                
            )
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: showNamePopup)
        }
    }
}
