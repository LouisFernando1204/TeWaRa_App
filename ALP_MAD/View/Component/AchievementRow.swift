//
//  AchievementRow.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct AchievementRow: View {
    
    let currentIsland: Island
    let status: String
    
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
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Pulau \(currentIsland.islandName)")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .foregroundStyle(Color.black)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    if self.status == "Unplayed" {
                        Text("0 poin")
                            .foregroundStyle(Color.black)
                            .font(ScreenSize.screenWidth > 600 ? .title2 : .headline)
                        Spacer()
                    }
                    else if self.status == "Ranked" || self.status == "Progress" {
                        ForEach(currentIsland.userList.indices, id: \.self) { index in
                            let user = currentIsland.userList[index]
                            if user.name == ModelData.shared.currentUser.name {
                                Text("\(user.score) poin")
                                    .foregroundStyle(Color.black)
                                    .font(ScreenSize.screenWidth > 600 ? .title2 : .headline)
                                Spacer()
                            }
                        }
                        
                    }
                    
                })
                .padding(.bottom, 3)
                HStack(spacing: 0, content: {
                    HStack(content: {
                        if self.status == "Unplayed" {
                            Text("")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.gray)
                                .italic()
                                .opacity(0.8)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if self.status == "Ranked" {
                            Text("⭐️")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if self.status == "Progress" {
                            Text("-\(ModelData.shared.getCurrentUserPointByIsland(name: currentIsland.userList[2].name, island: currentIsland)[0] -  ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0]) poin")
                                .foregroundStyle(Color.gray)
                                .fontWeight(.medium)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption2)
                        }
                        
                    })
                    HStack(content: {
                        if self.status == "Unplayed" {
                            Text("Anda belum memainkan game di pulau ini sama sekali")
                                .foregroundColor(.gray)
                                .italic()
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if self.status == "Ranked" {
                            Text(" Anda menduduki peringkat \(ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0] + 1)!")
                                .foregroundColor(.gray)
                                .italic()
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if self.status == "Progress" {
                            Text(" untuk memasuki peringkat")
                                .foregroundColor(.gray)
                                .italic()
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .system(size: 10))
                        }
                        
                    })
                    
                    Spacer()
                })
            })
            
        })
        
    }
}
