//
//  TraditionalDanceView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 18/05/24.
//

import SwiftUI
import AVKit


struct TraditionalDanceViewMac: View {
    
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
    @State private var stopVideo: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @StateObject private var traditionalDanceController: TraditionalDanceController = TraditionalDanceController()
    
    init(selectedIsland: Island) {
        self.selectedIsland = selectedIsland
    }
    
    private let fixedColumn = [
        GridItem(.fixed(140)),
        GridItem(.fixed(140)),
        GridItem(.fixed(140)),
        GridItem(.fixed(140))
    ]
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                
                VStack(content: {
                    
                    TopNavigationBar(ScreenSize: geometry.size, name: "Tebak Tarian", message: "Pulau")
                    
                    VStack(content: {
                        self.showQuestionAndChance()
                        
                        HStack(content: {
                            self.imageAndAnswerBox(screenSize: geometry.size)
                            
                            VStack(content: {
                                self.showWordOptions(screenSize: geometry.size)
                                
                                self.showTimer(screenSize: geometry.size)
                            })
                        })
                    })
                    .padding()
                })
                .background(Color.white)
                .onAppear {
                    timerRunning = true
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    //                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                    //                    }
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
                        .frame(height: geometry.size.width > 600 ? 32: 70)
                        .edgesIgnoringSafeArea(.top)
                        .padding(.bottom, geometry.size.width > 600 ? -40 : -70)
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
            }
            .navigationDestination(isPresented: $backToIslandMenu) {
                IslandViewMac()
            }
            .navigationDestination(isPresented: $navToAdditionalQuestion) {
                TouchdownViewMac()
            }
            .onChange(of: backToIslandMenu) { oldValue, newValue in
                if newValue {
                    stopVideo = true
                }
            }
            .onChange(of: navToAdditionalQuestion) { oldValue, newValue in
                if newValue {
                    stopVideo = true
                }
            }
        }
        
    }
    
    private func showQuestionAndChance() -> some View {
        HStack(content: {
            Text("Tari tradisional dari Pulau '\(ModelData.shared.currentIslandObject.islandName)' adalah...")
                .font(.largeTitle)
                .fontWeight(.bold)
        })
    }
    
    private func imageAndAnswerBox(screenSize: CGSize) -> some View {
        VStack(content: {
            if let videoURL = Bundle.main.url(forResource: ModelData.shared.currentIslandObject.traditionalDance.image, withExtension: "mp4") {
                VideoPlayerMac(videoURL: videoURL, type: "Game", ScreenSize: screenSize, stopVideo: $stopVideo)
            }
            
            HStack(content: {
                // buat if kalau ndak null countnya/panjangnya
                ForEach(ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.indices, id: \.self) { index in
                    let alphabet = ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].alphabet
                    if(!ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].isClicked) {
                        Rectangle()
                            .frame(width: screenSize.width/16, height:screenSize.width/16)
                            .foregroundColor(.secondary)
                            .opacity(0.2)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing),
                                        lineWidth: 2
                                    )
                            )
                    }
                    else {
                        Rectangle()
                            .frame(width: screenSize.width/16, height:screenSize.width/16)
                            .foregroundColor(.secondary)
                            .opacity(0.2)
                            .cornerRadius(20)
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing),
                                        lineWidth: 2
                                    )
                                
                                Text(alphabet)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                            }
                        
                    }
                }
            })
            .padding(.bottom)
            
        })
        .padding(.leading)
        //
    }
    
    private func showWordOptions(screenSize: CGSize) -> some View {
        VStack(content: {
            LazyVGrid(columns: fixedColumn, spacing: 20) {
                ForEach(ModelData.shared.currentIslandObject.traditionalDance.availableWords.indices, id:\.self) { index in
                    let item = ModelData.shared.currentIslandObject.traditionalDance.availableWords[index]
                    if (!ModelData.shared.currentIslandObject.traditionalDance.availableWords[index].isClicked) {
                        Rectangle()
                            .frame(width: screenSize.width/16, height:screenSize.width/16)
                            .overlay {
                                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 118/255, green: 20/255, blue: 20/255)]),
                                               startPoint: .leading,
                                               endPoint: .trailing
                                )
                            }
                            .overlay(
                                Text(item.alphabet)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )
                            .cornerRadius(20)
                            .onTapGesture(perform: {
                                traditionalDanceController.guessWord(word: item, remainingTime: countdownTimer)
                                self.checkAnswer()
                            })
                    }
                    else {
                        Rectangle()
                            .frame(width: screenSize.width/16, height:screenSize.width/16)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
        })
        .padding(.bottom, screenSize.width/14)
        .padding(.top, screenSize.width/10)
    }
    
    private func showTimer(screenSize: CGSize) -> some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                 startPoint: .leading,
                                 endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .frame(width: screenSize.width/8, height: screenSize.width/26)
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
                    .font(screenSize.width > 600 ? .largeTitle : .title2)
                    .foregroundColor(Color.white)
            }
            .padding(.bottom, screenSize.width/12)
        //            .padding(.vertical, screenSize.width/36)
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
}

#Preview {
    TraditionalDanceViewMac(selectedIsland: ModelData.shared.bali)
}
