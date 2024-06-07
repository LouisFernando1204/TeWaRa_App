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
//        IslandView()
    }
}

#Preview {
    ContentView()
}
