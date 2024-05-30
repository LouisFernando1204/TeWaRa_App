//
//  HomeView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                if let userImage = loadImage(named: ModelData.shared.currentUser.image) {
                    Image(nsImage: userImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle().strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                        .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 4
                            )
                        )
                        .padding(.top, 4)
                        .padding(.bottom, 25)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(ModelData.shared.currentUser.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Text(ModelData.shared.currentUser.image)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ForEach(ModelData.shared.currentIslandObject.userList,  id: \.self) { user in
                        if let userImage = loadImage(named: user.image) {
                            Image(nsImage: userImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().strokeBorder(
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                                .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 4
                                    )
                                )
                                .padding(.top, 4)
                                .padding(.bottom, 25)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(user.name)
                        } else {
                            Image(user.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().strokeBorder(
                                        LinearGradient(
                                            gradient: Gradient(stops: [
                                                .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                                                .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 4
                                    )
                                )
                                .padding(.top, 4)
                                .padding(.bottom, 25)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text(user.name)
                        }
                    }
                }
            }
        }
    }
}

private func loadImage(named imageName: String) -> NSImage? {
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
    return NSImage(contentsOfFile: imagePath.path)
}

private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

#Preview {
    HomeView()
}
