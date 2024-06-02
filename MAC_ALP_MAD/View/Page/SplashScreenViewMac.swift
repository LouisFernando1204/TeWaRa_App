//
//  SplashScreenView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI

struct SplashScreenViewMac: View {
    
    @State private var isVisible = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenSize = geometry.size
                
                ZStack {
                    // Warna background
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    // Gradient-Wave pojok kiri atas
                    self.topLeadingGradientWave(isVisible: isVisible, screenSize: screenSize)
                    
                    // Gradient-Wave pojok kanan bawah
                    self.bottomTrailingGradientWave(isVisible: isVisible, screenSize: screenSize)
                    
                    // Logo
                    self.logo(isVisible: isVisible, screenSize: screenSize)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isVisible = true
                    }
                }
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
                    .offset(x: -screenSize.width/3.8, y: isVisible ? -screenSize.height/2.6 : -screenSize.height/2)
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
    
    private func logo(isVisible: Bool, screenSize: CGSize) -> some View {
        VStack {
            Spacer()
            Image("logo(TeWaRa)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isVisible ? screenSize.width/2 : screenSize.width/10, height: isVisible ? screenSize.height/5 : screenSize.height/10)
                .padding(.bottom, 10)
            Text("TEBAK WAWASAN")
                .font(.system(size: screenSize.width/50, weight: .bold))
                .multilineTextAlignment(.center)
                .tracking(4)
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
                        Text("TEBAK WAWASAN")
                            .font(.system(size: screenSize.width/50, weight: .bold))
                            .tracking(4)
                            .multilineTextAlignment(.center)
                            .opacity(isVisible ? 1.0 : 0)
                    )
                )
            Text("NUSANTARA")
                .font(.system(size: screenSize.width/25, weight: .bold))
                .multilineTextAlignment(.center)
                .tracking(4)
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
                        Text("NUSANTARA")
                            .font(.system(size: screenSize.width/25, weight: .bold))
                            .tracking(4)
                            .multilineTextAlignment(.center)
                            .opacity(isVisible ? 1.0 : 0)
                    )
                )
                .padding(.top, -10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
}

#Preview {
    SplashScreenView()
}
