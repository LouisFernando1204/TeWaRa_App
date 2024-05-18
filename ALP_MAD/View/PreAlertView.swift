//
//  Pre-AlertView.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 18/05/24.
//

import SwiftUI

struct PreAlertView: View {
    
    @State private var navToHomeView = false
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Izinkan pengumpulan data seperti nama dan gambar profil memungkinkan kami menyediakan fitur seperti:")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.white)
                .padding(.bottom, 130)
            VStack(alignment: .leading, spacing: 40) {
                HStack(spacing: 20) {
                    Image("profilePictureIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("Personalisasi pengalaman pengguna")
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
                HStack(spacing: 20) {
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
            .padding(.bottom, 130)
            Button(
                action: {
                    self.navToHomeView = true
                },
                label: {
                    Text("Continue")
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
            .fullScreenCover(isPresented: $navToHomeView, content: {
                HomeView()
            })
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
}

#Preview {
    PreAlertView()
}
