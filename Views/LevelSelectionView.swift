import SwiftUI

struct LevelSelectionView: View {

    var body: some View {

        NavigationView {

            VStack(spacing: 20) {

                Text("Color Match Game")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Easy Level (3x3)",
                    destination: Text("Easy Screen"))

                NavigationLink("Medium Level (5x5)",
                    destination: Text("Medium Screen"))

                NavigationLink("Hard Level (7x7)",
                    destination: Text("Hard Screen"))
            }
        }
    }
}
