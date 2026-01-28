import SwiftUI

struct ScoreboardView: View {

    @StateObject private var vm = ScoreboardViewModel()

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color(hex: "#0F2027"),
                    Color(hex: "#203A43"),
                    Color(hex: "#2C5364")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {

                Text("🏆 Scoreboard")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)

                // LEVEL FILTER
                Picker("Level", selection: $vm.selectedLevel) {
                    Text("All").tag(GameLevel?.none)
                    Text("Easy").tag(GameLevel?.some(.easy))
                    Text("Medium").tag(GameLevel?.some(.medium))
                    Text("Hard").tag(GameLevel?.some(.hard))
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // LEADERBOARD
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(vm.topScores) { result in
                            HistoryRowView(result: result)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.load()
        }
    }
    
}
