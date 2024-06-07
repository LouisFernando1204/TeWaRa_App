//
//  TabViewRouter.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 04/06/24.
//

import SwiftUI

struct TabViewRouter: View {
    var body: some View {
        TabView {
            HomeView()
                .font(.title2)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Beranda")
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Peringkat")
                }
        }
        .accentColor(Color("redColor(TeWaRa)"))
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color.white.opacity(0.05))
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    TabViewRouter()
}
