import SwiftUI

struct GameView: View {

    @StateObject var vm = GameViewModel()

    var level: GameLevel

    var body: some View {

        ZStack {

            VStack(spacing: 10) {

                Text("Score: \(vm.score)")
                    .font(.title)

                Text("Time: \(String(format: "%.2f", vm.time)) s")
                    .font(.headline)

                // START BUTTON
                if vm.state == .notStarted {
                    Button("START GAME") {
                        withAnimation {
                            vm.startGame()
                        }
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                // PAUSE / RESUME
                if vm.state == .running {
                    Button("PAUSE") {
                        withAnimation {
                            vm.pauseGame()
                        }
                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
                }

                if vm.state == .paused {
                    Button("RESUME") {
                        withAnimation {
                            vm.resumeGame()
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                // WIN
                if vm.isWin {
                    Text("🎉 You Win!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .transition(.scale)

                    Button("Play Again") {
                        vm.start(level: level)
                    }
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
                            // 🔥 Card flip animation
                            .animation(.easeInOut(duration: 0.3),
                                       value: vm.cards[i].isFaceUp)
                    }
                }
                .padding()

                // 🌫 BLUR WHEN NOT RUNNING
                .blur(radius: vm.state == .running ? 0 : 5)
                .disabled(vm.state != .running)
            }

            // 🎯 COUNTDOWN OVERLAY
            if vm.showCountdown {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)

                Text(vm.countdown > 0 ? "\(vm.countdown)" : "GO!")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)
                    .transition(.scale)
                    .animation(.spring(), value: vm.countdown)
            }
        }
        .onAppear {
            vm.start(level: level)
        }
    }

}
