import SwiftUI

struct HistoryRowView: View {

    let rank: Int
    let result: GameResult

    var body: some View {

        HStack(spacing: 14) {

            // 🥇 Rank / Medal
            ZStack {
                Circle()
                    .fill(rankColor.opacity(0.15))
                    .frame(width: 42, height: 42)

                Text(rankSymbol)
                    .font(.headline)
                    .foregroundColor(rankColor)
            }

            // 👤 Player Info
            VStack(alignment: .leading, spacing: 6) {

                Text(result.playerName)
                    .font(.headline)
                    .foregroundColor(.primaryText)

                HStack(spacing: 8) {

                    //  LEVEL BADGE
                    Text(levelText)
                        .font(.caption.bold())
                        .foregroundColor(levelColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(levelColor.opacity(0.15))
                        .cornerRadius(8)

                    // ⏱ TIME
                    Text(formattedTime)
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
            }

            Spacer()

            // ⭐ SCORE
            Text("\(result.score)")
                .font(.title3.bold())
                .foregroundColor(.accent)
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6)
    }

    // MARK: - Helpers

    private var formattedTime: String {
        String(format: "%.2f s", result.time)
    }

    private var levelText: String {
        switch result.level {
        case .easy: return "EASY"
        case .medium: return "MEDIUM"
        case .hard: return "HARD"
        }
    }

    private var levelColor: Color {
        switch result.level {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }

    private var rankSymbol: String {
        switch rank {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return "\(rank)"
        }
    }

    private var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .accent
        }
    }
}
