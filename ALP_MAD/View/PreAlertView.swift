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
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.bottom, 130)
            .padding(.horizontal, 14)
    }
    
    private func features() -> some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack(alignment: .center, spacing: 20) {
                Image("profilePictureIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Personalisasi pengalaman pengguna")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            HStack(alignment: .center, spacing: 20) {
                Image("leaderboardIcon")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Profil pengguna dipajang pada papan peringkat")
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 130)
    }
    
    private func continueButton(navToRegisterView: Binding<Bool>) -> some View {
        Button(
            action: {
                navToRegisterView.wrappedValue = true
            },
            label: {
                Text("Selanjutnya")
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundColor(Color("redColor(TeWaRa)"))
                    .multilineTextAlignment(.center)
                    .frame(width: 325, height: 44)
            })
        .background(
            Color.white
        )
        .cornerRadius(20)
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
