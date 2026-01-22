import SwiftUI


struct HomeView: View {

    @State private var goToDashboard = false

    var body: some View {

        NavigationView {

            VStack(spacing: 30) {

                Text("Color Match Game")
                    .font(.largeTitle)
                    .bold()

                // PLAY BUTTON
                NavigationLink(
                    destination: LevelSelectionView(),
                    isActive: $goToDashboard
                ) {
                    Button("PLAY") {
                        goToDashboard = true
                    }
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                // QUIT BUTTON
                Button("QUIT") {
                    exit(0) // academic/demo purpose
                }
                .font(.title2)
                .padding()
                .frame(width: 200)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
    }
}

