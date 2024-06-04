//
//  HomeView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 20/05/24.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        var chunks: [[Element]] = []
        for index in stride(from: 0, to: count, by: size) {
            let chunk = Array(self[index..<Swift.min(index + size, count)])
            chunks.append(chunk)
        }
        return chunks
    }
}

struct HomeViewMac: View {
    
    private func loadImage(named imageName: String) -> NSImage? {
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        return NSImage(contentsOfFile: imagePath.path)
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @State private var navToIslandView: Bool = false
    @State private var isClicked: Bool = false
    @StateObject private var homeController: HomeController = HomeController()
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                self.setUpHomeView(screenSize: geometry.size)
            }
            .navigationDestination(isPresented: $navToIslandView) {
                IslandViewMac()
            }
        }
        .onAppear {
            homeController.rearrangeIsland()
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
        
    }
    
    private func setUpHomeView(screenSize: CGSize) -> some View {
        ZStack(content: {
            VStack {
                HStack {
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenSize.width/1, height: screenSize.height/1.5)
                        .rotationEffect(.degrees(145.74))
                        .offset(x: -screenSize.width/3.8, y: -screenSize.height/2.6)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenSize.width/1, height: screenSize.height/1.5)
                        .rotationEffect(.degrees(-39.94))
                        .offset(x: screenSize.width/3.2, y: screenSize.height/6)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(content: {
                self.showDetailProfile(screenSize: screenSize)
                self.showDetailIsland(screenSize: screenSize)
                    .padding(.vertical)
                self.showButton(screenSize: screenSize)
            })
            .padding()
        })
    }
    
    private func showDetailIsland(screenSize: CGSize) -> some View {
        
        HStack {
            ScrollView {
                if homeController.rankedIslands.isEmpty {
                    Text("Pulau yang Sudah Anda Taklukkan")
                        .font(.title)
                        .fontWeight(.bold)
                }
                else {
                    Text("Pulau yang Sudah Anda Taklukkan")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    
                    ForEach(homeController.rankedIslands.indices, id: \.self) { index in
                        let island = homeController.rankedIslands[index]
                        self.islandRowMaker(currentIsland: island, ScreenSize: screenSize, status: "Ranked")
                    }
                }
            }
            .frame(width: screenSize.width/3)
            
            ScrollView {
                if homeController.progressToRank.isEmpty {
                    Text("Pulau yang Sedang Anda Coba Taklukkan...")
                        .font(.title)
                        .fontWeight(.bold)
                }
                else {
                    Text("Pulau yang Sedang Anda Coba Taklukkan...")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)

                    
                    ForEach(homeController.progressToRank.indices, id:\.self) { index in
                        let island = homeController.progressToRank[index]
                        self.islandRowMaker(currentIsland: island, ScreenSize: screenSize, status: "Progress")
                    }
                }
            }
            .frame(width: screenSize.width/3)
            
            ScrollView {
                Text("Pulau yang  Belum Anda Coba Taklukkan...")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                ForEach(homeController.unfilledIslands.indices, id:\.self) {
                    index in
                    let island = homeController.unfilledIslands[index]
                    self.islandRowMaker(currentIsland: island, ScreenSize: screenSize, status: "Unplayed")
                }
            }
            .frame(width: screenSize.width/3)
        }
    }
    
    private func islandRowMaker(currentIsland: Island, ScreenSize: CGSize, status: String) -> some View {
        HStack(content: {
            Spacer()
            Image(currentIsland.islandImage)
                .resizable()
                .frame(width: ScreenSize.width/12, height: ScreenSize.width/12
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, ScreenSize.width/48)
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau \(currentIsland.islandName)")
                        .font(.title)
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Pulau \(currentIsland.islandName)")
                                    .font(.title)
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
                            .font(.title2)
                        Spacer()
                    }
                    else if status == "Ranked" || status == "Progress" {
                        ForEach(currentIsland.userList.indices, id: \.self) { index in
                            let user = currentIsland.userList[index]
                            if user.name == ModelData.shared.currentUser.name {
                                Text("\(user.score) poin")
                                    .foregroundStyle(Color.black)
                                    .font(.title2)

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
                                .font(.title2)

                        }
                        else if status == "Ranked" {
                            Text("⭐️")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.title2)
                        }
                        else if status == "Progress" {
                            Text("-\(ModelData.shared.getCurrentUserPointByIsland(name: currentIsland.userList[2].name, island: currentIsland)[0] -  ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0]) poin")
                                .foregroundStyle(Color.black)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.title2)
                        }
                        
                    })
                    HStack(content: {
                        if status == "Unplayed" {
                            Text("Anda belum memainkan game di pulau ini sama sekali")
                                .foregroundColor(.gray)
                                .italic()
                                .font(.title2)
                        }
                        else if status == "Ranked" {
                            Text(" Anda menduduki peringkat \(ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: currentIsland)[0] + 1)!")
                                .foregroundColor(.gray)
                                .italic()
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                        }
                        else if status == "Progress" {
                            Text(" untuk memasuki peringkat")
                                .foregroundColor(.gray)
                                .italic()
                                .font(.title2)
                        }
                        
                    })
                    
                    Spacer()
                })
            })
//            Spacer()
//                .frame(height: ScreenSize.width > 600 ? 30 : 10)
        })
        
        
    }
    
    private func showButton(screenSize: CGSize) -> some View {
        Rectangle()
            .fill(ButtonColor.redButton)
            .cornerRadius(10)
            .frame(height: screenSize.width/24)
            .overlay {
                Text("MULAI GAME")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.bottom, 10)
            .onTapGesture {
                self.navToIslandView = true
            }
    }
    
    private func showDetailProfile(screenSize: CGSize) -> some View {
        VStack(content: {
            HStack(content: {
                
                if let image = loadImage(named: ModelData.shared.currentUser.image) {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                }
                
                VStack(content: {
                    
                    HStack(content: {
                        Text("Hi \(ModelData.shared.currentUser.name)! ")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .overlay {
                                CustomGradient.redDarkRedGradient
                            }
                            .mask(
                                Text("Hi \(ModelData.shared.currentUser.name)! ")
                                    .fontWeight(.bold)
                                    .font(.largeTitle)
                            )
                        
                        Spacer()
                    })
                    
                    HStack(content: {
                        HStack(spacing: 0, content: {
                            Text("Welcome back to ")
                                .fontWeight(.medium)
                                .font(.title)
                            
                            Text("TeWaRa")
                                .font(.title)
                                .fontWeight(.medium)
                                .overlay {
                                    CustomGradient.redOrangeGradient
                                    .mask(
                                        Text("TeWaRa")
                                            .font(.title)
                                            .fontWeight(.medium)
                                    )
                                }
                            
                            
                            Text("!")
                                .font(.title)
                        })
                        .padding(.bottom, 2)
                        
                        Spacer()
                        
                    })
                    
                    HStack(content: {
                        Text("Total poin: \(ModelData.shared.currentUser.score)")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        Spacer()
                    })
                })
                
            })
            .frame(height: screenSize.width/10)
            .padding(.horizontal, 10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            
        })
    }
}

#Preview {
    HomeViewMac()
}
