//
//  ProfileComponent.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 20/05/24.
//

import SwiftUI

struct ProfileComponent: View {
    
    let currentUser: User
    
    private func loadImage(named imageName: String) -> UIImage? {
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        return UIImage(contentsOfFile: imagePath.path)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
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
    
}
