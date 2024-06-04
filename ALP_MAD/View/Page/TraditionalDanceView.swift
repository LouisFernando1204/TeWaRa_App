//
//  TraditionalDanceView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI
import AVKit
import UIKit

struct TraditionalDanceView: View {
    
    @State private var backToIslandMenu: Bool = false
    @State private var navToAdditionalQuestion: Bool = false
    @State private var selectedIsland: Island
    @State private var avPlayer = AVPlayer()
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    @State private var timeIsUp: Bool = false
    @State private var outOfChance: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var alertAction: (() -> Void)?
    @State private var buttonText: String = ""
    @State private var showAlert: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var fixedColumn: [GridItem] {
        let screenWidth = UIScreen.main.bounds.width
        return screenWidth > 600 ? [
            GridItem(.fixed(120)),
            GridItem(.fixed(120)),
            GridItem(.fixed(120)),
            GridItem(.fixed(120)),
        ] : [
            GridItem(.fixed(60)),
            GridItem(.fixed(60)),
            GridItem(.fixed(60)),
            GridItem(.fixed(60))
        ]
    }
    
    @StateObject private var traditionalDanceController: TraditionalDanceController = TraditionalDanceController()
    
    init(selectedIsland: Island) {
        self.selectedIsland = selectedIsland
    }
    
    var body: some View {
        
        VStack(content: {
            
            TopNavigationBar(name: "Tebak Tarian", message: "Pulau")
            ScrollView {
                VStack(content: {
                    QuestionAndDisplay(type: "Tarian", currentIsland: self.selectedIsland)
                        .onChange(of: self.showAlert) { oldValue, newValue in
                            if newValue {
                                
                            }
                        }
                    ChanceBox(message: "Kesempatan kamu kurang \(traditionalDanceController.getChance())x")
                    self.showAnswerBox()
                    self.showWordOptions()
                    self.showTimer()
                })
                .padding(.horizontal,
                         ScreenSize.screenWidth > 600 ? 90 : 20)
                .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 6)
            }
            
        })
        .onAppear {
            timerRunning = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
//            }
            self.traditionalDanceController.changeDance(dance: ModelData.shared.currentIslandObject.traditionalDance)
            ModelData.shared.currentGame = "TraditionalDance"
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
            TouchdownView()
        }
    }
    
    private func checkAnswer() {
        if traditionalDanceController.currentGameIsWrong {
            alertTitle = "Oops.. kesempatan menjawab sudah habis"
            alertMessage = "Tetap semangat dan belajar lagii.."
            buttonText = "Kembali ke Pilih Pulau"
            print("SALAA")
            timerRunning = false
            showAlert = true
            alertAction = { self.backToIslandMenu = true }
        } 
        else if traditionalDanceController.currentGameIsCorrect {
            alertTitle = "Congrats! Jawabanmu benarr +\(traditionalDanceController.point)"
            alertMessage = "Oopss jangan happy dulu, karena masih ada tantangan baru!"
            buttonText = "Telusuri tantangan baru"
            showAlert = true
            timerRunning = false
            alertAction = { self.navToAdditionalQuestion = true }
        }
        else if countdownTimer == 0 {
            alertTitle = "Oops.. waktu kamu sudah habis"
            alertMessage = "Tetap semangat dan belajar lagii.."
            buttonText = "Kembali ke Pilih Pulau"
            showAlert = true
            alertAction = { self.backToIslandMenu = true }
        }
    }
    
    private func showAnswerBox() -> some View {
        HStack(content: {
            // buat if kalau ndak null countnya/panjangnya
            ForEach(ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.indices, id: \.self) { index in
                let alphabet = ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].alphabet
                
                AlphabetBox(type: "Answer", alphabet: alphabet, isClicked: ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].isClicked)
            }
        })
    }
    
    private func showWordOptions() -> some View {
        VStack(content: {
            LazyVGrid(columns: fixedColumn, spacing: 20) {
                ForEach(ModelData.shared.currentIslandObject.traditionalDance.availableWords.indices, id:\.self) { index in
                    let item = ModelData.shared.currentIslandObject.traditionalDance.availableWords[index]
                    
                    AlphabetBox(type: "Option", alphabet: item.alphabet, isClicked: item.isClicked)
                        .onTapGesture {
                            traditionalDanceController.guessWord(word: item, remainingTime: countdownTimer)
                            self.checkAnswer()
                        }
                }
            }
        })
        .padding(.bottom)
    }
    
    private func showTimer() -> some View {
        TimerComponent(type: "Tarian")
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
                    .fontWeight(.regular)
                    .font(ScreenSize.screenWidth > 600 ? .title : .title2)
                    .foregroundColor(Color.white)
            }
    }
}

#Preview {
    TraditionalDanceView(selectedIsland: ModelData.shared.bali)
}
