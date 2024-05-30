//
//  LeaderboardView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var leaderboard: Leaderboard?
    private let controller = LeaderboardController()
    
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
                    }
                }
                .padding()
            }
            .navigationTitle("Peringkat")
        }
        .onAppear {
            leaderboard = controller.loadLeaderboardData()
        }
    }
    
    private var islands: [Island] {
        [
            leaderboard?.sumatera,
            leaderboard?.kalimantan,
            leaderboard?.papua,
            leaderboard?.java,
            leaderboard?.bali,
            leaderboard?.sulawesi
        ].compactMap { $0 }
    }
    
    private var topIsland: Island? {
        islands.max(by: { $0.totalScore < $1.totalScore })
    }
}

struct LeaderboardCard: View {
    let island: Island
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(island.islandName)
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(island.userList) { user in
                LeaderboardRow(user: user)
            }
        }
        .padding()
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
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text("\(user.score) poin")
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LeaderboardView()
}
