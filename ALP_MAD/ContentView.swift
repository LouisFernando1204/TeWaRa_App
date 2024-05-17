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
                    Label("Home", image: "person1")
                }
                .tag(Tab.home)
            
            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", image: "person2")
                }
                .tag(Tab.leaderboard)
            
        }
    }
}

#Preview {
    ContentView()
}
