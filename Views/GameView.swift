import SwiftUI

struct GameView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var vm = GameViewModel()
    var level: GameLevel

    var body: some View {

        ZStack {

            // 🌌 BACKGROUND (match Home UI)
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

            VStack(spacing: 16) {

                // TOP BAR
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // 🧠 HUD
                VStack(spacing: 6) {
                    Text("Score \(vm.score)")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(String(format: "Time %.2f s", vm.time))
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }

                // ▶️ START / PAUSE / RESUME
                if vm.state == .notStarted {
                    primaryButton("START GAME", action: vm.startGame)
                }

                if vm.state == .running {
                    secondaryButton("PAUSE", color: .orange, action: vm.pauseGame)
                }

                if vm.state == .paused && !vm.isWin {
                    secondaryButton("RESUME", color: .blue, action: vm.resumeGame)
                }

                // 🟦 GAME GRID
                let columns = Array(repeating: GridItem(.flexible()), count: level.size)

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(vm.cards.indices, id: \.self) { i in
                        CardView(card: vm.cards[i])
                            .onTapGesture {
                                vm.selectCard(index: i)
                            }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(20)
                .padding(.horizontal)
                .blur(radius: (vm.state != .running || vm.showCountdown || vm.isWin) ? 8 : 0)
                .disabled(vm.state != .running || vm.showCountdown || vm.isWin)

                Spacer()
            }

            // 🏆 FINISH PANEL
            if vm.showFinishPanel {
                finishOverlay
            }

            // ⏱ COUNTDOWN
            if vm.showCountdown {
                countdownOverlay
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.start(level: level)
        }
    }

    // MARK: - UI Components

    private func primaryButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
        }
        .buttonStyle(PressableButtonStyle())
        .padding(.horizontal, 40)
    }

    private func secondaryButton(
        _ title: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(color.opacity(0.8))
                .cornerRadius(12)
        }
        .buttonStyle(PressableButtonStyle())
    }

    // MARK: - Overlays

    private var finishOverlay: some View {
        ZStack {
            Color.black.opacity(0.65).ignoresSafeArea()

            VStack(spacing: 14) {
                Text("🏆 Level Completed")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Text(String(format: "Time %.2f s", vm.time))
                    .foregroundColor(.white.opacity(0.8))

                Text("Score \(vm.score)")
                    .foregroundColor(.white.opacity(0.8))

                primaryButton("PLAY AGAIN") {
                    vm.start(level: level)
                }
            }
            .padding(24)
            .background(Color(hex: "#1C1F2A"))
            .cornerRadius(24)
            .padding(.horizontal, 40)
        }
    }

    private var countdownOverlay: some View {
        ZStack {
            Color.black.opacity(0.75).ignoresSafeArea()

            Text(vm.countdown > 0 ? "\(vm.countdown)" : "GO!")
                .font(.system(size: 120, weight: .heavy))
                .foregroundColor(.white)
        }
    }
}
