import SwiftUI

struct HomeView: View {

    @State private var goToDashboard = false
    @State private var playerName: String = ""
    @State private var showNamePopup = false

    var body: some View {

        NavigationView {
            ZStack {

                //  LIGHT BACKGROUND
                Color.appBackground
                    .ignoresSafeArea()

                VStack(spacing: 28) {

                    Spacer()

                    //  LOGO
                    ZStack {
                        Circle()
                            .fill(Color.accentSoft)
                            .frame(width: 100, height: 100)

                        Image(systemName: "square.grid.3x3.fill")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.accent)
                    }

                    Text("Color Craze")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primaryText)

                    Text("A Color Memory Challenge")
                        .font(.callout)
                        .foregroundColor(.secondaryText)

                    Spacer()

                    //  PLAY
                    Button {
                        showNamePopup = true
                    } label: {
                        Text("PLAY")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accent)
                            .cornerRadius(16)
                            .shadow(color: .accent.opacity(0.3), radius: 10)
                    }
                    .sheet(isPresented: $showNamePopup) {
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
                    }

                    // 🏆 SCOREBOARD
                    NavigationLink(destination: ScoreboardView()) {
                        Text("SCOREBOARD")
                            .font(.subheadline)
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cardBackground)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.05), radius: 8)
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 28)

                // 🔀 NAVIGATION
                NavigationLink(
                    destination: LevelSelectionView(playerName: playerName),
                    isActive: $goToDashboard
                ) { EmptyView() }
            }
        }
        .buttonStyle(PressableButtonStyle())
    }
}
