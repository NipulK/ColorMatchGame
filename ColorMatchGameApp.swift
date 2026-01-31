import SwiftUI
import Firebase

@main
struct ColorMatchGameApp: App {
    
    init() {
           FirebaseApp.configure()
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
}
