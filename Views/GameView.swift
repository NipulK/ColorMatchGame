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
                if vm.state == .paused && !vm.isWin {
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
                    (vm.state != .running || vm.showCountdown || vm.isWin) ? 8 : 0
                )

                .disabled(vm.state != .running || vm.showCountdown || vm.isWin)
            }

            // ===== FINISHED PANEL =====
            if vm.isWin {
                

                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                VStack(spacing: 12) {

                    Text("🏆 Level Completed!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text("Time: \(String(format: "%.2f", vm.time)) s")
                        .foregroundColor(.white)

                    Text("Score: \(vm.score)")
                        .foregroundColor(.white)

                    Button("Play Again") {
                        vm.start(level: level)
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(15)
            }

            // ===== FULL SCREEN COUNTDOWN =====
            if vm.showCountdown {

                ZStack {

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
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
            }
        }
        .onAppear {
            vm.start(level: level)
        }
    }
}
