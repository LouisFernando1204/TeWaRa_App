//
//  TraditionalLanguageView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct TraditionalLanguageView: View {
    
    let selectedIsland: Island
    
    @State private var backToIslandMenu: Bool = false
    @State private var navToAdditionalQuestion: Bool = false
    @State private var textFieldValue: String = ""
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController()
    
    var body: some View {
        
        VStack(content: {
            TopNavigationBar(name: "Tebak Bahasa", message: "Pulau")
            
            ScrollView {
                VStack(content: {
                    QuestionAndDisplay(type: "Bahasa", currentIsland: ModelData.shared.currentIslandObject)
                    TextField("Masukkan jawabanmu...", text: $textFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(
                                    CustomGradient.redOrangeGradient,
                                    lineWidth: 2
                                )
                        )
                    Spacer()
                        .frame(height: 20)
                    self.showClueAndTimer()
                    ButtonCheck(action: {
                        traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
                    }, message: "CEK JAWABAN")
                    
                })
                .padding(.horizontal,
                         ScreenSize.screenWidth > 600 ? 90 : 20)
                .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 6)
            }
        })
        .onAppear {
            timerRunning = true
            traditionalLanguageController.changeLanguage(language: ModelData.shared.currentIslandObject.traditionalLanguage)
        }
        .safeAreaInset(edge: .top) {
            CustomGradient.redOrangeGradient
                .frame(height: ScreenSize.screenWidth > 600 ? 32: 70)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, ScreenSize.screenWidth > 600 ? -40 : -70)
        }
        .alert(isPresented: $traditionalLanguageController.isWrong) {
            Alert(
                title: Text("Oops.. jawabanmu masih salah"),
                message: Text("Tetap semangat dan belajar lagii.."),
                dismissButton: .default(Text("Kembali ke Pilih Pulau")) {
                    self.backToIslandMenu = true
                }
            )
        }
        .alert(isPresented: $traditionalLanguageController.isCorrect) {
            Alert(
                title: Text("Congrats! Jawabanmu benarr"),
                message: Text("Oopss jangan happy dulu, karena masih ada tantangan baru!"),
                dismissButton: .default(Text("Telusuri tantangan")) {
                    self.navToAdditionalQuestion = true
                }
            )
        }
        .fullScreenCover(isPresented: $backToIslandMenu) {
            IslandView()
        }
        .fullScreenCover(isPresented: $navToAdditionalQuestion) {
            AdditionalQuestionView()
        }
    }
    
    private func showClueAndTimer() -> some View {
        VStack(content: {
            ZStack {
                ClueBox(currentIsland: ModelData.shared.currentIslandObject)
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
