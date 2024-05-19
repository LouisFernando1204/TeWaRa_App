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
    
    @State private var avPlayer = AVPlayer()
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalDanceController = TraditionalDanceController(traditionalDance: ModelData.shared.bali.traditionalDance)
    
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
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
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
                .padding(.horizontal, 
                         self.screenWidth > 600 ? 90 : 20)
                .padding(.vertical, self.screenWidth > 600 ? 16 : 6)
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
            .frame(height: self.screenWidth > 600 ? 32: 70)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, self.screenWidth > 600 ? -40 : -70)

        }
    }
    
    private func topNavigationBar() -> some View {
        
        HStack(content: {
            
            Spacer()
            
            NavigationLink(
                destination: IslandView()) {
                    HStack(spacing: 4, content: {
                        Image("backIconWhite")
                        
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(self.screenWidth > 600 ? .title : .headline)
                    })
                }
            
            Spacer()
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(self.screenWidth > 600 ? .title : .system(size: 6))
                .opacity(0)
            
            Spacer()
//                .frame(width: 56)
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(self.screenWidth > 600 ? .title : .headline)
            
            Spacer()
            
            Text("Tebak Tarian")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(self.screenWidth > 600 ? .title : .system(size: 6))
                .opacity(0)
            
            Spacer()

            NavigationLink(
                destination: {}) {
                    HStack(spacing: 4, content: {
                        Image("backIconWhite")
                            .opacity(0)
                        
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .font(self.screenWidth > 600 ? .title : .headline)
                            .opacity(0)
                    })
                }
            
            Spacer()
            
        })
        .padding(.bottom, self.screenWidth > 600 ? 20 : 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing
                          )
            .frame(width: self.screenWidth)
        )
    }
    
    private func showQuestion() -> some View {
        VStack(content: {
            HStack(content: {
                Text("Tari tradisional dari Pulau \(ModelData.shared.bali.islandName) yaitu...")
                    .font(self.screenWidth > 600 ? .system(size: 38) : .title2)
                    .fontWeight(.bold)
                Spacer()
                
            })
                        
            Image(ModelData.shared.bali.traditionalDance.image)
                .resizable()
                .frame(
                    width: self.screenWidth > 600 ? self.screenWidth / 1.3 : self.screenWidth / 1.1,
                    height: self.screenWidth > 600 ? screenHeight / 3 : screenHeight / 4
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .padding(.bottom, self.screenWidth > 600 ? 8 : 12)
            
        })
        .padding(.top, self.screenWidth > 600 ? 0 : 10)
    }
    
    private func showChanceAndAnswerBox() -> some View {

        VStack(content: {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                     startPoint: .leading,
                                     endPoint: .trailing))
                .clipShape(
                    self.screenWidth > 600 ? RoundedRectangle(cornerRadius: 35) : RoundedRectangle(cornerRadius: 25.0)
                )
                .frame(
                    width: self.screenWidth > 600 ? self.screenWidth / 1.8 : self.screenWidth / 1.14,
                    height: self.screenHeight / 18
                )
                .overlay {
                    Text("Kesempatan kamu kurang 3x")
                        .fontWeight(.medium)
                        .font(self.screenWidth > 600 ? .title : .headline)
                        .foregroundColor(Color.white)
                }
            
            HStack(content: {
                // buat if kalau ndak null countnya/panjangnya
                ForEach(ModelData.shared.sumatera.traditionalDance.throwableAnswer.indices, id: \.self) { index in
                    let alphabet = ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].alphabet
                    if(!ModelData.shared.sumatera.traditionalDance.throwableAnswer[index].isClicked) {
                        Rectangle()
                            .frame(
                                width: self.screenWidth > 600 ? self.screenWidth / 10 : self.screenWidth / 8,
                                height: self.screenWidth > 600 ? self.screenWidth / 10 : self.screenWidth / 8
                            )
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
                            .padding(.horizontal, self.screenWidth > 600 ? 10 : 1)
                            .padding(.vertical)
                    }
                    else {
                        Rectangle()
                            .frame(
                                width: self.screenWidth > 600 ? self.screenWidth / 10 : self.screenWidth / 8,
                                height: self.screenWidth > 600 ? self.screenWidth / 10 : self.screenWidth / 8
                            )
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
                            .padding(.horizontal, self.screenWidth > 600 ? 10 : 1)
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
                            .frame(
                                width: self.screenWidth > 600 ? self.screenWidth / 9 : self.screenWidth / 8,
                                height: self.screenWidth > 600 ? self.screenWidth / 9 : self.screenWidth / 8
                            )
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
                            .frame(
                                width: self.screenWidth > 600 ? self.screenWidth / 9 : self.screenWidth / 8,
                                height: self.screenWidth > 600 ? self.screenWidth / 9 : self.screenWidth / 8
                            )
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
            .frame(
                width: self.screenWidth > 600 ? self.screenWidth / 5 : self.screenWidth / 3,
                height: self.screenWidth > 600 ? self.screenWidth / 18 : self.screenWidth / 10
            )
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
                    .font(self.screenWidth > 600 ? .title : .title2)
                    .foregroundColor(Color.white)
            }
    }
}

#Preview {
    TraditionalDanceView()
}
