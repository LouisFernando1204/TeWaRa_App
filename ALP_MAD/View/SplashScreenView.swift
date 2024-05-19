//
//  SplashScreenView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 17/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isVisible = false
    
    var body: some View {
        self.setUpSplashScreenView(isVisible: isVisible)
    }
    
    private func setUpSplashScreenView(isVisible: Bool) -> some View {
        ZStack{
            // Warna background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            // Gradient-Wave pojok kiri atas
            self.topLeadingGradientWave(isVisible: isVisible)
            
            // Gradient-Wave pojok kanan bawah
            self.bottomTrailingGradientWave(isVisible: isVisible)
            
            // Logo
            self.logo(isVisible: isVisible)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0)) {
                self.isVisible = true
            }
        }
    }
    
    private func topLeadingGradientWave(isVisible: Bool) -> some View {
        VStack {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func bottomTrailingGradientWave(isVisible: Bool) -> some View {
        VStack {
            Spacer()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(isVisible ? 1 : 0)
    }
    
    private func logo(isVisible: Bool) -> some View {
        VStack {
            Spacer()
            Spacer()
            Image("logo(TeWaRa)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: isVisible ? 235 : 150, height: isVisible ? 214 : 150)
            Spacer()
            Text("TEBAK WAWASAN")
                .font(.system(size: 20, weight: .bold))
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
                            .font(.system(size: 20, weight: .bold))
                            .tracking(4)
                            .multilineTextAlignment(.center)
                            .opacity(isVisible ? 1.0 : 0)
                    )
                )
            Text("NUSANTARA")
                .font(.system(size: 20, weight: .bold))
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
                            .font(.system(size: 20, weight: .bold))
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
