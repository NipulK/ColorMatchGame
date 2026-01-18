import SwiftUI

struct CardModel: Identifiable {

    let id = UUID()

    var color: Color

    var isFaceUp = false

    var isMatched = false
}
