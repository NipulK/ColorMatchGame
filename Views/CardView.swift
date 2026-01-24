import SwiftUI

struct CardView: View {

    var card: CardModel

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 14)
                .fill(Color.blue.opacity(0.9))
                .opacity(card.isFaceUp ? 0 : 1)

            RoundedRectangle(cornerRadius: 14)
                .fill(card.color)
                .opacity(card.isFaceUp ? 1 : 0)
        }
        .frame(height: 70)
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .shadow(radius: 4)
        .shadow(
            color: card.isMatched ? card.color.opacity(0.9) : .clear,
            radius: card.isMatched ? 14 : 0
        )
        .scaleEffect(card.isMatched ? 1.05 : 1)
        .animation(.spring(response: 0.5), value: card.isMatched)
    }
}
