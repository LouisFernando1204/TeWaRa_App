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
    @State private var timeIsUp: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var alertAction: (() -> Void)?
    @State private var buttonText: String = ""
    @State private var showAlert: Bool = false
    @State private var forPass : Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController()
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    
    var body: some View {
        
        VStack(content: {
            TopNavigationBar(name: "Tebak Bahasa", message: "Pulau")
            
            ScrollView {
                VStack(content: {
                    QuestionAndDisplay(type: "Bahasa", currentIsland: ModelData.shared.currentIslandObject, stopVideo: $forPass)
                    TextField("Masukkan jawabanmu...", text: $textFieldValue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(
                                    CustomGradient.redOrangeGradient,
                                    lineWidth: 2
                                )
                        )
                        .multilineTextAlignment(.leading)
                    Spacer()
                        .frame(height: 20)
                    self.showClueAndTimer()
                    ButtonCheck(action: {
                        traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
                        self.timerRunning = false
                        self.checkAnswer()
                    }, message: "CEK JAWABAN")
                    
                })
                .padding(.horizontal,
                         ScreenSize.screenWidth > 600 ? 90 : 20)
                .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 6)
            }
        })
        .onAppear {
            timerRunning = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
            }
            traditionalLanguageController.changeLanguage(language: ModelData.shared.currentIslandObject.traditionalLanguage)
            ModelData.shared.currentGame = "TraditionalLanguage"
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        .onChange(of: self.showAlert) { oldValue, newValue in
            if newValue {
                MusicPlayer.shared.stopBackgroundMusic()
            } else {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
            }
        }
        .safeAreaInset(edge: .top) {
            CustomGradient.redOrangeGradient
                .frame(height: ScreenSize.screenWidth > 600 ? 32: 70)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, ScreenSize.screenWidth > 600 ? -40 : -70)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text(buttonText)) {
                    alertAction?()
                }
            )
        }
        .fullScreenCover(isPresented: $backToIslandMenu) {
            IslandView()
        }
        .fullScreenCover(isPresented: $navToAdditionalQuestion) {
//            TouchdownView()
            TouchdownView()
        }
    }
    
    private func checkAnswer() {
        if traditionalLanguageController.isWrong {
            alertTitle = "Oops.. jawabanmu masih salah"
            alertMessage = "Tetap semangat dan belajar lagii.."
            buttonText = "Kembali ke Pilih Pulau"
            alertAction = { self.backToIslandMenu = true }
        } else if traditionalLanguageController.isCorrect {
            alertTitle = "Congrats! Jawabanmu benarr +\(traditionalLanguageController.point)"
            alertMessage = "Oopss jangan happy dulu, karena masih ada tantangan baru!"
            buttonText = "Telusuri tantangan baru"
            alertAction = { self.navToAdditionalQuestion = true }
        }
        else if timeIsUp {
            alertTitle = "Oops.. waktu kamu sudah habis"
            alertMessage = "Tetap semangat dan belajar lagii.."
            buttonText = "Kembali ke Pilih Pulau"
            alertAction = { self.backToIslandMenu = true }
        }
        showAlert = true
    }
    
    private func ClueBox(currentIsland: Island) -> some View {
        Rectangle()
            .clipShape(RoundedRectangle(cornerRadius: 14.0))
            .frame(
                height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 4 : ScreenSize.screenHeight / 4
            )
            .foregroundColor(.secondary.opacity(0.2))
            .overlay(
                VStack(content: {
                    Text("Petunjuk")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                        .font(
                            ScreenSize.screenWidth > 600 ? .title : .headline
                        )
                    
                    Text("'\(currentIsland.traditionalLanguage.clue)'")
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .font(
                            ScreenSize.screenWidth > 600 ? .largeTitle : .title3
                        )
                        .padding(.vertical, 4)
                        .overlay {
                            CustomGradient.redDarkRedGradient
                        }
                        .mask(
                            Text("'\(currentIsland.traditionalLanguage.clue)'")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(
                                    ScreenSize.screenWidth > 600 ? .largeTitle : .title3
                                )
                        )

                    Text("Ayo-ayo kamu pasti bisa!!!")
                        .fontWeight(.regular)
                        .font(
                            ScreenSize.screenWidth > 600 ? .title : .headline
                        )
                        .italic()
                        .padding(.bottom)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Ayo-ayo kamu pasti bisa!!!")
                                    .fontWeight(.regular)
                                    .font(
                                        ScreenSize.screenWidth > 600 ? .title : .headline
                                    )
                                    .italic()
                                    .padding(.bottom)
                            )
                        }
                    
                })
                .padding(.horizontal, ScreenSize.screenWidth > 600 ? 20 : 10)
            )
    }
    
    private func showClueAndTimer() -> some View {
        VStack(content: {
            ZStack {
                ClueBox(currentIsland: ModelData.shared.currentIslandObject)
                TimerComponent(type: "Bahasa")
                    .overlay {
                        Text("00:00:\(String(format: "%02d", countdownTimer))")
                            .onReceive(timer) { _ in
                                if countdownTimer > 0 && timerRunning {
                                    countdownTimer -= 1
                                }
                                else if countdownTimer == 0 {
                                    timerRunning = false
                                    timeIsUp = true
                                    self.checkAnswer()
                                }
                            }
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
