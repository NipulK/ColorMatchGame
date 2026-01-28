import SwiftUI

struct GameView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var vm = GameViewModel()
    @State private var showConfetti = false //show game win animation

    let level: GameLevel
    let playerName: String

    var body: some View {
        
        

        ZStack {

            //  LIGHT BACKGROUND
            Color.appBackground
                .ignoresSafeArea()

            VStack(spacing: 16) {

                //  TOP BAR
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.primaryText)
                    }

                    Spacer()

                    Text(playerName)
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                // 🧠 HUD
                VStack(spacing: 6) {
                    Text("Score \(vm.score)")
                        .font(.headline)
                        .foregroundColor(.primaryText)

                    Text(String(format: "Time %.2f s", vm.time))
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }
                .padding(.top, 16)

                // ▶️ CONTROLS
                if vm.state == .notStarted {
                    primaryButton("START GAME", action: vm.startGame)
                }

                if vm.state == .running {
                    secondaryButton("PAUSE", color: .accent, action: vm.pauseGame)
                }

                if vm.state == .paused && !vm.isWin {
                    secondaryButton("RESUME", color: .accent, action: vm.resumeGame)
                }

                Spacer(minLength: 20)

                // 🟦 CARD GRID
                let columns = Array(
                    repeating: GridItem(.flexible()),
                    count: level.size
                )

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(vm.cards.indices, id: \.self) { i in
                        CardView(card: vm.cards[i])
                            .onTapGesture {
                                vm.selectCard(index: i)
                            }
                    }
                }
                .padding()
                .background(Color.cardBackground)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.08), radius: 12)
                .padding(.horizontal)
                .disabled(vm.state != .running)

                Spacer()
            }
            
            //  CONFETTI
            if showConfetti {
                ConfettiView()
                    .transition(.opacity)
            }

            // 🏆 FINISH OVERLAY
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
            vm.playerName = playerName
            vm.start(level: level)
        }
        .onChange(of: vm.isWin) { win in
            if win {
                showConfetti = true

                // Auto-hide confetti after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showConfetti = false
                }
            }
        }
    }

    // MARK: - Buttons

    private func primaryButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accent)
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
                .background(color)
                .cornerRadius(12)
        }
        .buttonStyle(PressableButtonStyle())
    }

    // MARK: - Overlays

    private var finishOverlay: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()

            VStack(spacing: 14) {
                Text("🎉 Level Completed")
                    .font(.title2.bold())
                    .foregroundColor(.primaryText)

                Text(String(format: "Time %.2f s", vm.time))
                    .foregroundColor(.secondaryText)

                Text("Score \(vm.score)")
                    .foregroundColor(.secondaryText)

                primaryButton("PLAY AGAIN") {
                    vm.start(level: level)
                }
            }
            .padding(24)
            .background(Color.cardBackground)
            .cornerRadius(24)
            .shadow(color: .black.opacity(0.15), radius: 15)
            .padding(.horizontal, 40)
        }
    }

    private var countdownOverlay: some View {
        ZStack {
            Color.black.opacity(0.25).ignoresSafeArea()

            Text(vm.countdown > 0 ? "\(vm.countdown)" : "GO!")
                .font(.system(size: 120, weight: .heavy))
                .foregroundColor(.accent)
        }
    }
}
