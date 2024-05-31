//
//  TraditionalLanguageView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct TraditionalLanguageView: View {
    
    let selectedIsland: Island
    
    @State private var textFieldValue: String = ""
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController(traditionalLanguage: ModelData.shared.bali.traditionalLanguage)
    
    var body: some View {
        ScrollView {
            VStack(content: {
                TopNavigationBar(name: "Tebak Bahasa", message: "Pulau")
                VStack(content: {
                    QuestionAndDisplay(type: "Bahasa", currentIsland: self.selectedIsland)
                    TextFieldComponent(value: textFieldValue)
                    self.showClueAndTimer()
                    ButtonCheck(action: {
                        traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
                    }, message: "CEK JAWABAN")
                    
                })
                .padding(.horizontal,
                         ScreenSize.screenWidth > 600 ? 90 : 20)
                .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 6)
            })
            .onAppear {
                timerRunning = true
            }
        }
        .safeAreaInset(edge: .top) {
            CustomGradient.redOrangeGradient
            .frame(height: ScreenSize.screenWidth > 600 ? 32: 70)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, ScreenSize.screenWidth > 600 ? -40 : -70)
        }
    }
    
    private func showClueAndTimer() -> some View {
        VStack(content: {
            ZStack {
                ClueBox(currentIsland: ModelData.shared.bali)
                TimerComponent(type: "Bahasa")
                    .overlay {
                        Text("00:00:\(countdownTimer)")
                            .onReceive(timer, perform: { _ in
                                if (countdownTimer > 0 && timerRunning) {
                                    countdownTimer -= 1
                                }
                                else {
                                    timerRunning = false
                                }
                            })
                            .offset(y: ScreenSize.screenWidth > 600 ? 150 : 100)
                            .fontWeight(.regular)
                            .font(ScreenSize.screenWidth > 600 ? .title : .title2)
                            .foregroundColor(Color.white)
                    }
            }
            Spacer().frame(height: 40)
        })
    }
}

#Preview {
    TraditionalLanguageView(selectedIsland: ModelData.shared.bali)
}
