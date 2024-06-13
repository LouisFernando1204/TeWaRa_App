//
//  LeaderboardViewMac.swift
//  MAC_ALP_MAD
//
//  Created by Radhita Keniten on 07/06/24.
//

import SwiftUI


import SwiftUI

struct LeaderboardViewMac: View {
    @StateObject private var controller = LeaderboardController()
    @State private var selectedIslandIndex = 0
    let islands = ["Sumatera", "Kalimantan", "Papua", "Java", "Bali", "Sulawesi"]

    var body: some View {
        let screenWidth = NSScreen.main?.frame.width ?? 800
        let screenHeight = NSScreen.main?.frame.height ?? 600

        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth > 600 ? screenWidth * 3 : 786.01, height: screenHeight > 600 ? screenHeight / 2 : 380.76)
                        .rotationEffect(.degrees(-42.94))
                        .offset(x: screenWidth > 600 ? 140 : 10, y: screenWidth > 600 ? 160 : 90)
                }
            }
            .frame(maxWidth: screenWidth * 2, maxHeight: screenHeight)
            
            ScrollView(content: {
                VStack(content: {
                    self.topNavigationBar()
                    VStack(content: {
                        // Leaderboard view
                        ForEach(islands, id: \.self) { island in
                            showLeaderboard(for: island)
                        }
                        
                        Spacer()
                            .frame(height: 30)
                    })
                    .frame(width: screenWidth * 0.9)
                    .padding(.horizontal, 20)
                })
            })
        }
    }

    private func showLeaderboard(for islandName: String) -> some View {
        let island = controller.getIsland(islandName)
        let topUsers = controller.getTopThreeUsers(for: islandName)
        let userRank = controller.getUserRank(in: islandName, userName: controller.user.name)
        
        return VStack(content: {
            HStack {
                Text("Pulau \(island!.islandName)")
                    .bold()
                    .font(NSScreen.main?.frame.width ?? 800 > 600 ? .largeTitle : .title3)
                    .padding(.vertical)
            }
            
            ScrollView {
                VStack(content: {
                    ForEach(topUsers.enumerated().map { $0 }, id: \.element.name) { index, user in
                        LeaderboardRowMac(rank: index + 1, user: user)
                        if index != 9 {
                            Divider()
                                .background(Color.black)
                            Spacer()
                                .frame(height: NSScreen.main?.frame.width ?? 800 > 600 ? 20 : 10)
                        }
                    }
                })
                .padding(.horizontal)
            }
            .frame(maxHeight: NSScreen.main?.frame.width ?? 800 > 600 ? 500 : 300)
            .padding(.vertical)
            
        })
        .frame(width: NSScreen.main?.frame.width ?? 800 > 600 ? (NSScreen.main?.frame.width ?? 800) / 1.3 : (NSScreen.main?.frame.width ?? 800) * 0.86)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
    
        private func topNavigationBar() -> some View {
            HStack(content: {
    
                Spacer()
                    .frame(width: 20)
    
                NavigationLink(
                    destination: TraditionalLanguageViewMac()) {
                        HStack(spacing: 4, content: {
                            Image("backIconWhite")
    
                            Text("Pulau")
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .font(.headline)
                        })
                    }
    
                Spacer()
    
                Text("Tebak Tarian")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.title2)
    
                Spacer()
    
                Text("Tebak Tarian")
                    .fontWeight(.semibold)
                    .opacity(0)
                    .foregroundColor(.white)
                    .font(.headline)
    
                Spacer()
                    .frame(width: 20)
            })
            .padding(.bottom)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                               startPoint: .leading,
                               endPoint: .trailing
                )
            )
        }
}

#Preview {
    LeaderboardViewMac()
}
