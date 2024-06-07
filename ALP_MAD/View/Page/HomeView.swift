//
//  HomeView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isClicked: Bool = false
    @StateObject private var homeController: HomeController = HomeController()
    
    var body: some View {
        
        ZStack(content: {
    
            VStack {
                HStack {
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth * 3: 786.01, height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 2 : 380.76)
                        .rotationEffect(.degrees(145.74))
                        .offset(x: ScreenSize.screenWidth > 600 ? -100 : 0, y: ScreenSize.screenWidth > 600 ? -180 : -170)
                    Spacer()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth * 3: 786.01, height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 2 : 380.76)
                        .rotationEffect(.degrees(-42.94))
                        .offset(x: ScreenSize.screenWidth > 600 ? 140 : 10, y: ScreenSize.screenWidth > 600 ? 160 :  90)
                }
            }
            .frame(maxWidth: ScreenSize.screenWidth * 2 , maxHeight: ScreenSize.screenHeight)
            .onAppear {
                homeController.rearrangeIsland()
            }
            
            VStack(content: {
                ProfileComponent(currentUser: ModelData.shared.currentUser)
                Spacer()
                    .frame(height: 40)
                self.showAchievement()
                Spacer()
                    .frame(height: 40)
                ButtonCheck(action: {self.isClicked = true}, message: "MULAI GAME")
            })
            .frame(width: ScreenSize.screenWidth * 0.9)
            .padding(.horizontal, 20)
            .fullScreenCover(isPresented: $isClicked) {
                IslandView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                }
            }
            .onDisappear {
                MusicPlayer.shared.stopBackgroundMusic()
            }
            .onChange(of: self.isClicked) { oldValue, newValue in
                if newValue {
                    MusicPlayer.shared.stopBackgroundMusic()
                } else {
                    MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 1)
                }
            }
        })
    }
    
    private func ProfileComponent(currentUser: User) -> some View {
        VStack(content: {
            HStack(content: {
                
                Spacer()

                if let image = loadImage(named: currentUser.image) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: ScreenSize.screenWidth > 600 ? 120 : 80, height: ScreenSize.screenWidth > 600 ? 120 : 80)
                        .clipShape(Circle())
                        .padding(.leading, ScreenSize.screenWidth > 600 ? 20 : 0)
                }
                    
                
                VStack(content: {
                    
                    HStack(content: {
                        Text("Hi, \(currentUser.name)! ")
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                            .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title3)
                            .overlay {
                                CustomGradient.redDarkRedGradient
                            }
                            .mask(
                                Text("Hi, \(currentUser.name)! ")
                                    .foregroundStyle(Color.black)
                                    .fontWeight(.bold)
                                    .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title3)
                            )
                        
                        Spacer()
                    })
                    
                    HStack(content: {
                        HStack(spacing: 0, content: {
                            Text("Welcome back to ")
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                            
                            Text("TeWaRa")
                                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                .fontWeight(.medium)
                                .overlay {
                                    CustomGradient.redOrangeGradient
                                    .mask(
                                        Text("TeWaRa")
                                            .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                            .fontWeight(.medium)
                                    )
                                }
                            
                            
                            Text("!")
                                .foregroundStyle(Color.black)
                                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                        })
                        .padding(.bottom, 2)
                        
                        Spacer()
                        
                    })
                    
                    HStack(content: {
                        Text("Total poin: \(currentUser.score)")
                            .foregroundStyle(Color.black)
                            .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    })
                })
                .padding(.leading, ScreenSize.screenWidth > 600 ? 20 : 0)
                
            })
            
            .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.3 : ScreenSize.screenWidth * 0.8, height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 6 : 130)
            .padding(.horizontal, ScreenSize.screenWidth > 600 ? 0 : 10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            
        })
    }
    

    
    
    private func showAchievement() -> some View {
        VStack(content: {
            ScrollView {
                VStack(content: {
                    Text("Pencapaian")
                        .bold()
                        .foregroundStyle(Color.black)
                        .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title3)
                    ForEach(homeController.rankedIslands.indices, id:\.self) { index in
                        let island = homeController.rankedIslands[index]
                        AchievementRow(currentIsland: island, status: "Ranked")
                        Spacer()
                            .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                        Divider()
                            .background(Color.black)
                    }
                    ForEach(homeController.progressToRank.indices, id:\.self) { index in
                        let island = homeController.progressToRank[index]
                        AchievementRow(currentIsland: island, status: "Progress")
                        Spacer()
                            .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                        Divider()
                            .background(Color.black)
                    }
                    ForEach(homeController.unfilledIslands.indices, id:\.self) { index in
                        let island = homeController.unfilledIslands[index]
                        AchievementRow(currentIsland: island, status: "Unplayed")
                        Spacer()
                            .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                        Divider()
                            .background(Color.black)
                    }
                })
                .padding(.horizontal)
            }
            .frame(maxHeight: ScreenSize.screenWidth > 600 ? 600 : 350)
            .padding(.vertical)
        })
        .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.3 : ScreenSize.screenWidth * 0.86)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        
    }
    
    private func AchievementRow(currentIsland: Island, status: String) -> some View {
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
                    if status == "Unplayed" {
                        Text("0 poin")
                            .foregroundStyle(Color.black)
                            .font(ScreenSize.screenWidth > 600 ? .title2 : .headline)
                        Spacer()
                    }
                    else if status == "Ranked" || status == "Progress" {
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
                        if status == "Unplayed" {
                            Text("")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.gray)
                                .italic()
                                .opacity(0.8)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if status == "Ranked" {
                            Text("⭐️")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if status == "Progress" {
                            Text("-\(ModelData.shared.getCurrentUserPointByIsland(name: currentIsland.userList[2].name, island: currentIsland)[0] -  ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0]) poin")
                                .foregroundStyle(Color.gray)
                                .fontWeight(.medium)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption2)
                        }
                        
                    })
                    HStack(content: {
                        if status == "Unplayed" {
                            Text("Anda belum memainkan game di pulau ini sama sekali")
                                .foregroundColor(.gray)
                                .italic()
                                .multilineTextAlignment(.leading)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if status == "Ranked" {
                            Text(" Anda menduduki peringkat \(ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0] + 1)!")
                                .foregroundColor(.gray)
                                .italic()
                                .multilineTextAlignment(.leading)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .caption)
                        }
                        else if status == "Progress" {
                            Text(" untuk memasuki peringkat")
                                .foregroundColor(.gray)
                                .italic()
                                .multilineTextAlignment(.leading)
                                .font(ScreenSize.screenWidth > 600 ? .title2 : .system(size: 10))
                        }
                        
                    })
                    
                    Spacer()
                })
            })
            
        })
    }
    
}

#Preview {
    HomeView()
}
