import SwiftUI

struct HomeView: View {

    @State private var goToDashboard = false

    var body: some View {

        NavigationView {
            

            ZStack {

                // 🌌 CLEAN DARK BACKGROUND
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

                    // 🎨 LOGO WITH SOFT GLOW
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

                    // 🎮 GAME TITLE
                    Text("Color Craze")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)

                    // ✨ TAGLINE
                    Text("A Color Memory Challenge")
                        .font(.callout)
                        .foregroundColor(.white.opacity(0.6))

                    Spacer()

                    // ▶️ PRIMARY ACTION
                    NavigationLink(
                        destination: LevelSelectionView(),
                        isActive: $goToDashboard
                    ) {
                        Button {
                            goToDashboard = true
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
                    }

                    // 🏆 SECONDARY ACTION
                    Button {
                        exit(0) // placeholder
                    } label: {
                        Text("SCOREBOARD")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.12))
                            .cornerRadius(16)
                    }

                    Spacer(minLength: 30)
                }
                .padding(.horizontal, 28)
            }
        }
    }
}


//colour

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

