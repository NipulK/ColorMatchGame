import SwiftUI
import UIKit

struct PressableButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.95 : 1)
            .onChange(of: configuration.isPressed) { pressed in
                if pressed {
                    let generator = UIImpactFeedbackGenerator(style: .soft)
                    generator.prepare()
                    generator.impactOccurred()
                }
            }
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
