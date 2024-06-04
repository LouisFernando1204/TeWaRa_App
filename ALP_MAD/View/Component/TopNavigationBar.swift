//
//  TopNavigationBar.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 19/05/24.
//

import SwiftUI

struct TopNavigationBar : View {
    
    let name: String
    let message: String
    
    @State private var navigate: Bool = false
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Image("backIconWhite")
                
                Text(message)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .font(ScreenSize.screenWidth > 600 ? .title : .headline)
            }
            .onTapGesture {
                self.navigate = true
            }
            .fullScreenCover(isPresented: $navigate) {
                if message == "Home" {
                    TabViewRouter()
                }
                else if message == "Pulau" {
                    IslandView()
                }
            }
            
            Spacer()
            
            Text(name)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(ScreenSize.screenWidth > 600 ? .title : .headline)
            
            Spacer()
            
            NavigationLink(
                destination: EmptyView()) {
                HStack(spacing: 4) {
                    Image("backIconWhite")
                        .opacity(0)
                    
                    Text("Pulau")
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .font(ScreenSize.screenWidth > 600 ? .title : .headline)
                        .opacity(0)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, ScreenSize.screenWidth > 600 ? 20 : 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 38/255, blue: 38/255), Color(red: 251/255, green: 146/255, blue: 60/255)]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .edgesIgnoringSafeArea(.top)
        )
    }
}
