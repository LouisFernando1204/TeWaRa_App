//
//  TraditionalLanguageView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 18/05/24.
//

import SwiftUI

struct TraditionalLanguageViewMac: View {
    
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
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController()
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                VStack(content: {
                    
                    TopNavigationBar(ScreenSize: geometry.size, name: "Tebak Bahasa", message: "Pulau")
                    
                    VStack(content: {
                        self.showQuestion()
                        
                        HStack(content: {
                            VStack(content: {
                                self.imageAndTextfield(screenSize: geometry.size)
                                    .padding(.top, geometry.size.width/10)
                            })
                            .padding(.horizontal)
                            
                            VStack(content: {
                                self.showClueAndTimer(screenSize: geometry.size)
                                self.buttonCheckAnswer(screenSize: geometry.size)
                            })
                            .padding(.top, geometry.size.width/10)
                            .frame(width: geometry.size.width/2)
                        })
                        
                       Spacer()
                            .frame(height: geometry.size.height)
                        
                    })
                    .background(Color.white)
                    .padding()
                    
                    
                })
                .background(Color.white)
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
                .navigationDestination(isPresented: $backToIslandMenu) {
                    IslandViewMac()
                }
                .navigationDestination(isPresented: $navToAdditionalQuestion) {
                    TouchdownViewMac()
                }
            }
        }
        
        
        
    }
    
    private func showQuestion() -> some View {
        HStack(content: {
            Text("'\(ModelData.shared.currentIslandObject.traditionalLanguage.sentences)' merupakan bahasa daerah...")
                .font(.largeTitle)
                .fontWeight(.bold)
        })
    }
    
    private func imageAndTextfield(screenSize: CGSize) -> some View {
        VStack(content: {
            Image(ModelData.shared.currentIslandObject.traditionalLanguage.image!)
                .frame(width: screenSize.width/2.4, height: screenSize.width/3.4)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius:5)
                .padding(.bottom, 10)
            
            TextField("Masukkan jawabanmu...", text: $textFieldValue)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .padding(.leading, screenSize.width / 60)
                .padding(.vertical, screenSize.height / 50)
                .frame(maxWidth: .infinity)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .foregroundColor(.black)
            
            
            Spacer().frame(height: 20)
        })
        .padding(.top, 14)
        
    }
    
    private func showClueAndTimer(screenSize: CGSize) -> some View {
        VStack(content: {
            ZStack {
                Rectangle()
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .frame(width: screenSize.width/2.2, height: screenSize.width/3.4)
                    .foregroundColor(.secondary.opacity(0.2))
                    .overlay(
                        VStack(content: {
                            Text("Petunjuk")
                                .fontWeight(.semibold)
                                .font(.title)
                            
                            Text("'\(ModelData.shared.currentIslandObject.traditionalLanguage.clue)'")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .padding(.vertical, 4)
                                .overlay {
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 118/255, green: 20/255, blue: 20/255)]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing
                                    )
                                }
                                .mask(
                                    Text("'\(ModelData.shared.currentIslandObject.traditionalLanguage.clue)'")
                                        .multilineTextAlignment(.center)
                                        .fontWeight(.bold)
                                        .font(.title)
                                )
                            
                            
                            Text("Ayo-ayo kamu pasti bisa!!!")
                                .fontWeight(.regular)
                                .font(.title)
                                .italic()
                            //                                .padding(.bottom)
                                .overlay {
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing
                                    )
                                    .mask(
                                        Text("Ayo-ayo kamu pasti bisa!!!")
                                            .fontWeight(.regular)
                                            .font(.title)
                                            .italic()
                                        //                                            .padding(.bottom)
                                    )
                                }
                            
                        })
                        //                        .frame(height: 100)
                            .padding(.horizontal, 10)
                    )
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
                    .offset(y: screenSize.height/6)
            }
            
            //            Spacer().frame(height: 20)
            
        })
        .padding(.bottom, 10)
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
    
    private func buttonCheckAnswer(screenSize: CGSize) -> some View {
        
        Rectangle()
            .fill(.red)
            .frame(height: screenSize.height/16)
            .cornerRadius(12)
            .overlay {
                Text("CEK JAWABAN")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            .onTapGesture {
                traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
                self.timerRunning = false
                self.checkAnswer()
            }
        
    }
}



#Preview {
    TraditionalLanguageViewMac(selectedIsland: ModelData.shared.bali)
}
