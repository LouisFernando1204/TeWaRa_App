//
//  ContentView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct ContentView: View {
    
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
        
    }
}

#Preview {
    ContentView()
}
