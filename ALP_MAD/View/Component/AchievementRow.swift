//
//  AchievementRow.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct AchievementRow: View {
    
    let currentIsland: Island
    
    var body: some View {
        HStack(content: {
            Spacer()
            Image(currentIsland.islandImage)
                .resizable()
                .frame(width: ScreenSize.screenWidth > 600 ? 140 : 90, height: ScreenSize.screenWidth > 600 ? 140 : 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, ScreenSize.screenWidth > 600 ? 20 : 0)
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau \(currentIsland.islandName)")
                        .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                        .fontWeight(.bold)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Pulau \(currentIsland.islandName)")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                        .font(ScreenSize.screenWidth > 600 ? .title2 : .headline)
                    Spacer()
                })
                .padding(.bottom, 3)
                HStack(spacing: 0, content: {
                    HStack(content: {
                        Text("-20 poin")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.gray)
                            .italic()
                            .opacity(0.8)
                            .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                    })
                    
                    Spacer()
                })
            })
            
        })
        
    }
}
