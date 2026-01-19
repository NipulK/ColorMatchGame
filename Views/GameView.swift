import SwiftUI

struct GameView: View {

    @StateObject var vm = GameViewModel()

    var level: GameLevel

    var body: some View {

        VStack {

            Text("Score: \(vm.score)") //score text point
                .font(.title)

            let columns = Array(
                repeating: GridItem(.flexible()),
                count: level.size
            )
            
            Text("Time: \(String(format: "%.2f", vm.time)) s")
            
            if vm.isWin {
                Text("🎉 You Win!")
                    .font(.largeTitle)
                    .foregroundColor(.green)

                Button("Play Again") {
                    vm.start(level: level)
                }
            }


            LazyVGrid(columns: columns, spacing: 10) {

                ForEach(vm.cards.indices, id: \.self) { i in

                    CardView(card: vm.cards[i])
                        .onTapGesture {
                            vm.selectCard(index: i)
                        }
                }
            }
            .padding()
        }
        .onAppear {
            vm.start(level: level)
        }
    }
}
