//
//  TraditionalDanceView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
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
        GridItem(.fixed(70)),
        GridItem(.fixed(70)),
        GridItem(.fixed(70)),
        GridItem(.fixed(70))
    ]
    
    var body: some View {
        
        ScrollView {
            VStack(content: {
                
                self.topNavigationBar()
                
                VStack(content: {
                    self.showQuestion()
                    self.showChanceAndAnswerBox()
                    self.showWordOptions()
                    self.showTimer()
                })
                .padding(.horizontal, 20)
            })
            .onAppear {
                timerRunning = true
            }
        }
        .safeAreaInset(edge: .top) {
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing
            )
            .frame(height: 70)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -70)
        }
    }
    
    private func topNavigationBar() -> some View {
        HStack(content: {
            
            Spacer()
                .frame(width: 20)
            
            NavigationLink(
                destination: IslandView()) {
                    HStack(spacing: 4, content: {
                        Image("backIconWhite")
                        
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                }
            
            Spacer()
                .frame(width: 56)
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.headline)
            
            Spacer()
            
            //            Rectangle()
            //                .background(.orange)
            //                .opacity(0)
            //                .frame(height: 36)
            //
            //            Spacer()
        })
        .padding(.bottom, 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing
                          )
            .frame(width: .infinity)
        )
    }
    
    private func showQuestion() -> some View {
        VStack(content: {
            HStack(content: {
                Text("Tari tradisional dari Pulau \(ModelData.shared.bali.islandName) yaitu...")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            })
            
            Image(ModelData.shared.bali.traditionalDance.image)
                .resizable()
                .frame(width: 350, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .padding(.bottom, 12)
            
        })
        .padding(.top, 10)
    }
    
    private func showChanceAndAnswerBox() -> some View {
        VStack(content: {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .frame(width: 280, height: 44)
                .overlay {
                    Text("Kesempatan kamu kurang 3x")
                        .fontWeight(.medium)
                        .font(.headline)
                        .foregroundColor(Color.white)
                }
            
            HStack(content: {
                // buat if kalau ndak null countnya/panjangnya
                ForEach(ModelData.shared.sumatera.traditionalDance.throwableAnswer.indices, id: \.self) { index in
                    let alphabet = ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].alphabet
                    if(!ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].isClicked) {
                        Rectangle()
                            .frame(width: 50, height: 50)
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
                            .padding(.horizontal, 1)
                            .padding(.vertical)
                    }
                    else {
                        Rectangle()
                            .frame(width: 50, height: 50)
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
                            .padding(.horizontal, 1)
                            .padding(.vertical)
                    }
                }
            })
        })
    }
    
    private func showWordOptions() -> some View {
        VStack(content: {
            LazyVGrid(columns: fixedColumn, spacing: 20) {
                ForEach(ModelData.shared.bali.traditionalDance.availableWords.indices, id:\.self) { index in
                    let item = ModelData.shared.bali.traditionalDance.availableWords[index]
                    if (!ModelData.shared.bali.traditionalDance.availableWords[index].isClicked) {
                        Rectangle()
                            .frame(width: 55, height: 55)
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
                            .padding(.horizontal, 3)
                            .onTapGesture(perform: {
                                traditionalDanceController.guessWord(word: item, remainingTime: countdownTimer)
                            })
                    }
                    else {
                        Rectangle()
                            .frame(width: 55, height: 55)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 3)
                    }
                }
            }
        })
        .padding(.bottom)
    }
    
    private func showTimer() -> some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                 startPoint: .leading,
                                 endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 14.0))
            .frame(width: 120, height: 46)
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
    }
}

#Preview {
    TraditionalDanceView()
}
