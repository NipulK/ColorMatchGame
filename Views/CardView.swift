import SwiftUI

struct CardView: View {

    var card: CardModel

    var body: some View {

        ZStack {

            // BACK SIDE
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .overlay(
                    Text("?")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .opacity(card.isFaceUp ? 0 : 1)

            // FRONT SIDE
            RoundedRectangle(cornerRadius: 10)
                .fill(card.color)
                .opacity(card.isFaceUp ? 1 : 0)

        }
        .frame(height: 70)

        //  REAL 3D FLIP  card
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )

        .animation(.easeInOut(duration: 0.4),
                   value: card.isFaceUp)

        .shadow(radius: 3)
        
        .frame(height: 70)

        .rotation3DEffect(
            .degrees(card.isFaceUp ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )

        .animation(.easeInOut(duration: 0.4), value: card.isFaceUp)

        // ✨ GLOW EFFECT WHEN MATCHED
        .shadow(
            color: card.isMatched ? card.color.opacity(0.9) : .clear,
            radius: card.isMatched ? 12 : 0
        )
        .scaleEffect(card.isMatched ? 1.05 : 1.0)
        .animation(.spring(response: 0.5), value: card.isMatched)

    }
}
