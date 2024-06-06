//
//  LeaderboardRow.swift
//  ALP_MAD
//
//  Created by Radhita Keniten on 01/06/24.
//

import SwiftUI

struct LeaderboardRow: View {
    let rank: Int
    let user: User
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .font(.title2)
                .fontWeight(.bold)
            
            Image(user.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text("Skor: \(user.score)")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Image(systemName: "trophy.fill")
                .foregroundColor(.yellow)
                .opacity(rank <= 3 ? 1 : 0)
        }
        .padding(.vertical, 5)
    }
}


#Preview {
    LeaderboardRow(rank: 3, user: User(name: "Contoh", image: "Contoh", score: 19))
}
