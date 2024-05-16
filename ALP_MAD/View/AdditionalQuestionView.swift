//
//  AnswerDescriptionView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct AdditionalQuestionView: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.sulawesi)
    
    @State private var answer : String = ""
    
    @State private var isActive : Bool = false
    
    @State var countDownTimer = 30
    
    @State var timerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                HStack(alignment: .center, content: {
                    Spacer()
                    Text("Bonus")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .font(.headline)
                    Spacer()
                })
                .frame(height: 40)
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
                .padding(.bottom, 20)
                ZStack(alignment: .center, content: {
                    Image("backgroundTimer")
                        .resizable()
                        .frame(width:342, height: 175)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("orangeColor(TeWaRa)")]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                        )
                        .cornerRadius(10)
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 334, height: 168)
                        .cornerRadius(6)
                    
                    Text("00:00:\(countDownTimer)")
                        .onReceive(timer) { _ in
                            if countDownTimer > 0 && timerRunning {
                                countDownTimer -= 1
                            }
                            else {
                                timerRunning = false
                            }
                        }
                        .font(.system(size: 44, weight: .black))
                })
                .padding(.bottom, 10)
                HStack(alignment: .center){
                    Text("Budaya tersebut berasal dari provinsi...")
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 17)
                LazyVGrid(columns: columns, spacing: 10) {
                    if ModelData.shared.currentGame == "Traditional Dance" {
                        ForEach(islandController.getIsland().traditionalDance.provinceOptions,  id: \.self) { provinceOption in
                            ZStack(alignment: .center){
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(10)
                                    .frame(width: 164, height: 87)
                                    .onTapGesture(perform: {
                                        islandController.checkTheAnswer(word: answer, currentGame: ModelData.shared.currentGame)
                                    })
                                Text(provinceOption)
                                    .font(.system(size: 24, weight: .heavy))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    else {
                        ForEach(islandController.getIsland().traditionalLanguage.provinceOptions,  id: \.self) { provinceOption in
                            ZStack(alignment: .center){
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .cornerRadius(10)
                                    .frame(width: 164, height: 87)
                                    .onTapGesture(perform: {
                                        islandController.checkTheAnswer(word: answer, currentGame: ModelData.shared.currentGame)
                                    })
                                Text(provinceOption)
                                    .font(.system(size: 24, weight: .heavy))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 30)
            Rectangle()
                .fill(Color("redColor(TeWaRa)"))
                .frame(width: 340, height: 50)
                .cornerRadius(10)
                .overlay(
                    HStack{
                        Spacer()
                        Text("+20 POIN jika jawabanmu benar!!!")
                            .font(.system(size: 16, weight: .medium))
                            .italic()
                            .foregroundColor(.white)
                        Spacer()
                    }
                )
        }
        .safeAreaInset(edge: .top) {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                    
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 70)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -70)
        }
        .onAppear{
            timerRunning = true
        }
    }
}

#Preview {
    AdditionalQuestionView()
}
