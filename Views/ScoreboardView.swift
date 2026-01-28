import SwiftUI

struct ScoreboardView: View {

    @Environment(\.dismiss) var dismiss
    @State private var results: [GameResult] = []

    var body: some View {

        ZStack {

            // 🌤 LIGHT BACKGROUND
            Color.appBackground
                .ignoresSafeArea()

            VStack(spacing: 16) {

                // 🔝 HEADER
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.primaryText)
                    }

                    Spacer()

                    Text("Scoreboard")
                        .font(.title2.bold())
                        .foregroundColor(.primaryText)

                    Spacer()

                    Color.clear.frame(width: 24)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                // 🏆 CONTENT
                if results.isEmpty {

                    Spacer()

                    VStack(spacing: 12) {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.accent)

                        Text("No scores yet")
                            .font(.headline)
                            .foregroundColor(.primaryText)

                        Text("Play a game to see your results here.")
                            .font(.subheadline)
                            .foregroundColor(.secondaryText)
                    }

                    Spacer()

                } else {

                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(Array(results.enumerated()), id: \.element.id) { index, result in
                                HistoryRowView(
                                    rank: index + 1,
                                    result: result
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadScores()
        }
    }

    // MARK: - Load Scores
    private func loadScores() {
        results = ScoreboardManager.shared.topScores(limit: 20)
    }
}
