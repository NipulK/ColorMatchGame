import SwiftUI

struct CardView: View {

    var card: CardModel

    var body: some View {

        ZStack {

            if card.isFaceUp || card.isMatched {

                Rectangle()
                    .fill(card.color)

            } else {

                Rectangle()
                    .fill(Color.blue)
            }
        }
        .cornerRadius(8)
        .frame(height: 60)
    }
}
