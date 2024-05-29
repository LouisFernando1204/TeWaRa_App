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
        
        let isIpad = self.screenSize.screenWidth > 600
        
        VStack(alignment: .center) {
            self.setUpPreAlertView(navToRegisterView: $navToRegisterView, isIpad: isIpad)
        }
        .padding(.horizontal, isIpad ? self.screenSize.screenWidth/30 : self.screenSize.screenWidth/20)
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
            .padding(.bottom, isIpad ? self.screenSize.screenHeight/4 : self.screenSize.screenHeight/6)
            .padding(.horizontal,isIpad ? 0 : self.screenSize.screenWidth/30)
    }
    
    private func features(isIpad: Bool) -> some View {
        VStack(alignment: .leading, spacing: isIpad ? self.screenSize.screenHeight/20 : self.screenSize.screenHeight/20) {
            HStack(alignment: .center, spacing: isIpad ? self.screenSize.screenWidth/25 : self.screenSize.screenWidth/20) {
                Image("profilePictureIcon")
                    .resizable()
                    .frame(width: isIpad ? self.screenSize.screenWidth/10 : self.screenSize.screenWidth/6, height: isIpad ? self.screenSize.screenWidth/10 : self.screenSize.screenWidth/6)
                Text("Personalisasi pengalaman pengguna")
                    .font(isIpad ? .title  : .title3)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            HStack(alignment: .center, spacing:  isIpad ? self.screenSize.screenHeight/35 : self.screenSize.screenHeight/40) {
                Image("leaderboardIcon")
                    .resizable()
                    .frame(width: isIpad ? self.screenSize.screenWidth/10 : self.screenSize.screenWidth/6, height: isIpad ? self.screenSize.screenWidth/10 : self.screenSize.screenWidth/6)
                Text("Profil pengguna dipajang pada papan peringkat")
                    .font(isIpad ? .title  : .title3)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, isIpad ? self.screenSize.screenWidth/20 : self.screenSize.screenWidth/15)
        .padding(.bottom, isIpad ? self.screenSize.screenHeight/4 : self.screenSize.screenHeight/7)
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
                    .padding(.vertical, isIpad ? self.screenSize.screenHeight/70 : self.screenSize.screenHeight/60)
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
