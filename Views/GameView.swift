import SwiftUI

struct GameView: View {

    @StateObject var vm = GameViewModel()

    var level: GameLevel

    var body: some View {

        VStack(spacing: 10) {

            // SCORE
            Text("Score: \(vm.score)")
                .font(.title)

            // TIME
            Text("Time: \(String(format: "%.2f", vm.time)) s")
                .font(.headline)

            // 🟢 START BUTTON (show only before start)
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

            // 🟡 PAUSE / RESUME BUTTON
            if vm.state == .running {
                Button("PAUSE") {
                    vm.pauseGame()
                }
                .padding()
                .background(Color.orange)
                .cornerRadius(8)
            }

            if vm.state == .paused {
                Button("RESUME") {
                    vm.resumeGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            // WIN MESSAGE
            if vm.isWin {
                Text(" You Win!")
                    .font(.largeTitle)
                    .foregroundColor(.green)

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
                }
            }
            .padding()

            // ❗ Disable grid when not running
            .disabled(vm.state != .running)

        }
        .onAppear {
            vm.start(level: level)
        }
    }
}
