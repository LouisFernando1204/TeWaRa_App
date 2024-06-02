//
//  HomeView.swift
//  MAC_ALP_MAD
//
//  Created by MacBook Pro on 20/05/24.
//

import SwiftUI

struct HomeViewMac: View {
    
    private func loadImage(named imageName: String) -> NSImage? {
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        return NSImage(contentsOfFile: imagePath.path)
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        ZStack(content: {
            VStack {
                HStack {
                    Image("gradientWave(TeWaRa)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 586.01, height: 380.76)
                        .rotationEffect(.degrees(145.74))
                        .offset(x: -120, y: -140)
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
                        .frame(width: 586.01, height:380.76)
                        .rotationEffect(.degrees(-42.94))
                        .offset(x: 170, y: 110)
                }

                
                
            }
//            .frame(maxWidth: ScreenSize.screenWidth * 2 , maxHeight: ScreenSize.screenHeight)
            
            VStack(content: {
                self.showDetailProfile()
                self.showDetailIsland()
                self.showButton()
            })
            .padding(.horizontal)
            .padding(.vertical)
        })
    }
    
    private func showDetailIsland() -> some View {
        HStack(content: {
            VStack(content: {
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.sumatera)
                Spacer()
                    .frame(height: 8)
                Divider()
                    .background(Color.gray)
                    .frame(width: 250)
                    .opacity(0.5)
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.kalimantan)
                Spacer()
                    .frame(height: 8)
                Divider()
                    .background(Color.gray)
                    .frame(width: 250)
                    .opacity(0.5)
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.sulawesi)
                Spacer()
                    .frame(height: 8)
                
            })
            VStack(content: {
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.bali)
                Spacer()
                    .frame(height: 8)
                Divider()
                    .background(Color.gray)
                    .frame(width: 250)
                    .opacity(0.5)
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.java)
                Spacer()
                    .frame(height: 8)
                Divider()
                    .background(Color.gray)
                    .frame(width: 250)
                    .opacity(0.5)
                Spacer()
                    .frame(height: 8)
                self.islandRowMaker(currentIsland: ModelData.shared.papua)
                Spacer()
                    .frame(height: 8)
            })
        })
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.vertical, 8)
    }
    
    private func islandRowMaker(currentIsland: Island) -> some View {
        HStack(content: {
            Spacer()
            Image(currentIsland.islandImage)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 10)
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau \(currentIsland.islandName)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .overlay {
                            CustomGradient.redOrangeGradient
                            .mask(
                                Text("Pulau \(currentIsland.islandName)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                        .font(.caption)
                    Spacer()
                })
                .padding(.bottom, 3)
                HStack(spacing: 0, content: {
                    HStack(content: {
                        Text("-20 poin")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.gray)
                            .italic()
                            .opacity(0.8)
                            .font(.caption2)
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.caption2)
                    })
                    
                    Spacer()
                })
            })
            
        })
        
    }
    
    private func showButton() -> some View {
        Rectangle()
            .fill(ButtonColor.redButton)
            .cornerRadius(10)
            .frame(height: 40)
            .overlay {
                Text("MULAI GAME")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
//            .onTapGesture {
//                traditionalLanguageController.guessWord(word: textFieldValue, remainingTime: countdownTimer)
//            }
    }
    
    private func showDetailProfile() -> some View {
        VStack(content: {
            HStack(content: {
                
                if let image = loadImage(named: ModelData.shared.currentUser.image) {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                }

                
                VStack(content: {
                    
                    HStack(content: {
                        Text("Hi, Radhita Lope! ")
                            .fontWeight(.bold)
                            .font(.title2)
                            .overlay {
                                CustomGradient.redDarkRedGradient
                            }
                            .mask(
                                Text("Hi, Radhita Lope! ")
                                    .fontWeight(.bold)
                                    .font(.title2)
                            )
                        
                        Spacer()
                    })
                    
                    HStack(content: {
                        HStack(spacing: 0, content: {
                            Text("Welcome back to ")
                                .fontWeight(.medium)
                                .font(.headline)
                            
                            Text("TeWaRa")
                                .font(.headline)
                                .fontWeight(.medium)
                                .overlay {
                                    CustomGradient.redOrangeGradient
                                    .mask(
                                        Text("TeWaRa")
                                            .font(.headline)
                                            .fontWeight(.medium)
                                    )
                                }
                            
                            
                            Text("!")
                                .font(.headline)
                        })
                        .padding(.bottom, 2)
                        
                        Spacer()
                        
                    })
                    
                    HStack(content: {
                        Text("Total poin: 100")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Spacer()
                    })
                })
                
            })
            .frame(height:80)
            
//            .frame(width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.3 : ScreenSize.screenWidth * 0.8, height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 6 : 130)
            .padding(.horizontal, 10)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            
        })
    }
}

#Preview {
    HomeViewMac()
}
