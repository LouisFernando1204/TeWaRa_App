//
//  LeaderboardRowMac.swift
//  MAC_ALP_MAD
//
//  Created by Radhita Keniten on 07/06/24.
//

import SwiftUI

struct LeaderboardRowMac: View {
    let rank: Int
    let user: User
    
    var body: some View {
        HStack {
            // User Image
            ZStack(alignment: .topLeading) {
                Image(user.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(rank == 1 ? Color.yellow : rank == 2 ? Color.gray : rank == 3 ? Color.orange : Color.clear, lineWidth: 2)
                    )
                
                if rank == 1 {
                    Image("gold_medal")
                        .resizable()
                        .frame(width: 32, height: 32)
                } else if rank == 2 {
                    Image("silver_medal")
                        .resizable()
                        .frame(width: 24, height: 24)
                } else if rank == 3 {
                    Image("bronze_medal")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.trailing, 10)
            
            // User Name
            Text(user.name)
                .font(.headline)
                .foregroundColor(.primary) // Use system primary color
                .overlay {
                    CustomGradient.redDarkRedGradient
                }
                .mask(
                    Text("\(user.name)")
                        .fontWeight(.bold)
                        .frame(width: 200)
                )
            
            Spacer()
            
            // User Score
            Text("\(user.score) poin")
                .font(.headline)
                .foregroundColor(.primary) // Use system primary color
                .overlay {
                    CustomGradient.redDarkRedGradient
                }
                .mask(
                    Text("\(user.score) poin")
                )
        }
        .padding(.vertical, 5)
    }
}

