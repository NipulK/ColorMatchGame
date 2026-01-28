import SwiftUI

struct CardView: View {

    var card: CardModel

    var body: some View {

        ZStack {

            // BACK SIDE
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.accentSoft, lineWidth: 2)
                )
                .opacity(card.isFaceUp ? 0 : 1)

            // FRONT SIDE
            RoundedRectangle(cornerRadius: 14)
                .fill(card.color)
                .opacity(card.isFaceUp ? 1 : 0)
        }
        .frame(height: 70)
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .shadow(
            color: card.isMatched ? card.color.opacity(0.4) : .black.opacity(0.08),
            radius: card.isMatched ? 16 : 6
        )
        .scaleEffect(card.isMatched ? 1.05 : 1)
        .animation(.spring(response: 0.45), value: card.isMatched)
    }
}
