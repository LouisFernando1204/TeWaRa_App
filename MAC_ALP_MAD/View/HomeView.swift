//
//  HomeView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
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
    }
}

#Preview {
    HomeView()
}
