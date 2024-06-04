//
//  HomeView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        TabView {
            AnswerDescriptionView()
                .font(.title2)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Beranda")
                }
            AdditionalQuestionView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Perangkat")
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
    HomeView()
}
