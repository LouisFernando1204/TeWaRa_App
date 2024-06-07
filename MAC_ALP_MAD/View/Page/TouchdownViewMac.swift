//
//  TouchdownView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 31/05/24.
//

import SwiftUI

struct TouchdownViewMac: View {
    
    @State private var isVisible = false
    @State private var countDownTimer = 3
    @State private var timerRunning = false
    @State private var navToAdditionalQuestionView = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                self.setUpTouchdownView(isVisible: isVisible, screenSize: geometry.size)
            }
            .navigationDestination(isPresented: $navToAdditionalQuestionView) {
                AdditionalQuestionViewMac()
            }
        }
    }
    
    private func setUpTouchdownView(isVisible: Bool, screenSize: CGSize) -> some View {
        ZStack{
            // Warna background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            // Gradient-Wave pojok kiri atas
            self.topLeadingGradientWave(isVisible: isVisible, screenSize: screenSize)
            
            // Gradient-Wave pojok kanan bawah
            self.bottomTrailingGradientWave(isVisible: isVisible, screenSize: screenSize)
            
            // Timer
            self.timer(isVisible: isVisible, screenSize: screenSize)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "touchdownMusic", volume: 1)
                self.isVisible = true
                self.timerRunning = true
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        .onChange(of: navToAdditionalQuestionView) { oldValue, newValue in
            MusicPlayer.shared.stopBackgroundMusic()
            if !newValue {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "touchdownMusic", volume: 1)
            }
        }
    }
    
    private func topLeadingGradientWave(isVisible: Bool, screenSize: CGSize) -> some View {
        VStack {
            HStack {
                Image("gradientWave(TeWaRa)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenSize.width/1, height: screenSize.height/1.5)
                    .rotationEffect(.degrees(145.74))
                    .offset(x: -screenSize.width/3.8, y: isVisible ? -screenSize.height/2.25 : -screenSize.height/2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func bottomTrailingGradientWave(isVisible: Bool, screenSize: CGSize) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image("gradientWave(TeWaRa)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenSize.width/1, height: screenSize.height/1.5)
                    .rotationEffect(.degrees(-39.94))
                    .offset(x: screenSize.width/3.2, y: isVisible ? screenSize.height/6 : screenSize.height/4)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func timer(isVisible: Bool, screenSize: CGSize) -> some View {
        VStack {
            Text(self.countDownTimer > 0 ? "\(self.countDownTimer)" : "MULAI")
                .onReceive(timer) { _ in
                    if self.countDownTimer > 0 && self.timerRunning {
                        self.countDownTimer -= 1
                    } else if countDownTimer == 0 {
                        self.timerRunning = false
                        self.navToAdditionalQuestionView = true
                    }
                }
                .foregroundColor(.clear)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                            .init(color: Color("darkredColor(TeWaRa)"), location: 1.0),
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(
                        Text(self.countDownTimer > 0 ? "\(self.countDownTimer)" : "MULAI")
                            .font(.system(size: isVisible ? screenSize.width/15 : screenSize.width/30))
                            .tracking(15)
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                    )
                )
                .font(.system(size: isVisible ? screenSize.width/15 : screenSize.width/30))
                .tracking(15)
                .fontWeight(.black)
        }
    }
}

#Preview {
    TouchdownViewMac()
}
