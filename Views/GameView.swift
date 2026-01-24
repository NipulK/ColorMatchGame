import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = GameViewModel()
    
    var level: GameLevel

    var body: some View {

        ZStack {

            VStack(spacing: 10) {

                //  CUSTOM TOP BAR
                HStack(spacing: 16) {

                    //  Back to Level Selection
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }

                    
                    //  Back to Home
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "house.fill")
                            .font(.title2)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)

                // ===== GAME UI =====
                Text("Score: \(vm.score)")
                    .font(.title)

                Text("Time: \(String(format: "%.2f", vm.time)) s")
                    .font(.headline)

                // START BUTTON
                if vm.state == .notStarted {
                    Button("START GAME") {
                        vm.startGame()
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                // PAUSE
                if vm.state == .running {
                    Button("PAUSE") {
                        vm.pauseGame()
                    }
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
                }

                // RESUME
                if vm.state == .paused && !vm.isWin {
                    Button("RESUME") {
                        vm.resumeGame()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                // GRID
                let columns = Array(
                    repeating: GridItem(.flexible()),
                    count: level.size
                )

                LazyVGrid(columns: columns, spacing: 10) {

                    ForEach(vm.cards.indices, id: \.self) { i in
                        CardView(card: vm.cards[i])
                            .onTapGesture {
                                vm.selectCard(index: i)
                            }
                            .animation(.easeInOut,
                                       value: vm.cards[i].isFaceUp)
                    }
                }
                .padding()
                .blur(radius:
                    (vm.state != .running || vm.showCountdown || vm.isWin) ? 8 : 0
                )
                .disabled(vm.state != .running || vm.showCountdown || vm.isWin)
            }

            // ===== FINISHED PANEL =====
            if vm.isWin {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    Text("🏆 Level Completed!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text("Time: \(String(format: "%.2f", vm.time)) s")
                        .foregroundColor(.white)

                    Text("Score: \(vm.score)")
                        .foregroundColor(.white)

                    Button("Play Again") {
                        vm.start(level: level)
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(15)
            }

            // ===== COUNTDOWN =====
            if vm.showCountdown {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()

                VStack {
                    Text(vm.countdown > 0 ? "\(vm.countdown)" : "GO!")
                        .font(.system(size: 120, weight: .heavy))
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)   // hide default back
        .onAppear {
            vm.start(level: level)
        }
    }
}
