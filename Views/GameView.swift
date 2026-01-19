import SwiftUI

struct GameView: View {

    @StateObject var vm = GameViewModel()
    var level: GameLevel

    var body: some View {

        ZStack {

            // ===== MAIN GAME UI =====
            VStack(spacing: 10) {

                Text("Score: \(vm.score)")
                    .font(.title)

                Text("Time: \(String(format: "%.2f", vm.time)) s")
                    .font(.headline)

                // START BUTTON
                if vm.state == .notStarted {
                    Button("START GAME") {
                        vm.startGame()
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                // PAUSE
                if vm.state == .running {
                    Button("PAUSE") {
                        vm.pauseGame()
                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
                }

                // RESUME
                if vm.state == .paused {
                    Button("RESUME") {
                        vm.resumeGame()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                // GRID
                let columns = Array(
                    repeating: GridItem(.flexible()),
                    count: level.size
                )

                LazyVGrid(columns: columns, spacing: 10) {

                    ForEach(vm.cards.indices, id: \.self) { i in

                        CardView(card: vm.cards[i])
                            .onTapGesture {
                                vm.selectCard(index: i)
                            }
                            .animation(.easeInOut,
                                       value: vm.cards[i].isFaceUp)
                    }
                }
                .padding()

                // 🌫 BLUR GRID WHEN NEEDED
                .blur(radius:
                    (vm.state != .running || vm.showCountdown) ? 8 : 0
                )

                .disabled(vm.state != .running || vm.showCountdown)
            }

            // ===== FULL SCREEN COUNTDOWN =====
            if vm.showCountdown {

                ZStack {

                    // 🔥 FULL DARK BLUR BACKGROUND
                    Color.black
                        .opacity(0.75)
                        .ignoresSafeArea()

                    VStack {

                        Text(
                          vm.countdown > 0 ? "\(vm.countdown)" : "GO!"
                        )
                        .font(.system(size: 120, weight: .heavy))
                        .foregroundColor(.white)
                        .scaleEffect(1.3)
                        .animation(.spring(response: 0.4,
                                           dampingFraction: 0.6),
                                   value: vm.countdown)

                        Text("Get Ready!")
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                // 👉 THIS MAKES IT TRUE FULL SCREEN
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
            }
        }
        .onAppear {
            vm.start(level: level)
        }
    }
}
