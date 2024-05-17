//
//  HomeView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack(content: {
            
//            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
//                           startPoint: .leading,
//                           endPoint: .trailing
//            )
            
            VStack(content: {
                self.showUserDetail()
                Spacer()
                    .frame(height: 40)
                self.showAchievement()
                Spacer()
                    .frame(height: 40)
                self.showButtonStartGame()
                
            })
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
        })
        
    }
    
    private func showUserDetail() -> some View {
        
        VStack(content: {
            HStack(content: {
                
                Spacer()
                
                Image("person1")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                VStack(content: {
                    
                    HStack(content: {
                        Text("Hi, \(ModelData.shared.currentUser.name)! ")
                            .fontWeight(.bold)
                            .font(.title2)
                            .overlay {
                                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 118/255, green: 20/255, blue: 20/255)]),
                                               startPoint: .leading,
                                               endPoint: .trailing
                                )
                            }
                            .mask(
                                Text("Hi, \(ModelData.shared.currentUser.name)! ")
                                    .fontWeight(.bold)
                                    .font(.title2)
                            )
                        
                        Spacer()
                    })

                    
                    HStack(content: {
                        HStack(spacing: 0, content: {
                            Text("Welcome back to ")
                                .font(.system(size: 18))
                            
                            Text("TeWaRa")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .overlay {
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing
                                    )
                                    .mask(
                                        Text("TeWaRa")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                    )
                                }
                            
                            
                            Text("!")
                                .font(.system(size: 18))
                        })
                        .padding(.bottom, 2)
                        
                        Spacer()
                        
                    })
                    
                    HStack(content: {
                        Text("Total poin: \(ModelData.shared.currentUser.score)")
                            .font(.system(size: 18))
                        
                        Spacer()
                    })
                })
                
            })
            
            .frame(maxWidth: .infinity, maxHeight: 130)
            .padding(.horizontal)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            
        })
        
    }
    
    private func showAchievement() -> some View {
        VStack(content: {
            ScrollView {
                VStack(content: {
                    Text("Pencapaian")
                        .bold()
                        .font(.title3)
                    
                    self.showSumateraAchievement()
                    Divider()
                        .background(Color.black)
                    self.showKalimantanAchievement()
                    Divider()
                        .background(Color.black)
                    self.showSulawesiAchievement()
                    Divider()
                        .background(Color.black)
                    self.showBaliAchievement()
                    Divider()
                        .background(Color.black)
                    self.showJavaAchievement()
                    Divider()
                        .background(Color.black)
                    self.showPapuaAchievement()
                })
                .padding(.horizontal)
            }
            .frame(maxHeight: 350)
            .padding(.vertical)
        })
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        
        
    }
    
    private func showSumateraAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.sumatera.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Sumatera")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Sumatera")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
        
    }
    
    private func showKalimantanAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.kalimantan.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Kalimantan")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Kalimantan")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
    }
    
    private func showSulawesiAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.sulawesi.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Sulawesi")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Sulawesi")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
    }
    
    private func showBaliAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.bali.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Bali")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Bali")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
    }
    
    private func showJavaAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.java.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Jawa")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Jawa")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
    }
    
    private func showPapuaAchievement() -> some View {
        HStack(content: {
            Spacer()
            Image(ModelData.shared.papua.islandImage)
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(content: {
                HStack(content: {
                    Text("Pulau Papua")
                        .font(.title3)
                        .fontWeight(.bold)
                        .overlay {
                            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                                           startPoint: .leading,
                                           endPoint: .trailing
                            )
                            .mask(
                                Text("Pulau Papua")
                                    .font(.title3)
                                    .fontWeight(.bold)
                            )
                        }
                    Spacer()
                })
                HStack(content: {
                    Text("100 poin")
                    
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
                            .font(.system(size: 12))
                    })
                    HStack(content: {
                        Text(" untuk masuk peringkat")
                            .foregroundColor(.gray)
                            .italic()
                            .font(.system(size: 12))
                    })

                    Spacer()
                })
            })
            
        })
    }
    
    private func showButtonStartGame() -> some View {
        Button(action: {
            
        }) {
            Text("MULAI PERMAINAN ")
                .fontWeight(.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .foregroundColor(.white)
                .background(Color(red: 220/255, green: 38/255, blue: 38/255))
                .cornerRadius(16)
                .font(.headline)
        }
        .controlSize(.extraLarge)
        .shadow(color: .red, radius: 2, y: 2)
    }
    
    
}

#Preview {
    HomeView()
}
