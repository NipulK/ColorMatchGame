import Foundation
import FirebaseFirestore

final class FirebaseScoreManager {

    static let shared = FirebaseScoreManager()

    private let db = Firestore.firestore()

    private init() {}

    // Save a player score to Firestore
    func saveScore(_ score: PlayerScore, completion: @escaping (Result<Void, Error>) -> Void) {

        let data: [String: Any] = [
            "playerName": score.playerName,
            "level": score.level,
            "timeSpent": score.timeSpent,
            "points": score.points,
            "createdAt": Timestamp(date: score.createdAt)
        ]

        db.collection("scores")
            .document(score.id)
            .setData(data) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
    }
}
