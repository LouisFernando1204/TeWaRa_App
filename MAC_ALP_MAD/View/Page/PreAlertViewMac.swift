//
//  PreAlertView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI

struct PreAlertViewMac: View {
    
    @State private var navToRegisterView = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let screenSize = geometry.size
                
                VStack(alignment: .center) {
                    self.setUpPreAlertView(screenSize: screenSize)
                }
                .padding(.horizontal, screenSize.width / 50)
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
                    .edgesIgnoringSafeArea(.all) // Pastikan GeometryReader mengambil seluruh area layar
                )
                .navigationDestination(isPresented: $navToRegisterView) {
                    RegisterViewMac()
                }
            }
            .edgesIgnoringSafeArea(.all) // Pastikan GeometryReader mengambil seluruh area layar
        }
    }
    
    private func setUpPreAlertView(screenSize: CGSize) -> some View {
        VStack {
            self.header(screenSize: screenSize)
            self.features(screenSize: screenSize)
            self.continueButton(screenSize: screenSize)
                .padding(.horizontal, screenSize.width / 100)
        }
    }
    
    private func header(screenSize: CGSize) -> some View {
        Text("Izinkan pengumpulan data seperti nama dan foto profil memungkinkan kami menyediakan fitur seperti:")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.bottom, screenSize.height / 4)
    }
    
    private func features(screenSize: CGSize) -> some View {
        VStack(alignment: .leading, spacing: screenSize.height / 15) {
            HStack(alignment: .center, spacing: screenSize.width / 35) {
                Image("profilePictureIcon")
                    .resizable()
                    .frame(width: screenSize.width / 15, height: screenSize.width / 15)
                Text("Personalisasi pengalaman pengguna")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
            }
            HStack(alignment: .center, spacing: screenSize.width / 35) {
                Image("leaderboardIcon")
                    .resizable()
                    .frame(width: screenSize.width / 15, height: screenSize.width / 15)
                Text("Profil pengguna dipajang pada papan peringkat")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, screenSize.height / 4)
    }
    
    private func continueButton(screenSize: CGSize) -> some View {
        Button(
            action: {
                navToRegisterView = true
            },
            label: {
                Text("Selanjutnya")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("redColor(TeWaRa)"))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, screenSize.height / 60)
                    .frame(maxWidth: .infinity)
            }
        )
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 10, y: 4)
    }
}

#Preview {
    PreAlertViewMac()
}
