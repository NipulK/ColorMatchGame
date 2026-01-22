import SwiftUI


struct LevelSelectionView: View {

    var body: some View {

        NavigationView {

            VStack(spacing: 20) {

                Text("Color Match Game")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Easy Level (3x3)",
                    destination: GameView(level: .easy))

                NavigationLink("Medium Level (5x5)",
                    destination: GameView(level: .medium))

                NavigationLink("Hard Level (7x7)",
                    destination: GameView(level: .hard))

            }
        }
    }
}
