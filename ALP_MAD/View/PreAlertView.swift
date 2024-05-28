//
//  Pre-AlertView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 18/05/24.
//

import SwiftUI

struct PreAlertView: View {
    
    @State private var navToRegisterView = false
    
    var body: some View {
        VStack(alignment: .center) {
            self.setUpPreAlertView(navToRegisterView: $navToRegisterView)
        }
        .padding(.horizontal, 20)
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
    
    private func setUpPreAlertView(navToRegisterView: Binding<Bool>) -> some View {
        VStack{
            self.header()
            self.features()
            self.continueButton(navToRegisterView: navToRegisterView)
        }
    }
    
    private func header() -> some View {
        Text("Izinkan pengumpulan data seperti nama dan foto profil memungkinkan kami menyediakan fitur seperti:")
            .font(UIDevice.current.userInterfaceIdiom == .phone ? .title : .largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 130 : 300)
            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 14 : 0)
    }
    
    private func features() -> some View {
        VStack(alignment: .leading, spacing: UIDevice.current.userInterfaceIdiom == .phone ? 40 : 70) {
            HStack(alignment: .center, spacing: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 30) {
                Image("profilePictureIcon")
                    .resizable()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 80, height: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 80)
                Text("Personalisasi pengalaman pengguna")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 20  : 30))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            HStack(alignment: .center, spacing: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 30) {
                Image("leaderboardIcon")
                    .resizable()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 80, height: UIDevice.current.userInterfaceIdiom == .phone ? 50 : 80)
                Text("Profil pengguna dipajang pada papan peringkat")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 20  : 30))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .phone ? 10 : 0)
        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 130 : 300)
    }
    
    private func continueButton(navToRegisterView: Binding<Bool>) -> some View {
        Button(
            action: {
                navToRegisterView.wrappedValue = true
            },
            label: {
                Text("Selanjutnya")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .phone ? 20 : 24, weight: .heavy))
                    .foregroundColor(Color("redColor(TeWaRa)"))
                    .multilineTextAlignment(.center)
                    .frame(width: UIDevice.current.userInterfaceIdiom == .phone ? 325 : 720, height: UIDevice.current.userInterfaceIdiom == .phone ? 44 : 55)
            })
        .background(
            Color.white
        )
        .cornerRadius(UIDevice.current.userInterfaceIdiom == .phone ? 20 : 30)
        .frame(width: 100, height: 50)
        .shadow(radius: 10, y: 4)
        .fullScreenCover(isPresented: navToRegisterView, content: {
            RegisterView()
        })
    }
}

#Preview {
    PreAlertView()
}
