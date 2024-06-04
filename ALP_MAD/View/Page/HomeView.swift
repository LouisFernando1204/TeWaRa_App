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
    
}

#Preview {
    HomeView()
}
