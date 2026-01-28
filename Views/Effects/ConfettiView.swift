//ANIMATION ON WIN

import SwiftUI

struct ConfettiView: View {

    @State private var particles: [ConfettiParticle] = []

    let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple, .pink
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { particle in
                    Rectangle()
                        .fill(particle.color)
                        .frame(width: 8, height: 12)
                        .rotationEffect(.degrees(particle.rotation))
                        .position(particle.position)
                        .opacity(particle.opacity)
                }
            }
            .onAppear {
                createParticles(size: geo.size)
            }
        }
        .ignoresSafeArea()
    }

    // MARK: - Particle Creation
    private func createParticles(size: CGSize) {

        let count = 80

        particles = (0..<count).map { _ in
            ConfettiParticle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: -20
                ),
                color: colors.randomElement()!,
                rotation: Double.random(in: 0...360),
                opacity: 1
            )
        }

        // Animate fall
        for index in particles.indices {
            withAnimation(
                .easeOut(duration: Double.random(in: 2.0...3.5))
            ) {
                particles[index].position.y = size.height + 40
                particles[index].rotation += Double.random(in: 180...720)
                particles[index].opacity = 0
            }
        }
    }
}

// MARK: - Particle Model
struct ConfettiParticle: Identifiable {
    let id = UUID()
    var position: CGPoint
    let color: Color
    var rotation: Double
    var opacity: Double
}
