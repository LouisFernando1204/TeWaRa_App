//
//  TouchdownView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI

struct TouchdownView: View {
        
    @State private var isVisible = false
    @State private var countDownTimer = 3
    @State private var timerRunning = false
    @State private var navToAdditionalQuestionView = false
    
    private var screenSize = ScreenSize()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        let isIpad = ScreenSize.screenWidth > 600
        
        self.setUpTouchdownView(isVisible: isVisible, isIpad: isIpad)
    }
    
    private func setUpTouchdownView(isVisible: Bool, isIpad: Bool) -> some View {
        ZStack{
            // Warna background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            // Gradient-Wave pojok kiri atas
            self.topLeadingGradientWave(isVisible: isVisible)
            
            // Gradient-Wave pojok kanan bawah
            self.bottomTrailingGradientWave(isVisible: isVisible)
            
            // Timer
            self.timer(isVisible: isVisible, isIpad: isIpad)
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
        // routing ke question tebak traditionalDance / traditionaLanguage
        .fullScreenCover(isPresented: $navToAdditionalQuestionView, content: {
            AdditionalQuestionView()
        })
    }
    
    private func topLeadingGradientWave(isVisible: Bool) -> some View {
        VStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                HStack {
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 786.01, height: 380.76)
                        .rotationEffect(.degrees(145.74))
                        .offset(x: 0, y: isVisible ? -170 : -250)
                    Spacer()
                }
                Spacer()
            }
            else if UIDevice.current.userInterfaceIdiom == .pad {
                HStack {
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 1200, height: 700)
                        .rotationEffect(.degrees(145.74))
                        .offset(x: -150, y: isVisible ? -200 : -250)
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func bottomTrailingGradientWave(isVisible: Bool) -> some View {
        VStack {
            Spacer()
            if UIDevice.current.userInterfaceIdiom == .phone {
                HStack {
                    Spacer()
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 706, height: 342)
                        .rotationEffect(.degrees(-42.94))
                        .offset(x: 10, y: isVisible ? 90 : 150)
                }
            }
            else if UIDevice.current.userInterfaceIdiom == .pad {
                HStack {
                    Spacer()
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 1200, height: 700)
                        .rotationEffect(.degrees(-42.94))
                        .offset(x: 150, y: isVisible ? 200 : 250)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func timer(isVisible: Bool, isIpad: Bool) -> some View {
        VStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                Text(self.countDownTimer > 0 ? "\(self.countDownTimer)" : "MULAI")
                    .onReceive(timer) { _ in
                        if self.countDownTimer > 0 && self.timerRunning {
                            self.countDownTimer -= 1
                        }
                        else if countDownTimer == 0 {
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
                                .font(.system(size: isVisible ? 70 : 40))
                                .tracking(15)
                                .fontWeight(.black)
                                .multilineTextAlignment(.center)
                        )
                    )
                    .font(.system(size: isVisible ? 70 : 40))
                    .tracking(15)
                    .fontWeight(.black)
            }
            else if UIDevice.current.userInterfaceIdiom == .pad {
                Text(self.countDownTimer > 0 ? "\(self.countDownTimer)" : "MULAI")
                    .onReceive(timer) { _ in
                        if self.countDownTimer > 0 && self.timerRunning {
                            self.countDownTimer -= 1
                        }
                        else if countDownTimer == 0 {
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
                                .font(.system(size: isVisible ? 120 : 20))
                                .tracking(25)
                                .fontWeight(.black)
                                .multilineTextAlignment(.center)
                        )
                    )
                    .font(.system(size: isVisible ? 120 : 20))
                    .tracking(25)
                    .fontWeight(.black)
            }
        }
    }
}

#Preview {
    TouchdownView()
}
