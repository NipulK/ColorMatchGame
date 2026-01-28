import SwiftUI

struct HistoryRowView: View {

    let result: GameResult

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(result.playerName)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(result.level.rawValue.capitalized)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }

            Spacer()

            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Score \(result.score)")
                    .foregroundColor(.white)

                Text(String(format: "%.2f s", result.time))
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(12)
    }
}
