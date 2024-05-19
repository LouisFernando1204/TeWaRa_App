//
//  TraditionalDanceView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 18/05/24.
//

import SwiftUI
import AVKit

struct TraditionalDanceView: View {
    
    @State private var avPlayer = AVPlayer()
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalDanceController = TraditionalDanceController(traditionalDance: ModelData.shared.bali.traditionalDance)
    private let fixedColumn = [
        GridItem(.fixed(54)),
        GridItem(.fixed(54)),
        GridItem(.fixed(54)),
        GridItem(.fixed(54))
    ]
    
    var body: some View {
        
        VStack(content: {
            
            self.topNavigationBar()
            
            VStack(content: {
                self.showQuestionAndChance()
                
                HStack(content: {
                    self.imageAndAnswerBox()
                    
                    VStack(content: {
                        self.showWordOptions()
                        
                        self.showTimer()
                    })
                })
                
            })
            .padding()
            
            
        })
        .onAppear {
            timerRunning = true
        }
        .safeAreaInset(edge: .top) {
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing
            )
            .frame(height: 32)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -10)
        }
    }
    
    private func topNavigationBar() -> some View {
        HStack(content: {
            
            Spacer()
                .frame(width: 20)
            
            NavigationLink(
                destination: TraditionalLanguageView()) {
                    HStack(spacing: 4, content: {
                        Image("backIconWhite")
                        
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                }
            
            Spacer()
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.title2)
            
            Spacer()
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .opacity(0)
                .foregroundColor(.white)
                .font(.headline)
            
            
//            Rectangle()
//                .background(.orange)
//                .opacity(0)
//                .frame(height: 36)
//
            Spacer()
                .frame(width: 20)
        })
        .padding(.bottom)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing
            )
        )
    }
    
    private func showQuestionAndChance() -> some View {
        HStack(content: {
            Text("Tari tradisional dari Pulau '\(ModelData.shared.bali.islandName)' adalah...")
                .font(.title)
                .fontWeight(.bold)
        })
    }
    
    private func imageAndAnswerBox() -> some View {
        VStack(content: {
            Image(ModelData.shared.bali.traditionalLanguage.image)
                .resizable()
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius:5)
                .padding(.bottom, 10)
            
            HStack(content: {
                // buat if kalau ndak null countnya/panjangnya
                ForEach(ModelData.shared.sumatera.traditionalDance.throwableAnswer.indices, id: \.self) { index in
                    let alphabet = ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].alphabet
                    if(!ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].isClicked) {
                        Rectangle()
                            .frame(width: 44, height:44)
                            .foregroundColor(.secondary)
                            .opacity(0.2)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
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
                            .frame(width: 44, height: 44)
                            .foregroundColor(.secondary)
                            .opacity(0.2)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                                       startPoint: .leading,
                                                       endPoint: .trailing),
                                        lineWidth: 2
                                    )
                            )
                    }
                }
            })
            .padding(.bottom)
            
        })
        .padding(.leading)
//
    }
    
    private func showWordOptions() -> some View {
        VStack(content: {
            LazyVGrid(columns: fixedColumn, spacing: 20) {
                ForEach(ModelData.shared.bali.traditionalDance.availableWords.indices, id:\.self) { index in
                    let item = ModelData.shared.bali.traditionalDance.availableWords[index]
                    if (!ModelData.shared.bali.traditionalDance.availableWords[index].isClicked) {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .overlay {
                                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 118/255, green: 20/255, blue: 20/255)]),
                                               startPoint: .leading,
                                               endPoint: .trailing
                                )
                            }
                            .overlay(
                                Text(item.alphabet)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                            )
                            .cornerRadius(10)
                            .onTapGesture(perform: {
                                traditionalDanceController.guessWord(word: item, remainingTime: countdownTimer)
                            })
                    }
                    else {
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        })
    }
    
    private func showTimer() -> some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                 startPoint: .leading,
                                 endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .frame(width: 100, height: 42)
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
                    .font(.title3)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical)
    }
}

#Preview {
    TraditionalDanceView()
}
