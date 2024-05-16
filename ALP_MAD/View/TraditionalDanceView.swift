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
    @StateObject private var traditionalLanguageController = TraditionalLanguageController(traditionalLanguage: ModelData.shared.bali.traditionalLanguage)
    private let fixedColumn = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    var body: some View {
        VStack(content: {
            
            self.topNavigationBar()
            self.showQuestion()
            self.showChanceAndAnswerBox()
            self.showWordOptions()
            self.showTimer()
            
        })
        .padding(.horizontal, 20)
        .onAppear {
            timerRunning = true
        }
        
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
            
            Text("Tebak Tarian")
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
                .frame(width: 350, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius:5)
                .padding(.bottom, 20)

        })
    }
    
    private func showChanceAndAnswerBox() -> some View {
        VStack(content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
    
    private func showWordOptions() -> some View {
        VStack(content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
    
    private func showTimer() -> some View {
        VStack(content: {
            /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    TraditionalDanceView()
}
