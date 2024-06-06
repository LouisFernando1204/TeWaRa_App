//
//  LeaderboardView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct LeaderboardView: View {
    @StateObject private var controller = LeaderboardController()
    @State private var selectedIslandIndex = 0
    let islands = ["Sumatera", "Kalimantan", "Papua", "Java", "Bali", "Sulawesi"]
    
    var body: some View {
        ScrollView(content: {
            VStack {
                TopNavigationBar(destination: AnyView(IslandView()), name: "Leaderboard")
                
                // Leaderboard view
                ForEach(islands, id: \.self) { island in
                    showLeaderboard(for: island)
                }
                
                Spacer()
                    .frame(height: 30)
            }
            .frame(width: ScreenSize.screenWidth * 0.9)
            .padding(.horizontal, 20)
        })
    }
    
    private func showLeaderboard(for islandName: String) -> some View {
        let island = controller.getIsland(islandName)
        let topUsers = controller.getTopThreeUsers(for: islandName)
        let userRank = controller.getUserRank(in: islandName, userName: controller.user.name)
        
        return VStack(content: {
            HStack {
                Text(island!.islandName)
                    .bold()
                    .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title3)
            }
            
            ScrollView {
                VStack(content: {
                    ForEach(topUsers.enumerated().map { $0 }, id: \.element.name) { index, user in
                        LeaderboardRow(rank: index + 1, user: user)
                        if index != 9 {
                            Divider()
                                .background(Color.black)
                            Spacer()
                                .frame(height: ScreenSize.screenWidth > 600 ? 20 : 10)
                        }
                    }
                })
                .padding(.horizontal)
            }
            .frame(maxHeight: ScreenSize.screenWidth > 600 ? 500 : 300)
            .padding(.vertical)
            
        })
        .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.3 : ScreenSize.screenWidth * 0.86)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

#Preview {
    LeaderboardView()
}
