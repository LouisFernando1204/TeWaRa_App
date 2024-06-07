import SwiftUI

struct LeaderboardRow: View {
    let rank: Int
    let user: User
    let screenSize: CGSize
    
    private func loadImage(named imageName: String) -> NSImage? {
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            return NSImage(contentsOfFile: imagePath.path)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        HStack {
            if user.name == ModelData.shared.currentUser.name {
                if let image = loadImage(named: user.image) {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.trailing, 6)
                        .overlay(
                            Group {
                                if rank == 1 {
                                    Image("1stRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                } else if rank == 2 {
                                    Image("2ndRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                } else if rank == 3 {
                                    Image("3rdRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                }
                            }
                        )
                }
            } else {
                ZStack(alignment: .bottomTrailing) {
                    Image(user.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                        .overlay(
                            Group {
                                if rank == 1 {
                                    Image("1stRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                } else if rank == 2 {
                                    Image("2ndRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                } else if rank == 3 {
                                    Image("3rdRanking")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 30, y: 30)
                                }
                            }
                        )
                }
                .frame(width: 120, height: 120)
            }
            
            Text(user.name)
                .font(.largeTitle)
                .foregroundStyle(Color(red: 220/255, green: 38/255, blue: 38/255))
                .fontWeight(.bold)
                .padding(.leading, 100)
            
            Spacer()
            
            Text("\(user.score) poin")
                .font(.largeTitle)
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(red: 220/255, green: 38/255, blue: 38/255),
                            Color(red: 251/255, green: 146/255, blue: 60/255)
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .fontWeight(.semibold)
        }
        .padding(.vertical, 5)
    }
}

//#Preview {
//    LeaderboardRow(rank: 3, user: User(name: "Contoh", image: "Contoh", score: 19))
//}
