import SwiftUI

struct LeaderboardRow: View {
    let rank: Int
    let user: User
    
    private func loadImage(named imageName: String) -> UIImage? {
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        return UIImage(contentsOfFile: imagePath.path)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        HStack {
            if user.name == ModelData.shared.currentUser.name {
                if let image = loadImage(named: user.image) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ScreenSize.screenWidth > 600 ? 120 : 50, height: ScreenSize.screenWidth > 600 ? 120 : 50)
                        .clipShape(Circle())
                        .padding(.trailing, ScreenSize.screenWidth > 600 ? 10 : 0)
                        .overlay(
                            Group {
                                if rank == 1 {
                                    Image("1stRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                } else if rank == 2 {
                                    Image("2ndRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                } else if rank == 3 {
                                    Image("3rdRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                }
                            }
                        )
                }
            } else {
                ZStack(alignment: .bottomTrailing) {
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ScreenSize.screenWidth > 600 ? 120 : 50, height: ScreenSize.screenWidth > 600 ? 120 : 50)
                        .clipShape(Circle())
                        .padding(.trailing, ScreenSize.screenWidth > 600 ? 10 : 0)
                        .overlay(
                            Group {
                                if rank == 1 {
                                    Image("1stRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                } else if rank == 2 {
                                    Image("2ndRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                } else if rank == 3 {
                                    Image("3rdRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: ScreenSize.screenWidth > 600 ? 75 : 35, height: ScreenSize.screenWidth > 600 ? 75 : 35)
                                        .offset(x: ScreenSize.screenWidth > 600 ? 30 : 15, y: ScreenSize.screenWidth > 600 ? 30 : 15)
                                }
                            }
                        )
                }
                .frame(width: ScreenSize.screenWidth > 600 ? 120 : 50, height: ScreenSize.screenWidth > 600 ? 120 : 50)
            }
            
            Text(user.name)
                .font(ScreenSize.screenWidth > 600 ? .title : .title3)
                .foregroundStyle(ButtonColor.redButton) 
                .fontWeight(.bold)
                .padding(.leading, ScreenSize.screenWidth/90)
            
            Spacer()
            
            Text("\(user.score) poin")
                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                .foregroundStyle(CustomGradient.redOrangeGradient)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    LeaderboardRow(rank: 3, user: User(name: "Contoh", image: "Contoh", score: 19))
}
