//
//  AdditionalQuestionView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//
import SwiftUI

struct AdditionalQuestionView: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    @State private var answer: String = ""
    @State private var showAlert = false
    @State private var navToAnswerDescriptionView = false
    @State private var countDownTimer = 30
    @State private var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                self.setUpAdditionalQuestionView(
                    islandController: islandController,
                    answer: $answer,
                    showAlert: $showAlert,
                    navToAnswerDescriptionView: $navToAnswerDescriptionView,
                    countDownTimer: $countDownTimer,
                    timerRunning: $timerRunning,
                    screenSize: geometry.size
                )
            }
        }
    }
    
    private func setUpAdditionalQuestionView(islandController: IslandController, answer: Binding<String>, showAlert: Binding<Bool>, navToAnswerDescriptionView: Binding<Bool>, countDownTimer: Binding<Int>, timerRunning: Binding<Bool>, screenSize: CGSize) -> some View {
        ScrollView {
            VStack(alignment: .center) {
                self.navigationBar(screenSize: screenSize)
                VStack{
                    self.question(screenSize: screenSize)
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: screenSize.width/50){
                        VStack{
                            self.timer(countDownTimer: countDownTimer, timerRunning: timerRunning, showAlert: showAlert, screenSize: screenSize)
                            self.poinStatus(screenSize: screenSize)
                        }
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                            self.answerOptions(islandController: islandController, navToAnswerDescriptionView: navToAnswerDescriptionView, answer: answer, showAlert: showAlert, timerRunning: timerRunning, countDownTimer: countDownTimer, screenSize: screenSize)
                            self.knowledgeInformation(screenSize: screenSize)
                        }
                    }
                    .padding(.horizontal, screenSize.width/23.95)
                }
                .padding(.vertical, screenSize.width/40)
            }
            .onAppear{
                timerRunning.wrappedValue = true
            }
        }
        .background(Color.white)
        .navigationDestination(isPresented: $navToAnswerDescriptionView) {
            AnswerDescriptionView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 0.3)
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        .onChange(of: self.showAlert) { oldValue, newValue in
            if newValue {
                MusicPlayer.shared.stopBackgroundMusic()
            } else {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 0.3)
            }
        }
    }
    
    private func navigationBar(screenSize: CGSize) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text("Bonus")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(.title)
            Spacer()
        }
        .frame(height: screenSize.height/10)
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
        .padding(.bottom, screenSize.height/30)
    }
    
    private func timer(countDownTimer: Binding<Int>, timerRunning: Binding<Bool>, showAlert: Binding<Bool>, screenSize: CGSize) -> some View {
        ZStack(alignment: .center) {
            Image("backgroundTimer")
                .resizable()
                .frame(width: screenSize.width/2, height: screenSize.height/2.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("orangeColor(TeWaRa)")]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 6
                        )
                )
                .cornerRadius(10)
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .frame(width: screenSize.width/2.08, height: screenSize.height/2.7)
                .cornerRadius(6)
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
                .foregroundColor(.black)
                .font(.system(size: screenSize.width/20))
                .fontWeight(.black)
        }
        .padding(.bottom, screenSize.height/25)
    }
    
    private func question(screenSize: CGSize) -> some View {
        HStack(alignment: .center) {
            Text("Budaya tersebut berasal dari provinsi...")
                .font(.system(size: screenSize.width/50))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding(.bottom, screenSize.height/60)
    }
    
    private func answerOptions(islandController: IslandController, navToAnswerDescriptionView: Binding<Bool>, answer: Binding<String>, showAlert: Binding<Bool>, timerRunning: Binding<Bool>, countDownTimer: Binding<Int>, screenSize: CGSize) -> some View {
        LazyVGrid(columns: columns, spacing: screenSize.height/80) {
            if ModelData.shared.currentGame == "TraditionalDance" {
                ForEach(islandController.getIsland().traditionalDance.provinceOptions, id: \.self) { provinceOption in
                    Button(
                        action: {
                            answer.wrappedValue = provinceOption
                            showAlert.wrappedValue = true
                            islandController.checkTheAnswer(word: answer.wrappedValue, currentIsland: ModelData.shared.currentIsland, currentGame: ModelData.shared.currentGame, timer: countDownTimer.wrappedValue)
                            timerRunning.wrappedValue = false
                        },
                        label: {
                            Text(provinceOption)
                                .font(.system(size: screenSize.width/40, weight: .heavy))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: screenSize.width/5, height: screenSize.height/5.2)
                        })
                    .buttonStyle(PlainButtonStyle())
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
                                return Alert(
                                    title: Text("Selamat!!!"),
                                    message: Text("Kamu mendapatkan \(islandController.getNewScore()) poin."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            } else {
                                return Alert(
                                    title: Text("Oops..."),
                                    message: Text("Kamu masih kurang beruntung."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                        } else {
                            return Alert(
                                title: Text("Waktu Habis!"),
                                message: Text("Kamu tidak menjawab dalam waktu yang ditentukan."),
                                dismissButton: .default(Text("Lihat penjelasan")) {
                                    navToAnswerDescriptionView.wrappedValue = true
                                }
                            )
                        }
                    })
                }
            } else {
                ForEach(islandController.getIsland().traditionalLanguage.provinceOptions, id: \.self) { provinceOption in
                    Button(
                        action: {
                            answer.wrappedValue = provinceOption
                            islandController.checkTheAnswer(word: answer.wrappedValue, currentIsland: ModelData.shared.currentIsland, currentGame: ModelData.shared.currentGame, timer: countDownTimer.wrappedValue)
                            showAlert.wrappedValue = true
                            timerRunning.wrappedValue = false
                        },
                        label: {
                            Text(provinceOption)
                                .font(.system(size: screenSize.width/40, weight: .heavy))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: screenSize.width/5, height: screenSize.height/5.2)
                        })
                    .buttonStyle(PlainButtonStyle())
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
                                return Alert(
                                    title: Text("Selamat!!!"),
                                    message: Text("Kamu mendapatkan \(islandController.getNewScore()) poin."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            } else {
                                return Alert(
                                    title: Text("Oops..."),
                                    message: Text("Kamu masih kurang beruntung."),
                                    dismissButton: .default(Text("Lihat penjelasan")) {
                                        navToAnswerDescriptionView.wrappedValue = true
                                    }
                                )
                            }
                        } else {
                            return Alert(
                                title: Text("Waktu Habis!"),
                                message: Text("Kamu tidak menjawab dalam waktu yang ditentukan."),
                                dismissButton: .default(Text("Lihat penjelasan")) {
                                    navToAnswerDescriptionView.wrappedValue = true
                                }
                            )
                        }
                    })
                }
            }
        }
        .padding(.bottom, screenSize.height/25)
    }
    
    private func poinStatus(screenSize: CGSize) -> some View {
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
            .frame(width: screenSize.width/2, height: screenSize.height/7)
            .cornerRadius(10)
            .overlay(
                HStack {
                    Spacer()
                    Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
                        .font(.system(size: screenSize.width/50, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                }
            )
    }
    
    private func knowledgeInformation(screenSize: CGSize) -> some View {
        Rectangle()
            .fill(Color.gray)
            .frame(width: screenSize.width/2.455, height: screenSize.height/10)
            .cornerRadius(10)
            .overlay(
                HStack {
                    Spacer()
                    Text("Semakin cepat kamu menjawab, poin mu akan lebih besar lho...")
                        .font(.system(size: screenSize.width/50, weight: .medium))
                        .italic()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            )
            .padding(.bottom, screenSize.height/20)
    }
}

#Preview {
    AdditionalQuestionView()
}
