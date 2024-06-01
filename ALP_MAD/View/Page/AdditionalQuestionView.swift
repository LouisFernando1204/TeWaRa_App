//
//  AnswerDescriptionView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct AdditionalQuestionView: View {
    
    
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    @State private var answer : String = ""
    @State private var showAlert = false
    @State private var navToAnswerDescriptionView = false
    @State private var countDownTimer = 30
    @State private var timerRunning = false
    
    private var screenSize = ScreenSize()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        let isIpad = ScreenSize.screenWidth > 600
        
        self.setUpAdditionalQuestionView(islandController: islandController, answer: $answer, showAlert: $showAlert, navToAnswerDescriptionView: $navToAnswerDescriptionView, countDownTimer: $countDownTimer, timerRunning: $timerRunning, isIpad: isIpad)
    }
    
    private func setUpAdditionalQuestionView(islandController: IslandController, answer: Binding<String>, showAlert: Binding<Bool>, navToAnswerDescriptionView: Binding<Bool>, countDownTimer: Binding<Int>, timerRunning: Binding<Bool>, isIpad: Bool) -> some View {
        ScrollView {
            VStack(alignment: .center) {
                self.navigationBar(isIpad: isIpad)
                self.timer(countDownTimer: countDownTimer, timerRunning: timerRunning, showAlert: showAlert, isIpad: isIpad)
                self.question(isIpad: isIpad)
                self.answerOptions(islandController: islandController, navToAnswerDescriptionView: navToAnswerDescriptionView, answer: answer, showAlert: showAlert, timerRunning: timerRunning, countDownTimer: countDownTimer, isIpad: isIpad)
                self.poinStatus(isIpad: isIpad)
                self.knowledgeInformation(isIpad: isIpad)
            }
            .onAppear{
                timerRunning.wrappedValue = true
            }
        }.safeAreaInset(edge: .top) {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                    
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: isIpad ? ScreenSize.screenHeight/35 : ScreenSize.screenHeight/12)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, isIpad ? -40 : -70)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
            }
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
    }
    
    private func navigationBar(isIpad: Bool) -> some View {
        HStack(alignment: .center, content: {
            Spacer()
            Text("Bonus")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(isIpad ?  .title2 : .headline)
                .padding(.bottom, isIpad ? 15 : 0)
            Spacer()
        })
        .frame(height: isIpad ? ScreenSize.screenHeight/30 : ScreenSize.screenHeight/20)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                    
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/40 : ScreenSize.screenHeight/40)
    }
    
    private func timer(countDownTimer: Binding<Int>, timerRunning: Binding<Bool>, showAlert: Binding<Bool>, isIpad: Bool) -> some View {
        ZStack(alignment: .center, content: {
            Image("backgroundTimer")
                .resizable()
                .frame(width: isIpad ? ScreenSize.screenWidth/1.1 : ScreenSize.screenWidth/1.15, height: isIpad ? ScreenSize.screenHeight/3 : ScreenSize.screenHeight/4.85)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("orangeColor(TeWaRa)")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: isIpad ? 8 : 4
                        )
                )
                .cornerRadius(10)
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(width: isIpad ? ScreenSize.screenWidth/1.125 : ScreenSize.screenWidth/1.175, height: isIpad ? ScreenSize.screenHeight/3.12 : ScreenSize.screenHeight/5.1)
                .cornerRadius(isIpad ? 0 : 6)
            Text("00:00:\(String(format: "%02d", countDownTimer.wrappedValue))")
                .onReceive(timer) { _ in
                    if countDownTimer.wrappedValue > 0 && timerRunning.wrappedValue {
                        countDownTimer.wrappedValue -= 1
                    }
                    else if countDownTimer.wrappedValue == 0 {
                        timerRunning.wrappedValue = false
                        showAlert.wrappedValue = true
                    }
                }
                .font(.system(size: isIpad ? 60 : 44))
                .fontWeight(.black)
        })
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/80 : ScreenSize.screenHeight/55)
    }
    
    private func question(isIpad: Bool) -> some View {
        HStack(alignment: .center){
            Text("Budaya tersebut berasal dari provinsi...")
                .font(.system(size: isIpad ? 35 : 18))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/50 : ScreenSize.screenHeight/50)
    }
    
    private func answerOptions(islandController: IslandController, navToAnswerDescriptionView: Binding<Bool>, answer: Binding<String>, showAlert: Binding<Bool>, timerRunning: Binding<Bool>, countDownTimer: Binding<Int>, isIpad: Bool) -> some View {
        LazyVGrid(columns: columns, spacing: isIpad ? ScreenSize.screenWidth/50 : ScreenSize.screenWidth/35) {
            if ModelData.shared.currentGame == "TraditionalDance" {
                ForEach(islandController.getIsland().traditionalDance.provinceOptions,  id: \.self) { provinceOption in
                    Button(
                        action: {
                            answer.wrappedValue = provinceOption
                            showAlert.wrappedValue = true
                            islandController.checkTheAnswer(word: answer.wrappedValue, currentIsland: ModelData.shared.currentIsland, currentGame: ModelData.shared.currentGame, timer: countDownTimer.wrappedValue)
                            timerRunning.wrappedValue = false
                        },
                        label: {
                            Text(provinceOption)
                                .font(.system(size: isIpad ? 30 : 24, weight: .heavy))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: isIpad ? ScreenSize.screenWidth/2.25 : ScreenSize.screenWidth/2.38, height: isIpad ? ScreenSize.screenHeight/10 : ScreenSize.screenHeight/10)
                        })
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(10)
                    .alert(isPresented: showAlert, content: {
                        if countDownTimer.wrappedValue != 0 {
                            if answer.wrappedValue == islandController.getIsland().traditionalDance.provinceOrigin {
                                Alert(
                                    title: Text("Selamat!!!"),
                                    message:
                                        Text("Kamu mendapatkan \(islandController.getNewScore()) poin."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                            else {
                                Alert(
                                    title: Text("Oops..."),
                                    message:
                                        Text("Kamu masih kurang beruntung."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                        }
                        else{
                            Alert(
                                title: Text("Waktu Habis!"),
                                message: Text("Kamu tidak menjawab dalam waktu yang ditentukan."),
                                dismissButton: .default(Text("Lihat penjelasan")) {
                                    navToAnswerDescriptionView.wrappedValue = true
                                }
                            )
                        }
                    })
                    .fullScreenCover(isPresented: $navToAnswerDescriptionView, content: {
                        AnswerDescriptionView()
                    })
                }
            }
            else {
                ForEach(islandController.getIsland().traditionalLanguage.provinceOptions,  id: \.self) { provinceOption in
                    Button(
                        action: {
                            answer.wrappedValue = provinceOption
                            islandController.checkTheAnswer(word: answer.wrappedValue, currentIsland: ModelData.shared.currentIsland, currentGame: ModelData.shared.currentGame, timer: countDownTimer.wrappedValue)
                            showAlert.wrappedValue = true
                            timerRunning.wrappedValue = false
                        },
                        label: {
                            Text(provinceOption)
                                .font(.system(size: isIpad ? 30 : 24, weight: .heavy))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: isIpad ? ScreenSize.screenWidth/2.4 : ScreenSize.screenWidth/2.38, height: isIpad ? ScreenSize.screenHeight/10 : ScreenSize.screenHeight/10)
                        })
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(10)
                    .alert(isPresented: $showAlert, content: {
                        if countDownTimer.wrappedValue != 0 {
                            if answer.wrappedValue == islandController.getIsland().traditionalLanguage.provinceOrigin {
                                Alert(
                                    title: Text("Selamat!!!"),
                                    message:
                                        Text("Kamu mendapatkan \(islandController.getNewScore()) poin."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                            else {
                                Alert(
                                    title: Text("Oops..."),
                                    message:
                                        Text("Kamu masih kurang beruntung."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                        }
                        else{
                            Alert(
                                title: Text("Waktu Habis!"),
                                message: Text("Kamu tidak menjawab dalam waktu yang ditentukan."),
                                dismissButton: .default(Text("Lihat penjelasan")) {
                                    navToAnswerDescriptionView.wrappedValue = true
                                }
                            )
                        }
                    })
                    .fullScreenCover(isPresented: navToAnswerDescriptionView, content: {
                        AnswerDescriptionView()
                    })
                }
            }
        }
        .padding(.horizontal, isIpad ? ScreenSize.screenWidth/25 : 24)
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/50 : 15)
    }
    
    private func poinStatus(isIpad: Bool) -> some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                        .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                        
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: isIpad ? ScreenSize.screenWidth/1.1 : ScreenSize.screenWidth/1.15, height: isIpad ? ScreenSize.screenHeight/9 : ScreenSize.screenHeight/6)
            .cornerRadius(10)
            .overlay(
                HStack{
                    Spacer()
                    Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
                        .font(.system(size: isIpad ? 25 : 20, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                }
            )
            .padding(.bottom, isIpad ? ScreenSize.screenHeight/120 : ScreenSize.screenHeight/100)
    }
    
    private func knowledgeInformation(isIpad: Bool) -> some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: isIpad ? ScreenSize.screenWidth/1.1 : ScreenSize.screenWidth/1.15, height: isIpad ? ScreenSize.screenHeight/20 : ScreenSize.screenHeight/15)
            .cornerRadius(10)
            .overlay(
                HStack{
                    Spacer()
                    Text("Semakin cepat kamu menjawab, poin mu akan lebih besar lho...")
                        .font(.system(size: isIpad ? 20 : 16, weight: .medium))
                        .italic()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            )
    }
}

#Preview {
    AdditionalQuestionView()
}
