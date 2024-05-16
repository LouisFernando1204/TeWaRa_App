//
//  TraditionalLanguageView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct TraditionalLanguageView: View {
    
    @State private var textFieldValue: String = ""
    @State private var countdownTimer: Int = 30
    @State private var timerRunning: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @StateObject private var traditionalLanguageController = TraditionalLanguageController(traditionalLanguage: ModelData.shared.bali.traditionalLanguage)
    
    var body: some View {
        VStack(content: {
            
            self.topNavigationBar()
            self.questionAndTextfield()
            self.showClueAndTimer()
            self.buttonCheckAnswer()
            
        })
        .padding(.horizontal, 20)
        
    }
    
    private func topNavigationBar() -> some View {
        HStack(content: {
            NavigationLink(
                destination: Text("Destination")) {
                    HStack(spacing: 4, content: {
                        Image("backIcon")
                            
                            
                        Text("Pulau")
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .font(.headline)
                    })
                }
            
            Spacer()
            
            Text("Tebak Bahasa")
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .font(.headline)
            
            Spacer()
            
            Rectangle()
                .fill(.white)
                .frame(width: 10, height: 36)
            
            Spacer()
        })
        .padding(.bottom, 10)
    }
    
    private func questionAndTextfield() -> some View {
        VStack(content: {
            HStack(content: {
                Text("'\(ModelData.shared.bali.traditionalLanguage.sentences)' merupakan bahasa daerah...")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            })
            
            Image(ModelData.shared.bali.traditionalLanguage.image)
                .resizable()
                .frame(width: 350, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .padding(.bottom, 20)
            
            TextField("Masukkan jawabanmu...", text: $textFieldValue)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing),
                            lineWidth: 2
                        )
                )
            
            Spacer().frame(height: 20)
        })
        
    }
    
    private func showClueAndTimer() -> some View {
        VStack(content: {
            ZStack {
                Rectangle()
                    .clipShape(RoundedRectangle(cornerRadius: 14.0))
                    .frame(height: 190)
                    .foregroundColor(.secondary.opacity(0.2))
                    .overlay(
                        VStack(content: {
                            Text("Petunjuk")
                                .fontWeight(.semibold)
                                .font(.headline)
                            
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
                                .padding(.bottom)
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
                                            .padding(.bottom)
                                    )
                                }
                            
                        })
                        .padding(.horizontal, 10)
                    )
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                         startPoint: .leading,
                                         endPoint: .trailing))
                    .clipShape(RoundedRectangle(cornerRadius: 14.0))
                    .frame(width: 120, height: 46)
                    .offset(y: 94)
                    .overlay {
                        Text("\(countdownTimer) detik")
                            .onReceive(timer, perform: { _ in
                                if (countdownTimer > 0 && timerRunning) {
                                    countdownTimer -= 1
                                }
                                else {
                                    timerRunning = false
                                }
                            })
                            .offset(y: 94)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
            }
            
            Spacer().frame(height: 40)
        })
    }
    
    private func buttonCheckAnswer() -> some View {
        Button(action: {}) {
            Text("Cek Jawaban")
                .fontWeight(.bold)
                .padding(.horizontal, 120)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(35)
        }
        .controlSize(.extraLarge)
        .shadow(color: .red, radius: 2, y: 2)
    }
}

#Preview {
    TraditionalLanguageView()
}
