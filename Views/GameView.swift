import SwiftUI

struct GameView: View {

    @StateObject var vm = GameViewModel()

    var level: GameLevel

    var body: some View {

        VStack {

            Text("Score: \(vm.score)")
                .font(.title)

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
        }
        .onAppear {
            vm.start(level: level)
        }
    }
}
