//
//  ContentView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct ContentView: View {
    
<<<<<<< HEAD
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case leaderboard
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                    // Label("Home", image: "person1")
                }
                .tag(Tab.home)
            
            
            LeaderboardView()
                .tabItem {
                    Image(systemName: "rank")
                    Text("Leaderboard")
                    // Label("Leaderboard", image: "person2")
                }
                .tag(Tab.leaderboard)
            
        }
        
=======
    @State private var isAccess = false
    
    var body: some View {
        Group {
            if self.isAccess {
                PreAlertView()
                    .transition(.opacity)
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.isAccess = true
                }
            }
        }
>>>>>>> Louis
    }
}

#Preview {
    ContentView()
}
