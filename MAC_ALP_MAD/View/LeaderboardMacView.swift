import SwiftUI

struct LeaderboardMacView: View {
    @StateObject private var controller: LeaderboardController = LeaderboardController()
    let islands = ["Sumatera", "Kalimantan", "Papua", "Java", "Bali", "Sulawesi"]
    @State private var arrIsland: [Island] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("gradientWave(TeWaRa)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/1, height: geometry.size.height/1.5)
                            .rotationEffect(.degrees(-39.94))
                            .offset(x: geometry.size.width/3.2, y: geometry.size.height/6)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                VStack {
    //                TopNavigationBar(name: "Peringkat", message: "Beranda")
                    ScrollView {
                        VStack {
                            VStack {
                                if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.kalimantan).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.sumatera).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else if  ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.sulawesi).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.bali).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.java).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.papua).first == 0 {
                                    Text("Selamat!!!")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                }
                                else {
                                    Spacer()
                                        .frame(maxWidth: .infinity)
                                    Text("Oops..")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                    Text("Tetap semangat! Anda masih belum menguasai pulau apapun")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Spacer()
                                        .frame(maxWidth: .infinity)

                                }
                                
                                
                                if arrIsland.count > 0 {
                                    ForEach(arrIsland.indices, id: \.self) { index in
                                        let island = arrIsland[index]
                                        if ModelData.shared.getCurrentDetailUserByIsland(name: ModelData.shared.currentUser.name, island: island).first == 0 {
                                            HStack {
                                                Spacer()
                                                Text("Kamu menguasai")
                                                    .font(.title)
                                                    .fontWeight(.light)
                                                    .foregroundColor(.white)
                                                
                                                Text("Pulau \(island.islandName)")
                                                    .font(.title)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 70)
                            .padding(.vertical, 16)
                            .background(Color(red: 220/255, green: 38/255, blue: 38/255))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            
                            Spacer().frame(height: 20)
                            
                            ForEach(islands, id: \.self) { island in
                                showLeaderboard(for: island, ScreenSize: geometry.size)
                                    .padding(.bottom, 10)
                            }
                        }
                        .padding(.horizontal,30)
                        .padding(.vertical, 16)
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
            .background(Color.white)

        }
        .background(Color.white)

    }
    
    private func showLeaderboard(for islandName: String, ScreenSize: CGSize) -> some View {
        let island = controller.getIsland(islandName: islandName)
        let topUsers = controller.getTopThreeUsers(for: islandName)
        
        return VStack {
            HStack {
                Text("Pulau \(island.islandName)")
                    .bold()
                    .font(.largeTitle)
                    .padding(.horizontal, 20)
                    .foregroundStyle(Color.black)
                Spacer()
            }
            
            ScrollView {
                VStack {
                    ForEach(topUsers.indices, id: \.self) { index in
                        let user = topUsers[index]
                        LeaderboardRow(rank: index + 1, user: user, screenSize: ScreenSize)
                        if (index + 1) % 3 != 0 {
                            Divider().background(Color.black)
                            Spacer().frame(height: 20)
                        }
                    }
                }
                .padding(.horizontal, ScreenSize.width > 600 ? 20 : 0)
            }
            .frame(height: ScreenSize.width > 600 ? 460 : 220)
        }
        .padding()
        .padding(.top, ScreenSize.height/120)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

#Preview {
    LeaderboardMacView()
}
