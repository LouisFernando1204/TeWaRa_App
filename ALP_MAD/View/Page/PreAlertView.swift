//
//  Pre-AlertView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 18/05/24.
//

import SwiftUI

struct PreAlertView: View {
    
    @State private var navToRegisterView = false
    
    private var screenSize = ScreenSize()
    
    var body: some View {
        
        let isIpad = ScreenSize.screenWidth > 600
        
        VStack(alignment: .center) {
            self.setUpPreAlertView(navToRegisterView: $navToRegisterView, isIpad: isIpad)
        }
        .padding(.horizontal, isIpad ? ScreenSize.screenWidth/30 : ScreenSize.screenWidth/20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.4),
                    .init(color: Color("darkredColor(TeWaRa)"), location: 1.0),
                    
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    private func setUpPreAlertView(navToRegisterView: Binding<Bool>, isIpad: Bool) -> some View {
        VStack{
            self.header(isIpad: isIpad)
            self.features(isIpad: isIpad)
            self.continueButton(navToRegisterView: navToRegisterView, isIpad: isIpad)
        }
    }
    
    private func header(isIpad: Bool) -> some View {
        Text("Izinkan pengumpulan data seperti nama dan foto profil memungkinkan kami menyediakan fitur seperti:")
            .font(isIpad ? .largeTitle : .title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.bottom, isIpad ? ScreenSize.screenHeight/4 : ScreenSize.screenHeight/6)
            .padding(.horizontal,isIpad ? 0 : ScreenSize.screenWidth/30)
    }
    
    private func features(isIpad: Bool) -> some View {
        VStack(alignment: .leading, spacing: isIpad ? ScreenSize.screenHeight/20 : ScreenSize.screenHeight/20) {
            HStack(alignment: .center, spacing: isIpad ? ScreenSize.screenWidth/25 : ScreenSize.screenWidth/20) {
                Image("profilePictureIcon")
                    .resizable()
                    .frame(width: isIpad ? ScreenSize.screenWidth/10 : ScreenSize.screenWidth/6, height: isIpad ? ScreenSize.screenWidth/10 : ScreenSize.screenWidth/6)
                Text("Personalisasi pengalaman pengguna")
                    .font(isIpad ? .title  : .title3)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            HStack(alignment: .center, spacing:  isIpad ? ScreenSize.screenHeight/35 : ScreenSize.screenHeight/40) {
                Image("leaderboardIcon")
                    .resizable()
                    .frame(width: isIpad ? ScreenSize.screenWidth/10 : ScreenSize.screenWidth/6, height: isIpad ? ScreenSize.screenWidth/10 : ScreenSize.screenWidth/6)
                Text("Profil pengguna dipajang pada papan peringkat")
                    .font(isIpad ? .title  : .title3)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, isIpad ? ScreenSize.screenWidth/20 : ScreenSize.screenWidth/15)
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/4 : ScreenSize.screenHeight/7)
    }
    
    private func continueButton(navToRegisterView: Binding<Bool>, isIpad: Bool) -> some View {
        Button(
            action: {
                navToRegisterView.wrappedValue = true
            },
            label: {
                Text("Selanjutnya")
                    .font(isIpad ? .title2 : .headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("redColor(TeWaRa)"))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, isIpad ? ScreenSize.screenHeight/70 : ScreenSize.screenHeight/60)
                    .frame(maxWidth: .infinity)
            })
        .background(
            Color.white
        )
        .cornerRadius(isIpad ? 30 : 25)
        .shadow(radius: 10, y: 4)
        .fullScreenCover(isPresented: navToRegisterView, content: {
            RegisterView()
        })
    }
}

#Preview {
    PreAlertView()
}
