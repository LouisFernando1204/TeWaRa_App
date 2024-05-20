//
//  HomeView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isClicked: Bool = false
    
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
        })
        
    }
    
    private func showAchievement() -> some View {
        VStack(content: {
            ScrollView {
                VStack(content: {
                    Text("Pencapaian")
                        .bold()
                        .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title3)
                    
                    AchievementRow(currentIsland: ModelData.shared.sumatera)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    Divider()
                        .background(Color.black)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    AchievementRow(currentIsland: ModelData.shared.kalimantan)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    Divider()
                        .background(Color.black)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    AchievementRow(currentIsland: ModelData.shared.sulawesi)
                    Divider()
                        .background(Color.black)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    AchievementRow(currentIsland: ModelData.shared.bali)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    Divider()
                        .background(Color.black)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    AchievementRow(currentIsland: ModelData.shared.java)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    Divider()
                        .background(Color.black)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
                    AchievementRow(currentIsland: ModelData.shared.papua)
                    Spacer()
                        .frame(height: ScreenSize.screenWidth > 600 ? 30 : 10)
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
