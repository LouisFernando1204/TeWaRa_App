//
//  LeaderboardRow.swift
//  ALP_MAD
//
//  Created by Radhita Keniten on 01/06/24.
//

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
                        .frame(width: ScreenSize.screenWidth > 600 ? 120 : 50, height: ScreenSize.screenWidth > 600 ? 120 : 50)
                        .clipShape(Circle())
                        .padding(.trailing, ScreenSize.screenWidth > 600 ? 10 : 0)
                }
            }
            else {
                Image(user.image)
                    .resizable()
                    .frame(width: ScreenSize.screenWidth > 600 ? 120 : 50, height: ScreenSize.screenWidth > 600 ? 120 : 50)
                    .clipShape(Circle())
                    .padding(.trailing, ScreenSize.screenWidth > 600 ? 10 : 0)
            }
                        
            Text(user.name)
                .font(ScreenSize.screenWidth > 600 ? .title : .title3)
                .foregroundStyle(ButtonColor.redButton)
                .fontWeight(.bold)
                
            
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
