//
//  LeaderboardView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct LeaderboardView: View {
    @StateObject private var controller = LeaderboardController()
    @State private var leaderboard: Leaderboard?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Selamat!!!")
                        .font(.title)
                        .padding(.top, 16)
                    
                    if let topIsland = topIsland {
                        Text("Kamu menguasai \(topIsland.islandName)")
                            .font(.headline)
                            .padding(.bottom, 16)
                    }
                    
                    ForEach(islands, id: \.islandName) { island in
                        LeaderboardCard(island: island)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
            }
            .navigationTitle("Peringkat")
        }
        .onAppear {
            leaderboard = controller.getLeaderboard()
        }
    }
    
    private var islands: [Island] {
        guard let leaderboard = leaderboard else { return [] }
        return [
            leaderboard.sumatera,
            leaderboard.kalimantan,
            leaderboard.papua,
            leaderboard.java,
            leaderboard.bali,
            leaderboard.sulawesi
        ]
    }
    
    private var topIsland: Island? {
        // Implement logic to determine the top island
        return nil
    }
}

struct LeaderboardCard: View {
    let island: Island
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(island.islandName)
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(island.userList, id: \.name) { user in
                LeaderboardRow(user: user)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct LeaderboardRow: View {
    let user: User
    
    var body: some View {
        HStack {
            Image(user.image)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                Text("\(user.score) poin")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    LeaderboardView()
}
