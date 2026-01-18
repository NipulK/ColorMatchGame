enum GameLevel {
    case easy
    case medium
    case hard

    var size: Int {
        switch self {
        case .easy:
            return 3
        case .medium:
            return 5
        case .hard:
            return 7
        }
    }
}
