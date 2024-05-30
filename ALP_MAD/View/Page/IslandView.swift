//
//  IslandView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct IslandModel: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct IslandView: View {
    let islands: [IslandModel] = [
        IslandModel(name: "Sumatera", imageName: "sumatera"),
        IslandModel(name: "Jawa", imageName: "jawa"),
        IslandModel(name: "Kalimantan", imageName: "kalimantan"),
        IslandModel(name: "Papua", imageName: "papua"),
        IslandModel(name: "Sulawesi", imageName: "sulawesi"),
        IslandModel(name: "Bali", imageName: "bali")
    ]
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        if ScreenSize.screenWidth > 600 {
            
            VStack(spacing: 0) {
                TopNavigationBar(destination: AnyView(Text("Destination")), name: "Pulau")
                
                Spacer().frame(height: 70)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(islands) { islandModel in
                            NavigationLink(destination: IslandDetailView(island: islandModel)) {
                                ZStack(alignment: .bottom) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                                                    Color(red: 118/255, green: 20/255, blue: 20/255)  // #761414
                                                ]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .frame(height: 250)
                                    
                                    VStack {
                                        Image(islandModel.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding([.leading, .trailing], 10)
                                            .padding(.bottom, 40)
                                        Text(islandModel.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 20)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                    .padding()
                }
                
                BottomBar()
            }
        } else {
            NavigationView {
                VStack(spacing: 0) {
                    TopNavigationBar(destination: AnyView(Text("Destination")), name: "Pulau")
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(islands) { islandModel in
                                NavigationLink(destination: IslandDetailView(island: islandModel)) {
                                    ZStack(alignment: .bottom) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [
                                                        Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                                                        Color(red: 118/255, green: 20/255, blue: 20/255)  // #761414
                                                    ]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .frame(height: 180)
                                        
                                        VStack {
                                            Image(islandModel.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 140)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding([.leading, .trailing], 10)
                                            Text(islandModel.name)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding(.bottom, 10)
                                        }
                                    }
                                    .padding()
                                }
                            }
                        }
                        .padding()
                    }
                    
                    BottomBar()
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct BottomBar: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                        Color(red: 251/255, green: 146/255, blue: 60/255) // #FB923C
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 50)
            .padding(.horizontal, -20)
            .padding(.bottom, -35)
    }
}

struct IslandDetailView: View {
    let island: IslandModel
    
    var body: some View {
        Text("Details for \(island.name)")
            .font(.largeTitle)
    }
}

struct IslandView_Previews: PreviewProvider {
    static var previews: some View {
        IslandView()
    }
}
