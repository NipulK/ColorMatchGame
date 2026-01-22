import SwiftUI

struct HomeView: View {

    @State private var goToDashboard = false

    var body: some View {

        NavigationView {

            ZStack {

                // 🌌 BACKGROUND
                LinearGradient(
                    colors: [Color(red: 0.15, green: 0.18, blue: 0.35),
                             Color(red: 0.08, green: 0.09, blue: 0.20)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {

                    Spacer()

                    // 🎨 GAME ICON
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.pink, .orange, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                        .overlay(
                            Image(systemName: "square.grid.3x3.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        )
                        .shadow(radius: 10)

                    // 🧩 TITLE
                    Text("Color Match")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)

                    Text("Color Matching Game")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))

                    Spacer()

                    // ▶️ START PLAYING
                    NavigationLink(
                        destination: LevelSelectionView(),
                        isActive: $goToDashboard
                    ) {
                        Button {
                            goToDashboard = true
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("START PLAYING")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(14)
                            .shadow(radius: 5)
                        }
                    }

                    // 🏆 SCOREBOARD (for now Quit / placeholder)
                    Button {
                        exit(0) // can be replaced with Scoreboard later
                    } label: {
                        HStack {
                            Image(systemName: "trophy.fill")
                            Text("SCOREBOARD")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(14)
                        .shadow(radius: 5)
                    }

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
        }
    }
}
