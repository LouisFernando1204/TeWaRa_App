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
    
    @State private var selectedIsland: Island
    @State private var avPlayer = AVPlayer()
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
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
            self.traditionalDanceController.changeDance(dance: ModelData.shared.currentIslandObject.traditionalDance)
        }
        .safeAreaInset(edge: .top) {
            CustomGradient.redOrangeGradient
                .frame(height: ScreenSize.screenWidth > 600 ? 32: 70)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, ScreenSize.screenWidth > 600 ? -40 : -70)
            
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
                        }
                }
            }
        })
        .padding(.bottom)
    }
    
    private func showTimer() -> some View {
        TimerComponent(type: "Tarian")
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
                    .fontWeight(.regular)
                    .font(ScreenSize.screenWidth > 600 ? .title : .title2)
                    .foregroundColor(Color.white)
            }
    }
}

#Preview {
    TraditionalDanceView(selectedIsland: ModelData.shared.bali)
}
