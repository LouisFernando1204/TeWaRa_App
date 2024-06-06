import SwiftUI

struct LeaderboardView: View {
    @StateObject private var controller: LeaderboardController = LeaderboardController()
    let islands = ["Sumatera", "Kalimantan", "Papua", "Java", "Bali", "Sulawesi"]
    @State private var arrIsland: [Island] = []
    
    var body: some View {
        ZStack {
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Image("gradientWave(TeWaRa)")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth * 3 : 786.01,
//                               height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 2 : 380.76)
//                        .rotationEffect(.degrees(-42.94))
//                        .offset(x: ScreenSize.screenWidth > 600 ? 140 : 10,
//                                y: ScreenSize.screenWidth > 600 ? 160 : 90)
//                }
//            }
//            .frame(maxWidth: ScreenSize.screenWidth * 2, maxHeight: ScreenSize.screenHeight)
            
            VStack {
                TopNavigationBar(name: "Peringkat", message: "Home")
                ScrollView {
                    VStack {
                        VStack {
                            if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.kalimantan).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.sumatera).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else if  ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.sulawesi).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.bali).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.java).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.papua).first == 0 {
                                Text("Selamat!!!")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            else {
                                Text("Oopss..")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                Text("Tetap semangat! Anda masih belum menguasai pulau apapun")
                                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            
                            
                            if arrIsland.count > 0 {
                                ForEach(arrIsland.indices, id: \.self) { index in
                                    let island = arrIsland[index]
                                    if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: island).first == 0 {
                                        HStack {
                                            Spacer()
                                            Text("Kamu menguasai")
                                                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                                .fontWeight(.light)
                                                .foregroundColor(.white)
                                            
                                            Text("Pulau \(island.islandName)")
                                                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, ScreenSize.screenWidth > 600 ? 30 : 20)
                        .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 10)
                        .background(ButtonColor.redButton)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        
                        Spacer().frame(height: 20)
                        
                        ForEach(islands, id: \.self) { island in
                            showLeaderboard(for: island)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, ScreenSize.screenWidth > 600 ? 30 : 20)
                    .padding(.vertical, ScreenSize.screenWidth > 600 ? 16 : 10)
                }
            }
            .onAppear {
                controller.rearrangeIsland()
                arrIsland = [
                    ModelData.shared.papua,
                    ModelData.shared.java,
                    ModelData.shared.kalimantan,
                    ModelData.shared.sulawesi,
                    ModelData.shared.sumatera,
                    ModelData.shared.bali
                ]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                }
            }
            .onDisappear {
                MusicPlayer.shared.stopBackgroundMusic()
            }
        }
    }
    
    private func showLeaderboard(for islandName: String) -> some View {
        let island = controller.getIsland(islandName: islandName)
        let topUsers = controller.getTopThreeUsers(for: islandName)
        
        return VStack {
            HStack {
                Text("Pulau \(island.islandName)")
                    .bold()
                    .font(ScreenSize.screenWidth > 600 ? .largeTitle : .title2)
                    .padding(.horizontal, ScreenSize.screenWidth > 600 ? 20 : 0)
                Spacer()
            }
            
            ScrollView {
                VStack {
                    ForEach(topUsers.indices, id: \.self) { index in
                        let user = topUsers[index]
                        LeaderboardRow(rank: index + 1, user: user)
                        if (index + 1) % 3 != 0 {
                            Divider().background(Color.black)
                            Spacer().frame(height: ScreenSize.screenWidth > 600 ? 20 : 10)
                        }
                    }
                }
                .padding(.horizontal, ScreenSize.screenWidth > 600 ? 20 : 0)
            }
            .frame(height: ScreenSize.screenWidth > 600 ? 460 : 210)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

#Preview {
    LeaderboardView()
}
