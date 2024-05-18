//
//  TraditionalLanguageView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 18/05/24.
//

import SwiftUI

struct TraditionalLanguageView: View {
    
    @State private var textFieldValue: String = ""
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController(traditionalLanguage: ModelData.shared.bali.traditionalLanguage)
    
    var body: some View {
        ScrollView {
            VStack(content: {
                
                self.topNavigationBar()
                
                VStack(content: {
                    self.showQuestion()
                    
                    HStack(content: {
                        VStack(content: {
                            self.imageAndTextfield()
                        })
                        
                        VStack(content: {
                            self.showClueAndTimer()
                            self.buttonCheckAnswer()
                        })
                    })
                    
                })
                .padding(.horizontal, 20)
                
                
            })
            
            .onAppear {
                timerRunning = true
            }
        }
//        .safeAreaInset(edge: .top) {
//            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
//                           startPoint: .leading,
//                           endPoint: .trailing
//            )
//            .frame(height: 70)
//            .edgesIgnoringSafeArea(.top)
//            .padding(.bottom, -70)
//        }
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
                .frame(width: 56)
            
            Text("Tebak Bahasa")
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
//        .background(
//            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
//                           startPoint: .leading,
//                           endPoint: .trailing
//            )
//            .frame(width: .infinity)
//        )
    }
    
    private func showQuestion() -> some View {
        HStack(content: {
            Text("'\(ModelData.shared.bali.traditionalLanguage.sentences)' merupakan bahasa daerah...")
                .font(.title)
                .fontWeight(.bold)
        })
    }
    
    private func imageAndTextfield() -> some View {
        VStack(content: {
            Image(ModelData.shared.bali.traditionalLanguage.image)
                .resizable()
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius:5)
                .padding(.bottom, 10)
            
            TextField("Masukkan jawabanmu...", text: $textFieldValue)
                .padding()
                .frame(width: 300, height: 40)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing),
                            lineWidth: 2
                        )
                )
                
            
            Spacer().frame(height: 20)
        })
        .padding(.top, 10)
        
    }
    
    private func showClueAndTimer() -> some View {
        VStack(content: {
            ZStack {
                Rectangle()
                    .clipShape(RoundedRectangle(cornerRadius: 14.0))
                    .frame(height: 200)
                    .foregroundColor(.secondary.opacity(0.2))
                    .overlay(
                        VStack(content: {
                            Text("Petunjuk")
                                .fontWeight(.semibold)
                                .font(.title3)
                            
                            Text("'\(ModelData.shared.bali.traditionalLanguage.clue)'")
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding(.vertical, 4)
                                .overlay {
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 118/255, green: 20/255, blue: 20/255)]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing
                                    )
                                }
                                .mask(
                                    Text("'\(ModelData.shared.bali.traditionalLanguage.clue)'")
                                        .multilineTextAlignment(.center)
                                        .fontWeight(.bold)
                                        .font(.title3)
                                )
                            
                            
                            Text("Ayo-ayo kamu pasti bisa!!!")
                                .fontWeight(.regular)
                                .font(.headline)
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
                                            .font(.headline)
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
                    .frame(width: 100, height: 36)
                    .offset(y: 94)
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
                            .offset(y: 94)
                            .fontWeight(.regular)
                            .font(.title3)
                            .foregroundColor(Color.white)
                    }
            }
            
//            Spacer().frame(height: 40)
        })
    }
    
    private func buttonCheckAnswer() -> some View {
        Button(action: {
            traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
        }) {
            Text("Cek Jawaban")
                .fontWeight(.bold)
//                .padding(.horizontal, 40)
//                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.red)
                )
                .foregroundColor(.white)
        }
        .shadow(color: .red, radius: 2, y: 2)
        
    }
}



#Preview {
    TraditionalLanguageView()
}
